//
//  DataController.h
//  Tv2 Articles
//
//  Created by Raphael Araujo on 3/13/15.
//  Copyright (c) 2015 Raphael Araujo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface DataController : NSObject
+ (void)requestArticles:(void (^)(NSArray *))successBlock
                failure:(void (^)(void))failure;

@end