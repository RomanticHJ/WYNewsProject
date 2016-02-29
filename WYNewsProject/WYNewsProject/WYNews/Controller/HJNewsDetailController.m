//
//  HJNewsDetailController.m
//  WYNewsProject
//
//  Created by admin on 16/3/1.
//  Copyright © 2016年 admin. All rights reserved.
//

#import "HJNewsDetailController.h"
#import "HJHTTPManager.h"

@interface HJNewsDetailController ()<UIWebViewDelegate>
@property (nonatomic, strong) UIWebView *webView;
@property (nonatomic, copy) NSString *body; // News content
@property (nonatomic, copy) NSString *newsTitle; // News title
@property (nonatomic, copy) NSString *time; // News time
@end

@implementation HJNewsDetailController

- (void)loadView {
    self.webView = [[UIWebView alloc] init];
    self.webView.delegate = self;
    self.view = self.webView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    // 如果不写的画，在跳转到详情控制器的时候，会出现卡顿的现象，这种情况在以后工作中会经常用到，一般都直接把背景设置成白色
    self.view.backgroundColor = [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:1.0];
    [self loadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)loadData {
    [[HJHTTPManager sharedManager] GET:self.newsURL parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary * _Nullable responseObject) {
        NSString *key = responseObject.keyEnumerator.nextObject;
        NSDictionary *result = responseObject[key];
        // Take out body content
        __block NSString *body = result[@"body"];
        // Take out all of image
        NSArray *images = result[@"img"];
        // The replacement cycle of image data
        [images enumerateObjectsUsingBlock:^(NSDictionary *  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            NSString *ref = obj[@"ref"];
            // Replace character string
            body = [body stringByReplacingOccurrencesOfString:ref withString:[self imageHTMLWithDict:obj]];
        }];
        self.body = body;
        self.newsTitle = result[@"title"];
        self.time = [NSString stringWithFormat:@"%@ %@",result[@"ptime"],result[@"source"]];
        // Local html file path
        NSURL *url = [[NSBundle mainBundle] URLForResource:@"detail.html" withExtension:nil];
        NSURLRequest *request = [NSURLRequest requestWithURL:url];
        [self.webView loadRequest:request];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"出错了");
    }];
}


- (NSString *)imageHTMLWithDict:(NSDictionary *)dict {
    NSString *html = [NSString stringWithFormat:@"<img src=\"%@\" width=\"100%%\"  alt=\"%@\"/>",dict[@"src"],dict[@"alt"]];
    return html;
}

#pragma mark - UIWebView 的代理
- (void)webViewDidFinishLoad:(UIWebView *)webView {
    NSString *code = [NSString stringWithFormat:@"changeContent('%@', '%@', '%@')",self.newsTitle,self.time,self.body];
    [webView stringByEvaluatingJavaScriptFromString:code];
}

@end
