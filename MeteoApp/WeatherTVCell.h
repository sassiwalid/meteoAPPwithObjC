//
//  WeatherTVCell.h
//  MeteoApp
//
//  Created by MacBook Pro on 20/02/2017.
//  Copyright © 2017 MacBook Pro. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Observation.h"

@interface WeatherTVCell : UITableViewCell
@property (nonatomic, weak) IBOutlet UILabel *tempLabel;
@property (nonatomic, weak) IBOutlet UILabel *weatherLabel;
@property (nonatomic, weak) IBOutlet UIImageView *weatherImageView;

- (void)configureCellWithObservation:(Observation *)anObservation;

@end
