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
 *  collectionView data
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
        // volatile array
        NSMutableArray *tempData = [NSMutableArray arrayWithArray:headLines];
        [tempData insertObject:[headLines lastObject] atIndex:0];
        [tempData addObject:[headLines firstObject]];
        self.data = tempData.copy;
        // refresh interface
        [self.collectionView reloadData];
        // show second element of default
        [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:1 inSection:0] atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:NO];
    }];
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.data.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    HJHeadLineCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    // set pagination
    cell.tag = indexPath.item - 1;
    // set data
    cell.headLine = self.data[indexPath.item];
    return cell;
}

/**
 *  judge current which one when scroll end
 */
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    NSInteger index = scrollView.contentOffset.x / scrollView.bounds.size.width;
    if (index == self.data.count - 1) {
        // scroll back the first
        [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:1 inSection:0] atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:NO];
    }else if (index == 0) {
        NSInteger page = self.data.count - 2;
        [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:page inSection:0] atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:NO];
    }
}
@end
