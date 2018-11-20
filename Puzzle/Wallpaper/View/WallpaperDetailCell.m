//
//  WallpaperDetailCell.m
//  Puzzle
//
//  Created by The Clouds on 2018/11/19.
//  Copyright © 2018 FellowMe. All rights reserved.
//

#import "WallpaperDetailCell.h"
#import <UIImageView+WebCache.h>

@implementation WallpaperDetailCell
- (void)setModel:(WallPaperModel *)model{
    [_imgView sd_setImageWithURL:[NSURL URLWithString:model.img]];
}
@end
