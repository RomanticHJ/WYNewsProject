//
//  HJChannelNewsCell.m
//  WYNewsProject
//
//  Created by admin on 16/2/29.
//  Copyright © 2016年 admin. All rights reserved.
//

#import "HJChannelNewsCell.h"
#import "HJChannelModel.h"
#import "HJNewsController.h"

@interface HJChannelNewsCell ()
// 必须强引用，否则控制器就会瞬间被释放，但里面的view没被释放，就不能调用数据方法
@property (nonatomic, strong) HJNewsController *news;

@end

@implementation HJChannelNewsCell

- (void)setChangnel:(HJChannelModel *)changnel {
    // load the news ViewController
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"News" bundle:nil];
    HJNewsController *newsVC = [sb instantiateInitialViewController];
    // load different news
    newsVC.channelId = changnel.tid;
    [self.contentView addSubview:newsVC.view];
    // set frame
    newsVC.view.frame = self.contentView.bounds;
    self.news = newsVC;
}

@end
