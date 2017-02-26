//
//  MyManagerAPI.h
//  MeteoApp
//
//  Created by MacBook Pro on 22/02/2017.
//  Copyright © 2017 MacBook Pro. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MyManagerAPI : NSObject
typedef void(^onComplete) (NSDictionary * __nullable dataDict, NSError * __nullable error);
+(id) instance;
-(void) getObservations:(nullable onComplete)completionHandler;
@end
