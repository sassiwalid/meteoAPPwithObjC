//
//  ViewController.m
//  MeteoApp
//
//  Created by MacBook Pro on 20/02/2017.
//  Copyright © 2017 MacBook Pro. All rights reserved.
//
#import "AFNetworking.h"
#import <ChameleonFramework/Chameleon.h>
#import "MainViewController.h"
#import "DetailsViewController.h"
#import "Observation.h"
#import "WeatherTVCell.h"
#import "Constantes.h"

@implementation MainViewController

@synthesize tempLabel;
@synthesize weatherLabel;
@synthesize weatherImageView;
@synthesize dataDictionary;
@synthesize observationArray;
@synthesize tableView;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    dataDictionary = [[NSDictionary alloc] init];
    [self getData];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    [self updateUI];
}

#pragma mark - Consume web service
-(void)getData {
    NSLog(@"getData");
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager GET:@"http://api.openweathermap.org/data/2.5/forecast/daily?q=Paris&appid=7861e4359f70ee319865c215da704b1e"
      parameters:nil
        progress:nil
         success:^(NSURLSessionTask *task, id responseObject) {
             NSLog(@"Success");
             dataDictionary = (NSDictionary *)responseObject;
             // parse Data
             NSLog(@"Success Cast");
             dispatch_async(dispatch_get_main_queue(), ^{
                 // Update the UI
                 NSLog(@"Back to MainThrread Cast");
                [self parseData];
                [self updateUI];
             });
    }
         failure:^(NSURLSessionTask *operation, NSError *error) {
             NSLog(@"Error: %@", error);
             dispatch_async(dispatch_get_main_queue(), ^{
                 [self updateUI];
             });
         }];
    NSLog(@" END getData");
}

#pragma mark - Parse data
-(void) parseData
{
    NSLog(@"parseData");
    RLMRealm *realm = [RLMRealm defaultRealm];
    [realm beginWriteTransaction];
    NSArray *resultList = dataDictionary[@"list"];
    if (resultList.count > 0 ) {
        [realm deleteAllObjects];
        for (NSDictionary *dict in resultList)
        {
            Observation *myObservation = [[Observation alloc] init];
            NSString *KL = [NSString stringWithFormat:@"%@",dict[@"temp"][@"day"]];
            NSArray *temp = dict[@"weather"];
            // conversion from Kelvin to celsuis
            myObservation.temperatureDescription = [NSString stringWithFormat:@"%d°",(int)round([KL intValue]-273.15)];
            myObservation.weatherDescription = temp[0][@"description"];
            myObservation.iconUrl = temp[0][@"icon"];
            // load icon weather async
//            NSData * data = [[NSData alloc] initWithContentsOfURL: [NSURL URLWithString: [NSString stringWithFormat:@"%@%@%@",
//                                                                    ICON_API_URL,myObservation.iconUrl,@".png"]]];
            // save icon image localy
//            [self saveIcon:[UIImage imageWithData:data] :myObservation.iconUrl];
            NSLog(@"Object added");
            [realm addObject:myObservation];
        }
    [realm commitWriteTransaction];
    }
}

#pragma mark - save and load  image in the App directory
- (void)saveIcon:(UIImage*)image :(NSString*)name
{
    if (image != nil)
    {
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,
                                                             NSUserDomainMask, YES);
        NSString *documentsDirectory = [paths objectAtIndex:0];
        NSString* path = [documentsDirectory stringByAppendingPathComponent:
                          [NSString stringWithFormat: @"%@.png",name]];
        NSData* data = UIImagePNGRepresentation(image);
        [data writeToFile:path atomically:YES];
        NSLog(@"saved");
    }
}

- (UIImage*)loadImage:(NSString*)name
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,
                                                         NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString* path = [documentsDirectory stringByAppendingPathComponent:
                      [NSString stringWithFormat: @"%@.png",name] ];
    UIImage *image = [UIImage imageWithContentsOfFile:path];
    return image;
}

#pragma mark - Manage Data and UI
// update the UI
-(void) updateUI
{
// Update the UI for the First Day
    NSLog(@"BEFORE [Observation allObjects]");
    observationArray = [Observation allObjects];
    NSLog(@"AFTER [Observation allObjects]   :: %ld", observationArray.count);
    if (observationArray.count > 0) {
        Observation *myFirstObservation = [observationArray objectAtIndex:0];
        weatherLabel.text = myFirstObservation.weatherDescription;
        tempLabel.text = [NSString stringWithFormat:@"%@", myFirstObservation.temperatureDescription];
        weatherImageView.image =  [self loadImage:myFirstObservation.iconUrl];
    }
    // reload data in the table view
    [tableView reloadData];
    NSLog(@"END updateUI");
}

#pragma mark - UITableView Delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return observationArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    WeatherTVCell *cell = (WeatherTVCell *)[self.tableView dequeueReusableCellWithIdentifier:@"Cell"];
    Observation *tempObservation = [observationArray objectAtIndex:indexPath.row];
    [cell configureCellWithObservation:tempObservation];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self performSegueWithIdentifier:@"DetailsStory" sender:nil];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier  isEqual: @"DetailsStory"]) {
        NSLog(@"Segue is called");
    }
}

@end
