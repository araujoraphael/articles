//
//  ArticleViewController.m
//  Tv2 Articles
//
//  Created by Raphael Araujo on 3/14/15.
//  Copyright (c) 2015 Raphael Araujo. All rights reserved.
//

#import "ArticleViewController.h"

@interface ArticleViewController ()
@end

@implementation ArticleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.articleWebView.delegate = self;
    [self.activityIndicator startAnimating];
    self.articleWebView.alpha = 0.0f;
    [self.articleWebView loadRequest:[NSURLRequest requestWithURL:self.articleURL]];
    
    [self addShareButton];
}

- (void)addShareButton {
    UIBarButtonItem *flipButton = [[UIBarButtonItem alloc]
                                   initWithTitle:@"Share"
                                   style:UIBarButtonItemStyleBordered
                                   target:self
                                   action:@selector(openShareOptions)];
    flipButton.enabled = NO;
    self.navigationItem.rightBarButtonItem = flipButton;
}

- (void)openShareOptions {
    UIActivityViewController *activityViewController =
    [[UIActivityViewController alloc] initWithActivityItems:@[self.articleTitle,@": ", self.articleURL]
                                      applicationActivities:nil];
    [self.navigationController presentViewController:activityViewController
                                            animated:YES
                                          completion:^{
                                          }];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    [UIView beginAnimations:@"anime" context:nil];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDuration:0.4];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
    [UIView setAnimationBeginsFromCurrentState:YES];
    
    CGRect frame = CGRectMake(0, 0, self.articleWebView.frame.size.width, self.articleWebView.frame.size.height);
    
    self.activityIndicator.alpha = 0.0f;
    self.articleWebView.alpha = 1.0f;
    self.articleWebView.frame = frame;
    
    [UIView commitAnimations];
    
    [self.activityIndicator stopAnimating];
    
    self.navigationItem.rightBarButtonItem.enabled = YES;
}
@end
