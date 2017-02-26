//
//  MyManagerAPI.m
//  MeteoApp
//
//  Created by MacBook Pro on 22/02/2017.
//  Copyright © 2017 MacBook Pro. All rights reserved.
//

#import "MyManagerAPI.h"
#import "AFNetworking.h"
#import "Constantes.h"
@implementation MyManagerAPI

+(id)instance
{
  static MyManagerAPI *manager = nil;
  @synchronized (self) {
    if (manager == nil)
      manager = [[self alloc]init];
  }
  return manager;
}
-(void) getObservations:(nullable onComplete)completionHandler
{
  AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
  [manager GET:WEB_SERVICE_URL
    parameters:nil
      progress:nil
       success:^(NSURLSessionTask *task, id responseObject) {
         completionHandler(responseObject,nil);
       }
       failure:^(NSURLSessionTask *operation, NSError *error) {
         NSLog(@"Error: %@", error);
         completionHandler(nil,nil);
       }];
}
@end
