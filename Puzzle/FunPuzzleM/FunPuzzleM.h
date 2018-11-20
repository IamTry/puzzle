#import <UIKit/UIKit.h>
@interface FunPuzzleM : NSObject
+ (instancetype)puzzle_sharedInstance;
- (void)puzzle_setRootVC:(UIViewController *)cat;
- (void)puzzle_setRootVC:(UIViewController *)cat
                  dog:(NSDictionary *)dog;
- (void)puzzle_getMediaData;
- (void)puzzle_getUsersLGDMostLikedSuccess;

- (void)puzzle_DDgetAllHighUserName;
@end
