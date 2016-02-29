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
#import "HJNewsImageModel.h"

@interface HJNewsCell ()

@property (weak, nonatomic) IBOutlet UIImageView *iconView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *digestLabel;
@property (weak, nonatomic) IBOutlet UILabel *replyCountLabel;
@property (strong, nonatomic) IBOutletCollection(UIImageView) NSArray *imgextra;

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
    [self.iconView sd_setImageWithURL:[NSURL URLWithString:_news.imgsrc] placeholderImage:nil options:SDWebImageRetryFailed | SDWebImageLowPriority];
    self.titleLabel.text = _news.title;
    self.digestLabel.text = _news.digest;
    self.replyCountLabel.text = [NSString stringWithFormat:@"%ld人跟帖",(long)_news.replyCount];
    
    // judge if have more image or not
    if (_news.imgextra) {
        // set more image
        [self.imgextra enumerateObjectsUsingBlock:^(UIImageView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            HJNewsImageModel *image = _news.imgextra[idx];
            [obj sd_setImageWithURL:[NSURL URLWithString:image.imgsrc] placeholderImage:nil options:SDWebImageRetryFailed | SDWebImageLowPriority];
        }];
    }
}

+ (NSString *)cellIdentiferWithNews:(HJNewsModel *)news {
    // judge use which cell cross image count
    if (news.imgextra) {
        return @"HJNewsMoreImageCell";
    }else if (news.imgType == 1){
        return @"HJNewsBigImageCell";
    }else {
        return @"HJNewsCell";
    }
}

+ (CGFloat)cellHeightWithNews:(HJNewsModel *)news {
    if (news.imgextra) {
        return 100;
    }else if (news.imgType == 1){
        return 150;
    }else {
        return 80;
    }
}

@end
