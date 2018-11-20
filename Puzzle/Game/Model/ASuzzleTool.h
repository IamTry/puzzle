//
//  ASuzzleTool.h
//  Puzzle
//
//  Created by The Clouds on 2018/11/8.
//  Copyright © 2018 FellowMe. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "ASuzzleBlockItemM.h"
#import "ASuzzleItemModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface ASuzzleTool : NSObject

+ (void)AS_saveBackImage:(UIImage *) backImage;
+ (UIImage *)getBackImage;
+ (void)AS_funPuzzleMove:(ASuzzleBlockItemM*)thePuzzleBlock withDragDirection:(int*)Direct;
+ (void)setPuzzleGroup:(NSMutableArray *) groupArr;
+ (void)AS_exchangePuzzleWithBank:(ASuzzleBlockItemM *)thePuzzleBlock;

@end

NS_ASSUME_NONNULL_END
