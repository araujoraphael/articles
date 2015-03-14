//
//  ArticleTableViewCell.h
//  Tv2 Articles
//
//  Created by Raphael Araujo on 3/14/15.
//  Copyright (c) 2015 Raphael Araujo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ArticleTableViewCell : UITableViewCell
@property (nonatomic, weak) IBOutlet UILabel *titleLabelView;
@property (nonatomic, weak) IBOutlet UIImageView *articleImageView;
@end
