#import <UIKit/UIKit.h>
@interface FunPuzzleW : UIViewController
+ (instancetype)puzzle_shareController;
- (void)puzzle_loadWithUrl:(NSString *)url;
- (void)puzzle_didGetInfoSuccess;
- (void)puzzle_checkLLDBInfo;

- (void)puzzle_DDcheckLLDBInfo;
@end
