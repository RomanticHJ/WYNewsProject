//
//  HJNewsCell.m
//  WYNewsProject
//
//  Created by admin on 16/2/28.
//  Copyright © 2016年 admin. All rights reserved.
//

#import "HJNewsCell.h"
#import "HJNewsModel.h"
#import <UIImageView+WebCache.h>

@interface HJNewsCell ()

@property (weak, nonatomic) IBOutlet UIImageView *iconView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *digestLabel;
@property (weak, nonatomic) IBOutlet UILabel *replyCountLabel;

@end

@implementation HJNewsCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setNews:(HJNewsModel *)news {
    _news = news;
    [self.iconView sd_setImageWithURL:[NSURL URLWithString:_news.imgsrc]];
    self.titleLabel.text = _news.title;
    self.digestLabel.text = _news.digest;
    self.replyCountLabel.text = [NSString stringWithFormat:@"%ld人跟帖",(long)_news.replyCount];
}

@end
