//
//  HJHeadLineCell.m
//  WYNewsProject
//
//  Created by admin on 16/2/26.
//  Copyright © 2016年 admin. All rights reserved.
//

#import "HJHeadLineCell.h"
#import "HJHeadLineModel.h"
#import <UIImageView+WebCache.h>

@interface HJHeadLineCell ()

@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@property (weak, nonatomic) IBOutlet UIPageControl *pageControl;
@end

@implementation HJHeadLineCell
- (void)setHeadLine:(HJHeadLineModel *)headLine {
    _headLine = headLine;
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:headLine.imgsrc]];
    self.titleLabel.text = headLine.title;
    self.pageControl.currentPage = self.tag;
}
@end
