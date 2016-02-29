//
//  HJNewsModel.h
//  WYNewsProject
//
//  Created by admin on 16/2/28.
//  Copyright © 2016年 admin. All rights reserved.
//

#import <Foundation/Foundation.h>
@class HJNewsImageModel;
@interface HJNewsModel : NSObject

@property (nonatomic, assign) NSInteger replyCount;

@property (nonatomic, copy) NSString *digest;

@property (nonatomic, copy) NSString *imgsrc;

@property (nonatomic, copy) NSString *title;

@property (nonatomic, strong) NSArray<HJNewsImageModel *> *imgextra;
/**
 *  picture type --- default is 0   big picture is 1
 */
@property (nonatomic, assign) NSInteger imgType;
@property (nonatomic, copy) NSString *docid;
// News detail path
@property (nonatomic, copy) NSString *fullURL;

/**
 *  upload news data
 *
 *  @param url     news data url
 *  @param success success call back(data call back)
 */
+ (void)newsDatasWithURL:(NSString *)url success:(void(^)(NSArray *news))success;

@end
