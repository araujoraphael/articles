//
//  ViewController.m
//  Tv2 Articles
//
//  Created by Raphael Araujo on 3/13/15.
//  Copyright (c) 2015 Raphael Araujo. All rights reserved.
//

#import "ViewController.h"
#import "Article.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    DataController *dataController = [[DataController alloc] init];
//    dataController.delegate = self;
//    [dataController requestArticles];
    //NSLog(@"%@", articles);
    
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)didFinishRequestArticles:(NSArray *)articles {
    Article *article =articles[0];
//    NSLog(@"%@ - %@", article.title, article.url);

}


@end
