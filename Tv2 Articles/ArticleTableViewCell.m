//
//  ArticleTableViewCell.m
//  Tv2 Articles
//
//  Created by Raphael Araujo on 3/14/15.
//  Copyright (c) 2015 Raphael Araujo. All rights reserved.
//

#import "ArticleTableViewCell.h"

@implementation ArticleTableViewCell

@synthesize titleLabel = _titleLabel;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // configure control(s)
        
        self.isLiveImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"isLive.png"]];
        self.isBreakingImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"isBreaking.png"]];
        
        if([UIScreen mainScreen].bounds.size.width == 320.0) {
            self.isLiveImageView.frame = CGRectMake(290, 48, 20, 20);
            self.isBreakingImageView.frame = CGRectMake(270, 48, 20,20);
            self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(132, 5, 183, 60)];
        } else {
            self.isLiveImageView.frame = CGRectMake(298, 48, 20, 20);
            self.isBreakingImageView.frame = CGRectMake(278, 48, 20,20);
            self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(200, 5, 183, 60)];
        }

        self.titleLabel.textColor = [UIColor blackColor];
        self.titleLabel.font = [UIFont fontWithName:@"Arial" size:12.0f];
        self.titleLabel.numberOfLines = 0;        
        self.articleImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"kitty.jpg"]];
        self.articleImageView.frame = CGRectMake(0,0,108,60);
        self.articleImageContainerView = [[UIView alloc] initWithFrame:CGRectMake(5,5,108,60)];
        self.hasVideoImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"hasVideo.png"]];
        self.hasVideoImageView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.3f];
        
        self.isBreakingImageView.frame = CGRectMake(270, 48, 20,20);
        self.isBreakingImageView.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin;
        self.isLiveImageView.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin;
        [self addSubview:self.titleLabel];
        [self.articleImageContainerView addSubview:self.articleImageView];
        [self.articleImageContainerView addSubview:self.hasVideoImageView];
        [self addSubview:self.articleImageContainerView];
        [self addSubview:self.isLiveImageView];
        [self addSubview:self.isBreakingImageView];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (NSString *) reuseIdentifier {
    return @"articleCell";
}

@end
