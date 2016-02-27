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

@end

@implementation HJHeadLineCell
- (void)setHeadLine:(HJHeadLineModel *)headLine {
    _headLine = headLine;
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:headLine.imgsrc]];
}
@end
