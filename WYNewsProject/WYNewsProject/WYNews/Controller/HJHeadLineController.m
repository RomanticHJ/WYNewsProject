//
//  HJHeadLineController.m
//  WYNewsProject
//
//  Created by admin on 16/2/26.
//  Copyright © 2016年 admin. All rights reserved.
//

#import "HJHeadLineController.h"
#import "HJHeadLineCell.h"
#import "HJHeadLineModel.h"

@interface HJHeadLineController ()

@property (nonatomic, weak) IBOutlet UICollectionViewFlowLayout *layout;
/**
 *  collectionView数据
 */
@property (nonatomic, strong) NSArray *data;
@end

@implementation HJHeadLineController

static NSString * const reuseIdentifier = @"HeadLine";

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupView];
    [self loadData];
    
}

/**
 *  设置view的布局以及其他的样式
 */
- (void)setupView {
    // set background color
    self.collectionView.backgroundColor = [UIColor whiteColor];
    // set item size
    self.layout.itemSize = self.collectionView.bounds.size;
    // set scroll direction
    self.layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    // hide scroll bar
    self.collectionView.showsHorizontalScrollIndicator = NO;
    // set interval
    self.layout.minimumLineSpacing = 0;
    // set pagination
    self.collectionView.pagingEnabled = YES;
    self.collectionView.bounces = NO;
}

/**
 *  加载头条数据
 */
- (void)loadData {
    [HJHeadLineModel headLineDatasWithURL:@"ad/headline/0-4.html" success:^(NSArray *headLines) {
        self.data = headLines;
        // refresh interface
        [self.collectionView reloadData];
    }];
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.data.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    HJHeadLineCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    cell.backgroundColor = [UIColor colorWithRed:((float)arc4random_uniform(256) / 255.0) green:((float)arc4random_uniform(256) / 255.0) blue:((float)arc4random_uniform(256) / 255.0) alpha:1.0];
    
    // 设置分页
    cell.tag = indexPath.item;
    // 设置数据
    cell.headLine = self.data[indexPath.item];
    
    return cell;
}@end
