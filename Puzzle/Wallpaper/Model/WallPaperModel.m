//
//  WallPaperModel.m
//  Puzzle
//
//  Created by The Clouds on 2018/11/19.
//  Copyright © 2018 FellowMe. All rights reserved.
//

#import "WallPaperModel.h"

@implementation WallPaperModel
+ (NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{
             @"Id": @"id",
             @"coverTemp": @"cover_temp",
             @"picassoCover": @"picasso_cover"
             };
}
@end
