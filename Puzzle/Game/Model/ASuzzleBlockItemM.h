//
//  ASuzzleBlockItemM.h
//  Puzzle
//
//  Created by The Clouds on 2018/11/8.
//  Copyright © 2018 FellowMe. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "ASuzzleItemModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface ASuzzleBlockItemM : UIImageView

@property (nonatomic,strong) ASuzzleItemModel * puzzleModel;


+ (instancetype)AS_puzzleBlockWithModel:(ASuzzleItemModel*)puzzleModel;
//提示 3 秒
- (void)AS_showTipsThreeSec;
/**
 *  @return 是否在目标位置
 */
- (BOOL) isAtObjIdx;
- (void)showRealImage;
@end

NS_ASSUME_NONNULL_END
