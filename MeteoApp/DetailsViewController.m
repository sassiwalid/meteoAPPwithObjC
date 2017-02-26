//
//  DetailsVC.m
//  MeteoApp
//
//  Created by MacBook Pro on 20/02/2017.
//  Copyright © 2017 MacBook Pro. All rights reserved.
//

#import "DetailsViewController.h"
@implementation DetailsViewController
@synthesize myObservation;
@synthesize humidityLabel;
@synthesize morningTempLabel;
@synthesize eveningTempLabel;
@synthesize nightTempLabel;
@synthesize pressureLabel;
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self updateUI];
}
-(void)updateUI
{
  humidityLabel.text = myObservation.humidity;
  morningTempLabel.text = myObservation.temperatureMorning;
  eveningTempLabel.text = myObservation.temperatureEvening;
  nightTempLabel.text = myObservation.temperatureNight;
  pressureLabel.text = myObservation.pressure;

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
