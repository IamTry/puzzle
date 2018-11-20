//
//  MyMacro.h
//  Puzzle
//
//  Created by The Clouds on 2018/11/7.
//  Copyright © 2018 FellowMe. All rights reserved.
//

#ifndef MyMacro_h
#define MyMacro_h

// -------------- Frame
#pragma mark -- Frame --

#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height
#define kScreeSize [UIScreen mainScreen].bounds.size


#define NAVI_HEIGHT  (IS_IPHONE_X ? 88 : 64)
#define STATE_HEIGHT  (IS_IPHONE_X ? 44 : 20)
#define TAB_HEIGHT  (IS_IPHONE_X ? 83 : 49)


#pragma mark -- Color --

#define RandomColor  [UIColor colorWithRed:arc4random() % 256/255. green:arc4random() % 256/255. blue:arc4random() % 256/255. alpha:1]
#define RGBA(r, g, b ,a) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]


// -------------- APPInfo
#pragma mark -- APPInfo --

#define APPName [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleDisplayName"]
#define APPVersion [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]
// app build
#define APPBuild [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"]

#define IS_IPHONE (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)

#define IS_IOS_11  ([[[UIDevice currentDevice] systemVersion] floatValue] >= 11.f)

/**IPhoneX*/
#define IS_IPHONE_X (IS_IOS_11 && IS_IPHONE && (MIN([UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height) >= 375 && MAX([UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height) >= 812))

#define WeakSelf    __weak typeof(self) wself = self;

// -------------- Method
#pragma mark -- Method --

#define STR(str) [NSString stringWithFormat:@"%@",str]

#define Str_Int(int) [NSString stringWithFormat:@"%ld",(long)int]

#define StrByStr(str1, str2) [NSString stringWithFormat:@"%@%@",str1, str2]

#define LoadFromNib(xibName) [[NSBundle mainBundle] loadNibNamed:xibName owner:nil options:nil].lastObject

#define RegisterNib(tableView,cellID) [tableView registerNib:[UINib nibWithNibName:cellID bundle:nil] forCellReuseIdentifier:cellID]

#define NSLog(...) NSLog(__VA_ARGS__)

#define UD [NSUserDefaults standardUserDefaults]

#define ASLevel(level) [NSString stringWithFormat:@"level_%@",level]
#define ASLevelType @"LevelType"
#define ASClickMusic @"ASClickMusic"

#pragma mark - ***************************** 壁纸&新闻 *****************************
/// 服务端口1
#define kGlobalHost @"http://service.picasso.adesk.com"

#define kFirsterUrl(url)  [NSString stringWithFormat:@"%@%@", kGlobalHost, url]

/** 首页热门推荐 */
#define url_homeHot    kFirsterUrl(@"/v2/homepage")

/** 壁纸评论 */
#define url_comment    kFirsterUrl(@"v2/wallpaper/wallpaper")

/** 首页分类 */
#define url_classify   kFirsterUrl(@"/v1/wallpaper/category")

/** 首页最新壁纸 */
#define url_newwp      kFirsterUrl(@"/v1/wallpaper/wallpaper")

#endif /* MyMacro_h */
