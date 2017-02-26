//
//  DetailsVC.h
//  MeteoApp
//
//  Created by MacBook Pro on 20/02/2017.
//  Copyright © 2017 MacBook Pro. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Observation.h"
@interface DetailsViewController : UIViewController
@property(retain,nonatomic) Observation * myObservation;
@property (strong, nonatomic) IBOutlet UILabel *humidityLabel;
@property (weak, nonatomic) IBOutlet UILabel *morningTempLabel;
@property (weak, nonatomic) IBOutlet UILabel *eveningTempLabel;
@property (weak, nonatomic) IBOutlet UILabel *nightTempLabel;
@property (weak, nonatomic) IBOutlet UILabel *pressureLabel;

@end
