//
//  Article.m
//  Tv2 Articles
//
//  Created by Raphael Araujo on 3/13/15.
//  Copyright (c) 2015 Raphael Araujo. All rights reserved.
//

#import "Article.h"
#import "NSValueTransformer+MTLPredefinedTransformerAdditions.h"

@implementation Article

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             @"title" : @"title",
             @"identifier" : @"identifier",
             @"smallTeaserImage" : @"small_teaser_image",
             @"url" : @"url",
             @"hasVideo" : @"has_video",
             @"isLive" : @"is_live",
             @"isBreaking" : @"is_breaking"
             };
}

+ (NSValueTransformer *)smallTeaserImageJSONTransformer {
    return [NSValueTransformer valueTransformerForName:MTLURLValueTransformerName];
}

+ (NSValueTransformer *)urlJSONTransformer {
    return [NSValueTransformer valueTransformerForName:MTLURLValueTransformerName];
}

+ (NSArray *)deserializeArticlesFromJSON:(NSArray *)articlesJSON {
    NSError *error;
    NSArray *articles = [MTLJSONAdapter modelsOfClass:[Article class] fromJSONArray:articlesJSON error:&error];
    
    //NSLog(@"%@", articles);
    if(error) {
        NSLog(@"Could not convert articles JSON to Article models %@", error);
        return nil;
    }
    return articles;
}
@end
