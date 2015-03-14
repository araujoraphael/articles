//
//  DataController.h
//  Tv2 Articles
//
//  Created by Raphael Araujo on 3/13/15.
//  Copyright (c) 2015 Raphael Araujo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


@protocol DataCrontrollerDelegate ;

@interface DataController : NSObject {
    id <DataCrontrollerDelegate> delegate;
}

@property (nonatomic, retain) id <DataCrontrollerDelegate> delegate;
- (NSArray *) requestArticles;
@end

@protocol DataCrontrollerDelegate
- (void)didFinishRequestArticles:(NSArray *)articles;
@end