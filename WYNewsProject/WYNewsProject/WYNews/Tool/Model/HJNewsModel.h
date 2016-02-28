//
//  HJNewsModel.h
//  WYNewsProject
//
//  Created by admin on 16/2/28.
//  Copyright © 2016年 admin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HJNewsModel : NSObject

@property (nonatomic, assign) NSInteger replyCount;

@property (nonatomic, copy) NSString *digest;

@property (nonatomic, copy) NSString *imgsrc;

@property (nonatomic, copy) NSString *title;

/**
 *  upload news data
 *
 *  @param url     news data url
 *  @param success success call back(data call back)
 */
+ (void)newsDatasWithURL:(NSString *)url success:(void(^)(NSArray *news))success;

@end
