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

@synthesize delegate;


- (NSArray *)requestArticles
{
    __block NSMutableArray *articles;
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:kArticlesSourceURL parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        //NSLog(@"Articles JSON(%@): %@", [[responseObject objectAtIndex:0] class],responseObject);
        articles = [[Article deserializeArticlesFromJSON:responseObject] mutableCopy];
        [self.delegate didFinishRequestArticles:articles];

        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];

    return articles;
}
@end
