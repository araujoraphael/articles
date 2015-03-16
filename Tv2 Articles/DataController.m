//
//  DataController.m
//  Tv2 Articles
//
//  Created by Raphael Araujo on 3/13/15.
//  Copyright (c) 2015 Raphael Araujo. All rights reserved.
//

#import "DataController.h"
#import <AFNetworking.h>
#import "Article.h"

@implementation DataController

static NSString * const kArticlesSourceURL = @"http://app-backend.tv2.dk/articles/v1/?section_identifier=2";

//backup link. Just in case...
//static NSString * const kArticlesSourceURL = @"http://jaecarnavalrecife.com/arcticles.json";

+ (void)requestArticles:(void (^)(NSArray *))successBlock failure:(void (^)(void))failure
{
    __block NSMutableArray *articles;
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:kArticlesSourceURL
      parameters:nil
         success:^(AFHTTPRequestOperation *operation, id responseObject) {
        articles = [[Article deserializeArticlesFromJSON:responseObject] mutableCopy];
        
        successBlock(articles);

    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
}
@end
