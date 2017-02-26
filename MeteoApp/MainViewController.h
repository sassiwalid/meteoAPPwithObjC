//
//  ViewController.h
//  MeteoApp
//
//  Created by MacBook Pro on 20/02/2017.
//  Copyright © 2017 MacBook Pro. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Observation.h"
@interface MainViewController : UIViewController<UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UILabel *tempLabel;
@property (weak, nonatomic) IBOutlet UILabel *weatherLabel;
@property (weak, nonatomic) IBOutlet UIImageView *weatherImageView;
@property (atomic, strong) NSDictionary *dataDictionary;
@property (atomic, strong) RLMResults <Observation *> *observationArray;
@property(atomic,strong) Observation *observation;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

