//
//  ArticleViewController.h
//  Tv2 Articles
//
//  Created by Raphael Araujo on 3/14/15.
//  Copyright (c) 2015 Raphael Araujo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ArticleViewController : UIViewController<UIWebViewDelegate>
@property (nonatomic, weak) IBOutlet UIWebView *articleWebView;
@property (nonatomic, weak) IBOutlet UIActivityIndicatorView *activityIndicator;
@property (nonatomic, strong) NSURL *articleURL;
@property (nonatomic, strong) NSString *articleTitle;

- (void)openShareOptions;
@end
