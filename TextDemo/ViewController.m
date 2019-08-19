//
//  ViewController.m
//  TextDemo
//
//  Created by BaoBaoDaRen on 2019/1/4.
//  Copyright © 2019年 BaoBao. All rights reserved.
//

#import "ViewController.h"
#import "AFNetworking.h"

@interface ViewController ()<WKNavigationDelegate,UIScrollViewDelegate,UIGestureRecognizerDelegate>

@property (nonatomic, strong) WKWebView *webV;
@property (nonatomic, strong) UIView    *netWorkV;
@property (nonatomic, strong) UIButton  *leftBtn;
@property (nonatomic, strong) NSString  *currentTitle;
@property (nonatomic, strong) UIActivityIndicatorView *indicatorV;
@property (nonatomic, strong) UIView *shadeV;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    
    if ([self respondsToSelector:@selector(setEdgesForExtendedLayout:)])
    {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.navigationController.navigationBar.translucent = NO;
    
    
    [self reloadUrl];
    
}

- (void)reloadUrl
{
    self.leftBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 40, 30)];
    [self.leftBtn setTitle:@"返回" forState:UIControlStateNormal];
    [self.leftBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    self.leftBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    self.leftBtn.hidden = YES;
    self.leftBtn.titleLabel.adjustsFontSizeToFitWidth = YES;
    [self.leftBtn addTarget:self action:@selector(leftBtnBarItemClick) forControlEvents:UIControlEventTouchUpInside];

    UIBarButtonItem *leftBar = [[UIBarButtonItem alloc] initWithCustomView:self.leftBtn];
    self.navigationItem.leftBarButtonItem = leftBar;
    
    self.webV = [[WKWebView alloc] initWithFrame:CGRectMake(0, -45, self.view.frame.size.width, SCREEN_HEIGHT - NavBar_H - StatusBar_H + 45)];
    [self.view addSubview:self.webV];
    _webV.scrollView.bounces = NO;
    _webV.scrollView.delegate = self;
    _webV.navigationDelegate = self;
    _webV.scrollView.showsVerticalScrollIndicator = NO;
//    [self.webV loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"https://i.ifeng.com/idyn/inews/0/52227/0/10/10/list.shtml"]]];
    
    [self.webV loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"https://demo.b2b2c.shopxx.net/"]]];

    if (@available(iOS 11.0, *)) {
        self.webV.scrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        // Fallback on earlier versions
    }
    
    //单击
    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(TapsAction)];
    
    [self.webV addGestureRecognizer:longPress];

    [self showNetViewUi];
    
    NSTimer *timer = [NSTimer timerWithTimeInterval:2.0 target:self selector:@selector(networkStateChange:) userInfo:nil repeats:NO];
    [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
    
    self.indicatorV = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    self.indicatorV.frame = self.view.bounds;
    self.indicatorV.center = CGPointMake(SCREEN_WIDTH / 2, SCREEN_HEIGHT / 2 - 100);
   
    self.shadeV = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    [self.view addSubview:self.shadeV];
    self.shadeV.hidden = YES;
    self.shadeV.userInteractionEnabled = NO;
    [self.shadeV addSubview:self.indicatorV];
    self.shadeV.backgroundColor = [UIColor blackColor];
    self.shadeV.alpha = 0.3;
    [self.indicatorV startAnimating];

    // [objc] view plain copy - (void)viewDidAppear:(BOOL)animated { [super viewDidAppear:animated]; //修复bug:第一次长按 不弹出复制菜单 [[_webView.scrollView.subviews firstObject] becomeFirstResponder]; [[NSOperationQu...
   
    // 强制不弹出copy等菜单...
    [[self.webV.scrollView.subviews firstObject] becomeFirstResponder];
    
    
    
}
- (void)leftBtnBarItemClick
{
    if ([self.webV canGoBack]) {
        
        [self.webV goBack];
    } else {
        self.leftBtn.hidden = YES;
    }
}
-(BOOL)gestureRecognizer:(UIGestureRecognizer*)gestureRecognizer shouldReceiveTouch:(UITouch*)touch {
    
    if([NSStringFromClass([touch.view class])isEqual:@"UITableViewCellContentView"])
    {
        return NO;
    }else
    {
        return YES;
    }
}

- (void)TapsAction
{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:@"保存图片" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        
    }];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [alert addAction:okAction];
    [alert addAction:cancelAction];
    [self presentViewController:alert animated:YES completion:nil];

}



