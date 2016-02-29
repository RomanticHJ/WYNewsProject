//
//  HJNewsController.m
//  WYNewsProject
//
//  Created by admin on 16/2/28.
//  Copyright © 2016年 admin. All rights reserved.
//

#import "HJNewsController.h"
#import "HJNewsModel.h"
#import "HJNewsCell.h"
#import "HJNewsDetailController.h"

@interface HJNewsController ()
@property (nonatomic, strong) NSArray *newsDatas;
@end

@implementation HJNewsController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadData];
}

- (void)loadData {
    NSLog(@"append to news channel == %@",self.channelId);
    [HJNewsModel newsDatasWithURL:[NSString stringWithFormat:@"article/headline/%@/0-20.html",self.channelId] success:^(NSArray *news) {
        self.newsDatas = news;
        // refresh the tableView
        [self.tableView reloadData];
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.newsDatas.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    HJNewsModel *news = self.newsDatas[indexPath.row];
    HJNewsCell *cell = [tableView dequeueReusableCellWithIdentifier:[HJNewsCell cellIdentiferWithNews:news] forIndexPath:indexPath];
    cell.news = news;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    HJNewsModel *news = self.newsDatas[indexPath.row];
    return [HJNewsCell cellHeightWithNews:news];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // Jump to the details page
    // Take out the corresponding model
    HJNewsModel *news = self.newsDatas[indexPath.row];
    // Initialize the details page controller
    HJNewsDetailController *detail = [[HJNewsDetailController alloc] init];
    detail.newsURL = news.fullURL;
    // push
    [self.navigationController pushViewController:detail animated:YES];
}

@end