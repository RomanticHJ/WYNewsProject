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

@interface HJHomeController ()<UICollectionViewDataSource,UICollectionViewDelegate>

@property (nonatomic, weak) IBOutlet UIScrollView *scrollViw;
@property (nonatomic, weak) IBOutlet UICollectionView *collectionView;

@property (weak, nonatomic) IBOutlet UICollectionViewFlowLayout *layout;

@property (nonatomic, strong) NSArray *channels;

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
        CGFloat labelH = self.scrollViw.bounds.size.height;
        HJChannelLabel *label = [HJChannelLabel channelLabelWithTitle:obj.tname];
        CGFloat labelW = label.bounds.size.width;
        // set the frame
        label.frame = CGRectMake(labelX, labelY, labelW, labelH);
        labelX += labelW;
//        __block typeof(label) weakLabel = label;
        __block typeof(self) weakSelf = self;
        [label setClickchannel:^{
//            NSLog(@"%@--%zd",weakLabel.text,idx);
            // switch viewController
            [weakSelf.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:idx inSection:0] atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:NO];
        }];
        [self.scrollViw addSubview:label];
    }];
    // set the boundary of scroll
    self.scrollViw.contentSize = CGSizeMake(labelX, 0);
    self.channels = channels;
    [self.collectionView reloadData];
}

#pragma mark - UICollectionViewDataSource method
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.channels.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    HJChannelNewsCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"HJChannelNewsCell" forIndexPath:indexPath];
    cell.backgroundColor = [UIColor colorWithRed:((float)arc4random_uniform(256) / 255.0) green:((float)arc4random_uniform(256) / 255.0) blue:((float)arc4random_uniform(256) / 255.0) alpha:1.0];
    // set the channel data
    cell.changnel = self.channels[indexPath.item];
    return cell;
}

@end
