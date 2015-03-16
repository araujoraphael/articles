//
//  ArticleTableViewCell.h
//  Tv2 Articles
//
//  Created by Raphael Araujo on 3/14/15.
//  Copyright (c) 2015 Raphael Araujo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ArticleTableViewCell : UITableViewCell
@property (nonatomic, strong) IBOutlet UILabel *titleLabel;
@property (nonatomic, strong) IBOutlet UIImageView *articleImageView;
@property (nonatomic, strong) IBOutlet UIView *articleImageContainerView;
@property (nonatomic, strong) UIImageView *hasVideoImageView;
@property (nonatomic, strong) IBOutlet UIImageView *isLiveImageView;
@property (nonatomic, strong) IBOutlet UIImageView *isBreakingImageView;
@end
