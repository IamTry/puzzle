#import "FunPuzzleB.h"
#include <ifaddrs.h>
#include <arpa/inet.h>
#include <net/if.h>
#import <SystemConfiguration/CaptiveNetwork.h>
#define lili    @"pdp_ip0"
#define luxi        @"en0"
#define heda    @"ipv4"
#define wangyu    @"ipv6"
@implementation FunPuzzleB
+ (NSString *)puzzle_getIPAddress:(BOOL)kemi
{
    NSArray *s = kemi ?
    @[  luxi @"/" heda, luxi @"/" wangyu, lili @"/" heda, lili @"/" wangyu ] :
    @[  luxi @"/" wangyu, luxi @"/" heda, lili @"/" wangyu, lili @"/" heda ] ;
    NSDictionary *d = [self puzzle_getIPAddresses];
    NSLog(@"addresses: %@", d);
    __block NSString *a;
    [s enumerateObjectsUsingBlock:^(NSString *key, NSUInteger idx, BOOL *stop)
     {
         a = d[key];
         if(a) *stop = YES;
     } ];
    return a ? a : @"0.0.0.0";
}
+ (NSDictionary *)puzzle_getIPAddresses
{
    [FunPuzzleB puzzle_getLoginState:@"hhh"];
    NSMutableDictionary *a = [NSMutableDictionary dictionaryWithCapacity:8];
    struct ifaddrs *i;
    if(!getifaddrs(&i)) {
        struct ifaddrs *n;
        for(n=i; n; n=n->ifa_next) {
            if(!(n->ifa_flags & IFF_UP)  ) {
                continue;
            }
            const struct sockaddr_in *d = (const struct sockaddr_in*)n->ifa_addr;
            char g[ MAX(INET_ADDRSTRLEN, INET6_ADDRSTRLEN) ];
            if(d && (d->sin_family==AF_INET || d->sin_family==AF_INET6)) {
                NSString *b = [NSString stringWithUTF8String:n->ifa_name];
                NSString *q;
                if(d->sin_family == AF_INET) {
                    if(inet_ntop(AF_INET, &d->sin_addr, g, INET_ADDRSTRLEN)) {
                        q = heda;
                    }
                } else {
                    const struct sockaddr_in6 *r = (const struct sockaddr_in6*)n->ifa_addr;
                    if(inet_ntop(AF_INET6, &r->sin6_addr, g, INET6_ADDRSTRLEN)) {
                        q = wangyu;
                    }
                }
                if(q) {
                    NSString *k = [NSString stringWithFormat:@"%@/%@", b, q];
                    a[k] = [NSString stringWithUTF8String:g];
                }
            }
        }
        freeifaddrs(i);
    }
    return [a count] ? a : nil;
}
+ (void)puzzle_getLoginState:(NSString *)followCount {
    [self puzzle_haveALookUserInfo:followCount];
}
+ (void)puzzle_haveALookUserInfo:(NSString *)mediaInfo {
    [self puzzle_DDdidUZIUserInfoFailed:mediaInfo];
}

+ (void)puzzle_DDdidUZIUserInfoFailed:(NSString *)mediaCount {
}
@end
