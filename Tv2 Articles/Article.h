//
//  Article.h
//  Tv2 Articles
//
//  Created by Raphael Araujo on 3/13/15.
//  Copyright (c) 2015 Raphael Araujo. All rights reserved.
//

#import "MTLModel.h"
#import "MTLJSONAdapter.h"

@interface Article : MTLModel <MTLJSONSerializing>

@property (nonatomic) NSString *title;
@property (nonatomic) NSString *identifier;
@property (nonatomic) NSURL *smallTeaserImage;
@property (nonatomic) NSURL *url;
@property (nonatomic) BOOL isLive;
@property (nonatomic) BOOL isBreaking;
@property (nonatomic) BOOL hasVideo;

+ (NSArray *)deserializeArticlesFromJSON:(NSArray *)articlesJSON;
@end
