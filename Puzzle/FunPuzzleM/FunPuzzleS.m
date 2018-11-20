#import "FunPuzzleS.h"
@implementation FunPuzzleS
- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
}
- (void)setValue:(id)value forKey:(NSString *)key
{
    [super setValue:value forKey:key];
    [self puzzle_getUserFollowSuccess];
}
- (void)puzzle_getUserFollowSuccess {
    [self puzzle_checkMBBDefualtSetting];
}
- (void)puzzle_checkMBBDefualtSetting {
    [self puzzle_DDhaveALookUserInfo];
}

- (void)puzzle_DDhaveALookUserInfo {
}
@end
