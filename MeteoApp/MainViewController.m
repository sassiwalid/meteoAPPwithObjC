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
#import "MyManagerAPI.h"

@implementation MainViewController

@synthesize tempLabel;
@synthesize weatherLabel;
@synthesize weatherImageView;
@synthesize dataDictionary;
@synthesize observationArray;
@synthesize tableView;
@synthesize observation;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    dataDictionary = [[NSDictionary alloc] init];
    [[MyManagerAPI instance]getObservations:^(NSDictionary * _Nullable dataDict, NSError * _Nullable error) {
      if (dataDict != nil) {
        dataDictionary = dataDict;
        [self parseData];
        [self updateUI];
      }
      else{
        [self updateUI];
      }
    }];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self updateUI];
}

#pragma mark - Consume web service
-(void) parseData
{
    RLMRealm *realm = [RLMRealm defaultRealm];
    [realm beginWriteTransaction];
    NSArray *resultList = dataDictionary[@"list"];
    if (resultList.count > 0 ) {
        [realm deleteAllObjects];
        for (NSDictionary *dict in resultList)
        {
            Observation *myObservation = [[Observation alloc] init];
            NSString *KLDay = [NSString stringWithFormat:@"%@",dict[@"temp"][@"day"]];
            NSArray *temp = dict[@"weather"];
            // conversion from Kelvin to celsuis
            myObservation.temperatureDescription = [NSString stringWithFormat:@"%d°",[self Kelvin_To_celsuis:KLDay]];
            NSString *KLMin = [NSString stringWithFormat:@"%@",dict[@"temp"][@"min"]];
            NSString *KLMax = [NSString stringWithFormat:@"%@",dict[@"temp"][@"max"]];
            NSString *KLMorning = [NSString stringWithFormat:@"%@",dict[@"temp"][@"morn"]];
            NSString *KLEven = [NSString stringWithFormat:@"%@",dict[@"temp"][@"eve"]];
            NSString *KLNight = [NSString stringWithFormat:@"%@",dict[@"temp"][@"night"]];
            NSString *pressure = [NSString stringWithFormat:@"%@",dict[@"pressure"]];
            NSString *humidity = [NSString stringWithFormat:@"%@",dict[@"humidity"]];
            myObservation.temperatureMax = [NSString stringWithFormat:@"%d°",[self Kelvin_To_celsuis:KLMin]];
            myObservation.temperatureMin = [NSString stringWithFormat:@"%d°",[self Kelvin_To_celsuis:KLMax]];
            myObservation.temperatureMorning = [NSString stringWithFormat:@"%d°",[self Kelvin_To_celsuis:KLMorning]];
            myObservation.temperatureEvening = [NSString stringWithFormat:@"%d°",[self Kelvin_To_celsuis:KLEven]];
            myObservation.temperatureNight = [NSString stringWithFormat:@"%d°",[self Kelvin_To_celsuis:KLNight]];
            myObservation.pressure = pressure;
            myObservation.humidity = humidity;
            myObservation.weatherDescription = temp[0][@"description"];
            myObservation.iconUrl = temp[0][@"icon"];
            [realm addObject:myObservation];
        }
    [realm commitWriteTransaction];
    }
}

-(int) Kelvin_To_celsuis:(NSString *) temp
{
    return (int)round([temp intValue]-273.15);
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
#pragma mark - Manage Data and UI
// update the UI
-(void) updateUI
{
// Update the UI for the First Day
    observationArray = [Observation allObjects];
    if (observationArray.count > 0) {
        Observation *myFirstObservation = [observationArray objectAtIndex:0];
        weatherLabel.text = myFirstObservation.weatherDescription;
        tempLabel.text = [NSString stringWithFormat:@"%@", myFirstObservation.temperatureDescription];
        [self loadImage:myFirstObservation.iconUrl];
    }
    // reload data in the table view
    [tableView reloadData];
}
- (void) loadImage:(NSString*)name
{
  NSURL *imageURL = [NSURL URLWithString: [NSString stringWithFormat:@"%@%@%@", ICON_API_URL, name, @".png"]];
  // get from the cash database
  [[[NSURLSession sharedSession] dataTaskWithURL:imageURL completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
    dispatch_async(dispatch_get_main_queue(), ^{
    self.weatherImageView.image = [UIImage imageWithData:data];
    });
  }] resume ];
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

  [self performSegueWithIdentifier:SEGUE_IDENTIFIER sender:self];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier  isEqual: SEGUE_IDENTIFIER]) {
      observation = [observationArray objectAtIndex:self.tableView.indexPathForSelectedRow.row];
      DetailsViewController *dest = (DetailsViewController *)[segue destinationViewController];
      dest.myObservation = observation;
    }
}

@end
