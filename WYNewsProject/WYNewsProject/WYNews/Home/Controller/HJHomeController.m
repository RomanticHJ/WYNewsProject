//
//  HJHomeController.m
//  WYNewsProject
//
//  Created by admin on 16/2/29.
//  Copyright © 2016年 admin. All rights reserved.
//

#import "HJHomeController.h"
#import "HJChannelModel.h"
#import "HJChannelLabel.h"
#import "HJChannelNewsCell.h"
#import "HJNewsController.h"

@interface HJHomeController ()<UICollectionViewDataSource,UICollectionViewDelegate>

@property (nonatomic, weak) IBOutlet UIScrollView *scrollView;
@property (nonatomic, weak) IBOutlet UICollectionView *collectionView;

@property (weak, nonatomic) IBOutlet UICollectionViewFlowLayout *layout;

@property (nonatomic, strong) NSArray *channels;

@property (nonatomic, assign) NSInteger currentPage;

@property (nonatomic, strong) NSMutableDictionary *newsVCCache; // VC cache

@end

@implementation HJHomeController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.automaticallyAdjustsScrollViewInsets = NO;[self setupView];
    [self loadChannelData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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

// NSOrderedAscending = -1L, NSOrderedSame, NSOrderedDescending
- (void)loadChannelData {
    NSArray *channels = [HJChannelModel channelDta];
    // sort
    channels = [channels sortedArrayUsingComparator:^NSComparisonResult(HJChannelModel * _Nonnull obj1, HJChannelModel * _Nonnull obj2) {
        return [obj1.tid compare:obj2.tid];
    }];
    __block CGFloat labelX = 0;
    [channels enumerateObjectsUsingBlock:^(HJChannelModel *  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        // calculate coordinate
        CGFloat labelY = 0;
        CGFloat labelH = self.scrollView.bounds.size.height;
        HJChannelLabel *label = [HJChannelLabel channelLabelWithTitle:obj.tname];
        CGFloat labelW = label.bounds.size.width;
        // set the frame
        label.frame = CGRectMake(labelX, labelY, labelW, labelH);
        labelX += labelW;
        __block typeof(label) weakLabel = label;
        __block typeof(self) weakSelf = self;
        [label setClickchannel:^{
            // switch viewController
            [weakSelf.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:idx inSection:0] atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:NO];
            // The smaller
            HJChannelLabel *currentChannel = weakSelf.scrollView.subviews[weakSelf.currentPage];
            currentChannel.scale = 0;
            // Click change big
            weakLabel.scale = 1;
            weakSelf.currentPage = idx;
            
            [weakSelf adjustScrollViewContentOffset];
        }];
        // The first selected by default
        if (idx == 0) {
            label.scale = 1;
        }
        [self.scrollView addSubview:label];
    }];
    // set the boundary of scroll
    self.scrollView.contentSize = CGSizeMake(labelX, 0);
    self.channels = channels;
    [self.collectionView reloadData];
}

#pragma mark - UICollectionViewDataSource method
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.channels.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    HJChannelNewsCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"HJChannelNewsCell" forIndexPath:indexPath];
    // 把旧的的view从缓存中移除
    [cell.news.view removeFromSuperview];
    HJChannelModel *channel = self.channels[indexPath.item];
    //  Take out the corresponding channel controller
    HJNewsController *news = [self newsControllerWithChannel:channel];
    if (![self.childViewControllers containsObject:news]) {
        NSLog(@"添加子控制器");
        // 把控制器添加到子控制器，否则会影响响应者链条---必须注意
        [self addChildViewController:news];
    }
    news.view.frame = cell.contentView.bounds;
    [cell.contentView addSubview:news.view];
    
    cell.news = news;
    return cell;
}

/**
 *  The news from the cache loading controller
 *
 *  @param channel  The corresponding channel
 *
 *  @return newsViewController
 */
- (HJNewsController *)newsControllerWithChannel:(HJChannelModel *)channel {
    HJNewsController *news = [self.newsVCCache objectForKey:channel.tid];
    if (!news) {
        UIStoryboard *sb = [UIStoryboard storyboardWithName:@"News" bundle:nil];
        news = [sb instantiateInitialViewController];
        news.channelId = channel.tid;
        // append to cache
        [self.newsVCCache setObject:news forKey:channel.tid];
    }
    return news;
}


- (void)adjustScrollViewContentOffset {
    // take out the currently selected channel
    HJChannelLabel *channel = self.scrollView.subviews[self.currentPage];
    CGFloat offsetX = channel.center.x - CGRectGetWidth(self.scrollView.frame) * 0.5;
    if (offsetX < 0) {
        offsetX = 0;
    }
    CGFloat maxOffsetX = self.scrollView.contentSize.width - CGRectGetWidth(self.scrollView.frame);
    if (offsetX > maxOffsetX) {
        offsetX = maxOffsetX;
    }
    [self.scrollView setContentOffset:CGPointMake(offsetX, 0) animated:YES];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    // Take out the corresponding to the current visual range of collectionViewCell indexPath
    NSArray *indexPaths = self.collectionView.indexPathsForVisibleItems;
    // Take out the current channel label
    HJChannelLabel *currentChannel = self.scrollView.subviews[self.currentPage];
    __block HJChannelLabel *nextChannel;
    [indexPaths enumerateObjectsUsingBlock:^(NSIndexPath * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (obj.item != self.currentPage) {
            nextChannel = self.scrollView.subviews[obj.item];
        }
    }];
    if (!nextChannel) {
        return;
    }
    CGFloat offsetX = scrollView.contentOffset.x;
    CGFloat scale = ABS(offsetX / scrollView.bounds.size.width - self.currentPage);
    CGFloat currentScale = 1- scale;
    nextChannel.scale = scale;
    currentChannel.scale = currentScale;
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    CGFloat offsetX = scrollView.contentOffset.x;
    self.currentPage = (NSInteger)offsetX / scrollView.bounds.size.width;
    [self adjustScrollViewContentOffset];
}

#pragma mark - lazy load
- (NSMutableDictionary *)newsVCCache {
    if (!_newsVCCache) {
        _newsVCCache = [NSMutableDictionary dictionary];
    }
    return _newsVCCache;
}

@end
