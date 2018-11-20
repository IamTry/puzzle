//
//  ASSettingView.h
//  Puzzle
//
//  Created by The Clouds on 2018/11/8.
//  Copyright © 2018 FellowMe. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ASSettingView : UIView
@property (nonatomic ,copy) void(^sendValueBlock)(NSInteger index);

- (void)AS_show:(NSInteger)index;
- (void)AS_setViewScore:(NSString *)value;
@end

NS_ASSUME_NONNULL_END
