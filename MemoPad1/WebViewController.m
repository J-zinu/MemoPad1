//
//  WebViewController.m
//  MemoPad1
//
//  Created by JinWoo Jeong on 5/27/24.
//

#import "WebViewController.h"

@interface WebViewController ()

@end

@implementation WebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 네비게이션 바 높이를 가져옵니다.
    CGFloat navBarHeight = self.navigationController.navigationBar.frame.size.height;
    CGFloat statusBarHeight = [UIApplication sharedApplication].statusBarFrame.size.height;
    CGFloat topInset = navBarHeight + statusBarHeight;
    
    // 웹뷰의 프레임을 네비게이션 바 아래로 설정합니다.
    self.webView = [[WKWebView alloc] initWithFrame:CGRectMake(0, topInset, self.view.frame.size.width, self.view.frame.size.height - topInset)];
    [self.view addSubview:self.webView];
    
    // URL 요청
    NSURL *url = [NSURL URLWithString:@"https://www.naver.com/"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    [self.webView loadRequest:request];
    
    // 자동 레이아웃 설정
    self.webView.translatesAutoresizingMaskIntoConstraints = NO;
    [NSLayoutConstraint activateConstraints:@[
        [self.webView.topAnchor constraintEqualToAnchor:self.view.topAnchor constant:topInset],
        [self.webView.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor],
        [self.webView.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor],
        [self.webView.bottomAnchor constraintEqualToAnchor:self.view.bottomAnchor]
    ]];
}

@end
