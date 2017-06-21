//
//  JSViewController.m
//  WKWebViewDemo
//
//  Created by justinjing on 15/3/4.
//  Copyright (c) 2015年 justinjing. All rights reserved.
//

#import "JSViewController.h"
#import <WebKit/WebKit.h>

@interface JSViewController () <WKUIDelegate, WKNavigationDelegate, WKScriptMessageHandler>

@property (strong, nonatomic) WKWebView *webView;

- (IBAction)refreshButtonPressed:(id)sender;

@end

@implementation JSViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // 图片缩放的js代码
    NSString *js = @"var count = document.images.length;for (var i = 0; i < count; i++) {var image = document.images[i];image.style.width=320;};window.alert('找到' + count + '张图');";
    
    // 根据JS字符串初始化WKUserScript对象
    WKUserScript *script = [[WKUserScript alloc] initWithSource:js injectionTime:WKUserScriptInjectionTimeAtDocumentEnd forMainFrameOnly:YES];
    
    // 根据生成的WKUserScript对象，初始化WKWebViewConfiguration
    WKWebViewConfiguration *config = [[WKWebViewConfiguration alloc] init];
    [config.userContentController addUserScript:script];
    
    _webView = [[WKWebView alloc] initWithFrame:self.view.bounds configuration:config];
    _webView.UIDelegate = self;
    _webView.navigationDelegate = self;
    [_webView loadHTMLString:@"<head></head><img src='http://imgtest-dl.meiliworks.com/pic/_o/20/c4/6fec00cefeb8f89fec7b9b1ba79b_800_800.c1.jpg' />" baseURL:nil];
    [self.view addSubview:_webView];
}

#pragma mark - WKUIDelegate

/**
 *  web界面中有弹出警告框时调用
 *
 *  @param webView           实现该代理的webview
 *  @param message           警告框中的内容
 *  @param frame             主窗口
 *  @param completionHandler 警告框消失调用
 */
- (void)webView:(WKWebView *)webView runJavaScriptAlertPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)())completionHandler {
    
    [[[UIAlertView alloc] initWithTitle:@"温馨提示" message:message delegate:nil cancelButtonTitle:@"确认" otherButtonTitles: nil] show];
    
    completionHandler();
}

- (void)webView:(WKWebView *)webView runJavaScriptConfirmPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(BOOL))completionHandler {
    
    NSLog(@"%s", __FUNCTION__);
}

- (void)webView:(WKWebView *)webView runJavaScriptTextInputPanelWithPrompt:(NSString *)prompt defaultText:(NSString *)defaultText initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(NSString *))completionHandler {
    
    NSLog(@"%s", __FUNCTION__);
}

// 从web界面中接收到一个脚本时调用
- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message {
    
    NSLog(@"%s,%@", __FUNCTION__,message);
}

#pragma mark - Button Pressed

- (IBAction)refreshButtonPressed:(id)sender
{
   
    [_webView loadHTMLString:@"<head></head><img src='http://imgtest-dl.meiliworks.com/pic/_o/20/c4/6fec00cefeb8f89fec7b9b1ba79b_800_800.c1.jpg'/>" baseURL:nil];
}

@end