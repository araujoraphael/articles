//
//  ArticlesTableViewController.m
//  Tv2 Articles
//
//  Created by Raphael Araujo on 3/14/15.
//  Copyright (c) 2015 Raphael Araujo. All rights reserved.
//

#import "ArticlesTableViewController.h"
#import "ArticleTableViewCell.h"
#import "ArticleViewController.h"
#import "Article.h"
#import "DataController.h"

@interface ArticlesTableViewController ()
@property (nonatomic, strong) NSOperationQueue *imageDownloadingQueue;
@property (nonatomic, strong) NSCache *imageCache;
@end

@implementation ArticlesTableViewController

NSArray *fetchedArticles;
NSInteger selectedRow;

- (void)viewDidLoad {
    [super viewDidLoad];

    self.tableView.backgroundColor = [UIColor colorWithRed:220.0 green:220.0 blue:220.0 alpha:1.0];
    
    [self addRefreshController];
    [self loadArticles];
    
    self.imageDownloadingQueue = [[NSOperationQueue alloc] init];
    self.imageDownloadingQueue.maxConcurrentOperationCount = 4; // just in case of server limit the number of concurrent requests
    self.imageCache = [[NSCache alloc] init];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) addRefreshController {
    UIRefreshControl *refreshControl = [[UIRefreshControl alloc] init];
    refreshControl.attributedTitle = [[NSAttributedString alloc] initWithString:@"Please wait..."];
    refreshControl.tintColor = [UIColor redColor];
    [refreshControl addTarget:self action:@selector(refreshTableView:) forControlEvents:UIControlEventValueChanged];
    [self.tableView addSubview:refreshControl];
}

-(void)loadArticles {
    [DataController requestArticles:^(NSArray *articles) {
        fetchedArticles = articles;
        [self.tableView reloadData];
        [UIView beginAnimations:@"anime" context:nil];
        [UIView setAnimationDelegate:self];
        [UIView setAnimationDuration:1.0];
        [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
        [UIView setAnimationBeginsFromCurrentState:YES];
        self.tableView.alpha = 1.0f;
        [UIView commitAnimations];
    }failure:^{}
    ];
}

- (void)refreshTableView:(UIRefreshControl *)refreshControl {
    [self loadArticles];
    [refreshControl endRefreshing];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return [fetchedArticles count];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];

    ArticleViewController *articleViewController = [storyboard instantiateViewControllerWithIdentifier:@"ArticleViewController"];
    Article *article = [fetchedArticles objectAtIndex:indexPath.row];
    articleViewController.articleURL = article.url;
    articleViewController.articleTitle = article.title;

    [self.navigationController pushViewController: articleViewController animated:YES];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"articleCell";
    
    ArticleTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    Article *article = [fetchedArticles objectAtIndex:indexPath.row];
    if(!cell)
    {
        cell = [[ArticleTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    cell.titleLabel.text = article.title;
    UIImageView *hasVideoImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"hasVideo.png"]];
    hasVideoImageView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.3f];
    
    cell.hasVideoImageView.hidden = !article.hasVideo;
    cell.isLiveImageView.hidden = !article.isLive;
    cell.isBreakingImageView.hidden = !article.isBreaking;
    
    NSString *imageUrlString = [article.smallTeaserImage absoluteString];
    UIImage *cachedImage = [self.imageCache objectForKey:imageUrlString];
    if (cachedImage) {
        cell.articleImageView.image = cachedImage;
    } else {
        
        cell.articleImageView.image = [UIImage imageNamed:@"kitty.jpg"];
        
        [self.imageDownloadingQueue addOperationWithBlock:^{
            
            NSURL *imageUrl   = [NSURL URLWithString:imageUrlString];
            NSData *imageData = [NSData dataWithContentsOfURL:imageUrl];
            UIImage *image    = nil;
            if (imageData)
                image = [UIImage imageWithData:imageData];
            
            if (image) {
                
                [self.imageCache setObject:image forKey:imageUrlString];
                
                [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                    ArticleTableViewCell *updateCell = (ArticleTableViewCell *)[tableView cellForRowAtIndexPath:indexPath];
                    if (updateCell)
                        updateCell.articleImageView.image = image;
                }];
            }
        }];
    }
    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 70;
}
@end
