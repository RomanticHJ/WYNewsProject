//
//  HJNewsCell.h
//  WYNewsProject
//
//  Created by admin on 16/2/28.
//  Copyright © 2016年 admin. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HJNewsModel;
@interface HJNewsCell : UITableViewCell
@property (nonatomic, strong) HJNewsModel *news;

/**
 *  back cell reuse ID
 *
 *  @param news model
 *
 *  @return reuse ID
 */
+ (NSString *)cellIdentiferWithNews:(HJNewsModel *)news;

+ (CGFloat)cellHeightWithNews:(HJNewsModel *)news;

@end
