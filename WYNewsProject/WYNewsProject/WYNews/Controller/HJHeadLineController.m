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
#define HJGroupCount 10000

@interface HJHeadLineController ()<UICollectionViewDataSource,UIScrollViewDelegate>

@property (nonatomic, weak) IBOutlet UICollectionViewFlowLayout *layout;

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@property (weak, nonatomic) IBOutlet UIPageControl *pageControl;

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

/**
 *  collectionView data
 */
@property (nonatomic, strong) NSArray *data;
@end

@implementation HJHeadLineController

static NSString * const reuseIdentifier = @"HeadLine";

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadData];
    
}

/**
 *  subviews layout
 */
- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    [self setupView];
}

/**
 *  set view layout and other style
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
 *  upload headline data
 */
- (void)loadData {
    [HJHeadLineModel headLineDatasWithURL:@"ad/headline/0-4.html" success:^(NSArray *headLines) {
        self.data = headLines;
        // refresh interface
        [self.collectionView reloadData];
        self.pageControl.numberOfPages = self.data.count;
        // set first page of title
        [self scrollViewDidEndDecelerating:self.collectionView];
    }];
}

#pragma mark - UICollectionViewDataSource
// use groups realize infinite loop
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return HJGroupCount;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.data.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    HJHeadLineCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    // set data
    cell.headLine = self.data[indexPath.item];
    return cell;
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    NSInteger index = (NSInteger)(scrollView.contentOffset.x / scrollView.bounds.size.width ) % self.data.count;
    // take out current page data
    HJHeadLineModel *headLine = self.data[index];
    self.titleLabel.text = headLine.title;
    self.pageControl.currentPage = index;
}

@end
