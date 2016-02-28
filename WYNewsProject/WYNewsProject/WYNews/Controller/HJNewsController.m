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

@interface HJNewsController ()
@property (nonatomic, strong) NSArray *newsDatas;
@end

@implementation HJNewsController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadData];
}

- (void)loadData {
    [HJNewsModel newsDatasWithURL:@"article/headline/T1348647853363/0-20.html" success:^(NSArray *news) {
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

@end