#pragma mark - 加载的状态回调 （WKNavigationDelegate）
// 页面开始加载时调用
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation
{
//    self.shadeV.hidden = NO;
    self.shadeV.hidden = YES;

//    [self.indicatorV startAnimating];
    [self.indicatorV stopAnimating];
    
    if ([self.webV canGoBack]) {
        
        self.leftBtn.hidden = NO;
    } else {
        self.leftBtn.hidden = YES;
    }
}
// 当内容开始返回时调用
- (void)webView:(WKWebView *)webView didCommitNavigation:(WKNavigation *)navigation
{
    
}
// 页面加载完成之后调用
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation
{
    // 取消webView长按超链接
    [webView evaluateJavaScript:@"document.documentElement.style.webkitUserSelect='none';" completionHandler:^(id _Nullable strings, NSError * _Nullable error) {
   
    }];
    [webView evaluateJavaScript:@"document.documentElement.style.webkitTouchCallout='none';" completionHandler:^(id _Nullable strings, NSError * _Nullable error) {
        
    }];
    
    self.shadeV.hidden = YES;
    [self.indicatorV stopAnimating];
    
    self.netWorkV.hidden = YES;
    if ([self.webV canGoBack]) {
        
        self.leftBtn.hidden = NO;
        [webView evaluateJavaScript:@"document.title" completionHandler:^(id _Nullable strings, NSError * _Nullable error) {
            
            
            NSString *getTit = [NSString stringWithFormat:@"%@",strings];
            if (!IsStrEmpty(getTit)) {
                
                self.title = getTit;
                self.currentTitle = getTit;
            } else {
                self.title = @"商品";
                self.currentTitle = @"商品";
            }
        }];
    } else {
        
        self.leftBtn.hidden = YES;
        self.title = @"首页";
        self.currentTitle = @"首页";
    }
}
// 页面加载失败时调用
- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation
{
    
}
- (void)webView:(WKWebView *)webView didFailNavigation:(null_unspecified WKNavigation *)navigation withError:(NSError *)error
{
    self.netWorkV.hidden = NO;
}
- (void)networkStateChange:(NSTimer *)timer
{
    [timer invalidate];
    timer = nil;
    
    // 如果要检测网络状态的变化,必须用检测管理器的单例的startMonitoring
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
    [[AFNetworkReachabilityManager sharedManager]setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        NSLog(@"%ld",(long)status);
        
        if (status == AFNetworkReachabilityStatusNotReachable) {
            
            self.shadeV.hidden = YES;
            [self.indicatorV stopAnimating];

            self.netWorkV.hidden = NO;
            if (!IsStrEmpty(self.currentTitle)) {
                
                self.title = self.currentTitle;
            } else {
                self.title = @"首页";
            }
        } else {
            self.netWorkV.hidden = YES;
            
            if ([self.title isEqualToString:@"首页"]) {
                
                [self.webV loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"https://demo.b2b2c.shopxx.net/"]]];
            } else {
                
                [self.webV reload];
            }
        }
        
        switch (status) {
                
            case AFNetworkReachabilityStatusUnknown:
                NSLog(@"网络错误");
                break;
                
            case AFNetworkReachabilityStatusNotReachable:
                NSLog(@"没有连接网络");
                break;
                
            case AFNetworkReachabilityStatusReachableViaWWAN:
                NSLog(@"手机自带网络");
                break;
                
            case AFNetworkReachabilityStatusReachableViaWiFi:
                NSLog(@"wifi");
                break;
                
        }
    }];
   
    
}


// 接收到服务器跳转请求之后调用
- (void)webView:(WKWebView *)webView didReceiveServerRedirectForProvisionalNavigation:(WKNavigation *)navigation
{

}
// 在收到响应后，决定是否跳转
- (void)webView:(WKWebView *)webView decidePolicyForNavigationResponse:(WKNavigationResponse *)navigationResponse decisionHandler:(void (^)(WKNavigationResponsePolicy))decisionHandler
{
    decisionHandler(WKNavigationResponsePolicyAllow);
}
- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler
{
    decisionHandler(WKNavigationActionPolicyAllow);
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat offsetY = scrollView.contentOffset.y;
    if (offsetY > self.view.frame.size.height) {
        
        [[ClientEngine sharedEntity] hidTabBar:YES];
    } else {
        
        [[ClientEngine sharedEntity] hidTabBar:NO];
    }
}

- (void)showNetViewUi
{
    self.netWorkV = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, self.webV.frame.size.height)];
    self.netWorkV.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.netWorkV];
    
    // TODO FIXME:隐藏...
    self.netWorkV.hidden = YES;
    
    UIImageView *failImgV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 150, 150)];
    [self.netWorkV addSubview:failImgV];
    failImgV.image = [UIImage imageNamed:@"wangluoyichang"];
    failImgV.center = CGPointMake(SCREEN_WIDTH / 2, SCREEN_HEIGHT / 2 - failImgV.frame.size.height);
    
    UIButton *reloadBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 120, 45)];
    [self.netWorkV addSubview:reloadBtn];
    reloadBtn.center = CGPointMake(SCREEN_WIDTH / 2, failImgV.center.y + failImgV.frame.size.height / 2 + 15);
    reloadBtn.layer.masksToBounds = YES;
    reloadBtn.layer.cornerRadius = 5;
    reloadBtn.backgroundColor = [UIColor lightGrayColor];
    [reloadBtn setTitle:@"点我重试" forState:UIControlStateNormal];
    [reloadBtn addTarget:self action:@selector(reloadBtnAction) forControlEvents:UIControlEventTouchUpInside];

    
}
- (void)reloadBtnAction
{
    if ([self.title isEqualToString:@"首页"]) {
        
        [self.webV loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"https://demo.b2b2c.shopxx.net/"]]];
    } else {
        
        [self.webV reload];
    }
}






- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
