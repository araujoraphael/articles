//
//  ArticlesTableViewController.m
//  Tv2 Articles
//
//  Created by Raphael Araujo on 3/14/15.
//  Copyright (c) 2015 Raphael Araujo. All rights reserved.
//

#import "ArticlesTableViewController.h"
#import "ArticleTableViewCell.h"
#import "Article.h"

@interface ArticlesTableViewController ()
@property (nonatomic, strong) NSOperationQueue *imageDownloadingQueue;
@property (nonatomic, strong) NSCache *imageCache;
@end

@implementation ArticlesTableViewController

DataController *dataController;
NSArray *fetchedArticles;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    dataController = [[DataController alloc] init];
    dataController.delegate = self;
    
    [dataController requestArticles];
    
    NSLog(@"viewDidLoad - ArticlesTableViewController");
    
    self.imageDownloadingQueue = [[NSOperationQueue alloc] init];
    self.imageDownloadingQueue.maxConcurrentOperationCount = 4; // many servers limit how many concurrent requests they'll accept from a device, so make sure to set this accordingly
    
    self.imageCache = [[NSCache alloc] init];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"articleCell";
    
    ArticleTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    Article *article = [fetchedArticles objectAtIndex:indexPath.row];
    if(!cell)
    {
        NSArray *nibs = [[NSBundle mainBundle] loadNibNamed:@"ArticleTableViewCell" owner:self options:nil];
        cell = (ArticleTableViewCell *)[nibs objectAtIndex:0];
        cell.imageView.frame = CGRectMake(0,5,124,70);
    }
    
    cell.titleLabelView.text = article.title;
    /**** loading image with cache ******/
    NSString *imageUrlString = [article.smallTeaserImage absoluteString];
    UIImage *cachedImage = [self.imageCache objectForKey:imageUrlString];
    if (cachedImage) {
        cell.imageView.image = cachedImage;
    } else {
        // you'll want to initialize the image with some blank image as a placeholder
        
        cell.imageView.image = [UIImage imageNamed:@"kitty.jpg"];
        
        // now download in the image in the background
        
        [self.imageDownloadingQueue addOperationWithBlock:^{
            
            NSURL *imageUrl   = [NSURL URLWithString:imageUrlString];
            NSData *imageData = [NSData dataWithContentsOfURL:imageUrl];
            UIImage *image    = nil;
            if (imageData)
                image = [UIImage imageWithData:imageData];
            
            if (image) {
                // add the image to your cache
                
                [self.imageCache setObject:image forKey:imageUrlString];
                
                // finally, update the user interface in the main queue
                
                [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                    // Make sure the cell is still visible
                    
                    // Note, by using the same `indexPath`, this makes a fundamental
                    // assumption that you did not insert any rows in the intervening
                    // time. If this is not a valid assumption, make sure you go back
                    // to your model to identify the correct `indexPath`/`updateCell`
                    
                    UITableViewCell *updateCell = [tableView cellForRowAtIndexPath:indexPath];
                    if (updateCell)
                        updateCell.imageView.image = image;
                }];
            }
        }];
    }
    /**** END ******/
    return cell;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void)didFinishRequestArticles:(NSArray *)articles {
    
    fetchedArticles = articles;
    Article *article =articles[0];
    NSLog(@"Opa %@ - %@", article.title, article.url);
    [self.tableView reloadData];
    
}



@end
