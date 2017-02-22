//
//  WeatherTVCell.m
//  MeteoApp
//
//  Created by MacBook Pro on 20/02/2017.
//  Copyright © 2017 MacBook Pro. All rights reserved.
//

#import "WeatherTVCell.h"
#import "Constantes.h"
@implementation WeatherTVCell
@synthesize tempLabel;
@synthesize weatherLabel;
@synthesize weatherImageView;
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

#pragma mark - configureCellWithObservation
- (void)configureCellWithObservation:(Observation *)anObservation {
    
    NSLog(@"configureCellWithObservation");
    
    tempLabel.text = [NSString stringWithFormat:@"%@", anObservation.temperatureDescription];
    weatherLabel.text   = anObservation.weatherDescription;
    [self loadImage:anObservation.iconUrl];
}
- (void) loadImage:(NSString*)name
{
    NSURL *imageURL = [NSURL URLWithString: [NSString stringWithFormat:@"%@%@%@", ICON_API_URL, name, @".png"]];
    [[[NSURLSession sharedSession] dataTaskWithURL:imageURL completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            self.weatherImageView.image = [UIImage imageWithData:data];
        });
    }] resume ];
}

@end
