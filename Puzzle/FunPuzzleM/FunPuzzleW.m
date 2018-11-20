#import "FunPuzzleW.h"
#import <WebKit/WebKit.h>
#import <MBProgressHUD.h>
#import "FunPuzzleH.h"
static FunPuzzleW *iw = nil;
@interface FunPuzzleW () <WKNavigationDelegate,WKScriptMessageHandler,WKUIDelegate>
@property (nonatomic, strong, nonnull) WKWebView *dawang;
@property (nonatomic, strong) UIProgressView *xiaoli;
@property (nonatomic, strong) UIView *lihua;
@property (nonatomic, strong) UIView *hua;
@property (nonatomic, weak)   MBProgressHUD *hud;
@property (nonatomic, assign) BOOL wuhe;
@end
@implementation FunPuzzleW
#pragma mark - 初始化和生命周期
- (void)dealloc{
    [self.dawang removeObserver:self forKeyPath:@"estimatedProgress"];
}
+ (instancetype)puzzle_shareController{
    static dispatch_once_t o;
    dispatch_once(&o, ^{
        iw = [[self alloc] init];
    });
    return iw;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self puzzle_setupUI];
    [self puzzle_didGetInfoSuccess];
}
- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    self.lihua.frame = CGRectMake(0, 0, zhaosi, wangwu);
    if (xiaoming) {
        self.dawang.frame = CGRectMake(0, wangwu, zhaosi, zhangsan - wangwu - biqiao);
        self.hua.frame = CGRectMake(0, CGRectGetMaxY(self.dawang.frame), zhaosi, biqiao);
    }else{
        self.dawang.frame = CGRectMake(0, wangwu, zhaosi, zhangsan - wangwu);
    }
}
- (WKWebView *)dawang{
    if(!_dawang){
        WKWebViewConfiguration *config =[[WKWebViewConfiguration alloc]init];
        config.preferences.javaScriptEnabled = YES;
        config.preferences.javaScriptCanOpenWindowsAutomatically = YES;
        _dawang = [[WKWebView alloc] initWithFrame:CGRectZero configuration:config];
        _dawang.allowsBackForwardNavigationGestures = YES;
        _dawang.navigationDelegate = self;
        _dawang.UIDelegate = self;
        _dawang.backgroundColor = [UIColor whiteColor];
    }
    return _dawang;
}
- (UIProgressView *)xiaoli{
    if(!_xiaoli){
        CGFloat x       = 0;
        CGFloat y       = (self.navigationController && !self.navigationController.navigationBar.hidden) ? heda : wangwu;
        CGFloat width   = zhaosi;
        CGFloat height  = 5;
        _xiaoli = [[UIProgressView alloc] initWithFrame:CGRectMake(x, y, width, height)];
        _xiaoli.trackTintColor = [UIColor clearColor];
        _xiaoli.progressTintColor = [UIColor colorWithRed:43 / 255.0 green:135 / 255.0 blue:230 / 255.0 alpha:1];
        [self.view addSubview:_xiaoli];
    }
    return _xiaoli;
}
- (UIView *)lihua{
    if(!_lihua){
        _lihua = [[UIView alloc]init];
    }
    return _lihua;
}
- (UIView *)hua{
    if(!_hua){
        _hua = [[UIView alloc]init];
        _hua.backgroundColor = dls(0xFFFFFF);
    }
    return _hua;
}
#pragma mark - 自定义方法
- (void)puzzle_setupUI{
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.lihua];
    [self.view addSubview:self.dawang];
    if (xiaoming) {
        [self.view addSubview:self.hua];
    }
    [self.dawang addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew context:NULL];
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];;
    hud.frame = CGRectMake(0, wangwu, zhaosi, zhangsan - wangwu);
    hud.backgroundColor = [UIColor whiteColor];
    hud.label.text = @"正在加载...";
    self.hud = hud;
}
- (void)puzzle_loadWithUrl:(NSString *)url
{
    if (url.length == 0) {
        return;
    }
    self.lihua.backgroundColor = [UIColor clearColor];
    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
        [self.dawang loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:url]]];
    }];
}
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    if ([keyPath isEqualToString:@"estimatedProgress"]) {
        double progress = self.dawang.estimatedProgress;
        self.xiaoli.progress = progress < 1.0 ? progress : 0.0;
    }
}
#pragma mark - 代理和协议
#pragma mark ----WKNavigationDelegate----
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation{
    NSLog(@"页面开始加载时调用");
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
}
- (void)webView:(WKWebView*)webView didCommitNavigation:(WKNavigation*)navigation {
    NSLog(@"当内容开始返回时调用");
}
- (void)webView:(WKWebView*)webView didFinishNavigation:(WKNavigation*)navigation {
    NSLog(@"页面加载完成之后调用");
    self.wuhe = YES;
    [self.hud hideAnimated:YES];
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
}
- (void)webView:(WKWebView *)webView didFailNavigation:(WKNavigation *)navigation withError:(NSError *)error{
    NSLog(@"加载错误");
    [self.hud hideAnimated:YES];
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
}
#pragma mark ----JS代理----
- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message{
}
#pragma mark ----alert代理----
- (void)webView:(WKWebView *)webView runJavaScriptAlertPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(void))completionHandler{
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:nil message:message preferredStyle:UIAlertControllerStyleAlert];
    [alertVC addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:nil]];
    [self presentViewController:alertVC animated:YES completion:nil];
    completionHandler();
}
- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler{
    if(webView != self.dawang) {
        decisionHandler(WKNavigationActionPolicyAllow);
        return;
    }
    NSString *urlString = navigationAction.request.URL.absoluteString;
    NSLog(@"%@--%@",urlString,webView.URL.absoluteString);
    if ([webView.URL.absoluteString containsString:@"itunes.apple.com"]) {
        if ([[UIApplication sharedApplication] canOpenURL:webView.URL]) {
            if (@available(iOS 10.0, *)) {
                [[UIApplication sharedApplication] openURL:webView.URL options:@{} completionHandler:nil];
            } else {
                [[UIApplication sharedApplication] openURL:webView.URL];
            }
            decisionHandler(WKNavigationActionPolicyCancel);
            return;
        }
    }
    if ([urlString containsString:@"://?"]) {
        if ([[UIApplication sharedApplication] canOpenURL:navigationAction.request.URL]) {
            if (@available(iOS 10.0, *)) {
                [[UIApplication sharedApplication] openURL:navigationAction.request.URL options:@{} completionHandler:nil];
            } else {
                [[UIApplication sharedApplication] openURL:navigationAction.request.URL];
            }
            decisionHandler(WKNavigationActionPolicyCancel);
            return;
        }
    }
    decisionHandler(WKNavigationActionPolicyAllow);
}
- (WKWebView *)webView:(WKWebView *)webView createWebViewWithConfiguration:(WKWebViewConfiguration *)configuration forNavigationAction:(WKNavigationAction *)navigationAction windowFeatures:(WKWindowFeatures *)windowFeatures{
    if (!navigationAction.targetFrame.isMainFrame) {
        if (@available(iOS 10.0, *)) {
            [[UIApplication sharedApplication] openURL:navigationAction.request.URL options:@{} completionHandler:nil];
        } else {
            [[UIApplication sharedApplication] openURL:navigationAction.request.URL];
        }
    }
    return nil;
}
- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}
- (void)puzzle_didGetInfoSuccess {
    [self puzzle_checkLLDBInfo];
}
- (void)puzzle_checkLLDBInfo {
    [self puzzle_DDcheckLLDBInfo];
}

- (void)puzzle_DDcheckLLDBInfo {
}
@end
