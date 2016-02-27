//
//  HJHeadLineModel.h
//  WYNewsProject
//
//  Created by admin on 16/2/27.
//  Copyright © 2016年 admin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HJHeadLineModel : NSObject
/**
 *  picture path
 */
@property (nonatomic, copy) NSString *imgsrc;
/**
 *  title
 */
@property (nonatomic, copy) NSString *title;

+ (instancetype)handLineWithDict:(NSDictionary *)dict;

- (instancetype)initWithDict:(NSDictionary *)dict;

/**
 *  upload headLine data
 *
 *  @param url     url
 *  @param success success call back(data call back)
 */
+ (void)headLineDatasWithURL:(NSString *)url success:(void(^)(NSArray *headLines))success;

@end
