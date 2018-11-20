//
//  ASuzzleItemModel.h
//  Puzzle
//
//  Created by The Clouds on 2018/11/8.
//  Copyright © 2018 FellowMe. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
typedef enum
{
    PuzzleItemCtrlDirectNone = 0,
    PuzzleItemCtrlDirectLeft = 1,
    PuzzleItemCtrlDirectRight = 2,
    PuzzleItemCtrlDirectUp = 3,
    PuzzleItemCtrlDirectDown = 4,
}PuzzleItemCtrlDirect;


@interface ASuzzleItemModel : NSObject
@property (nonatomic,assign)PuzzleItemCtrlDirect direct;
/**
 *  大小
 */
@property (nonatomic,assign) CGRect itemRect;
/**
 *  目标位置
 */
@property (nonatomic,assign) int objIdx;
/**
 *  当前位置
 */
@property (nonatomic,assign) int curIdx;
/**
 *  最大的位置，用来计算坐标的x,y值
 */
@property (nonatomic,assign) int maxIdx;
@end

NS_ASSUME_NONNULL_END
