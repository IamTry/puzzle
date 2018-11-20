//
//  YXSoundManager.h
//  FishingGame
//
//  Created by YxTAN on 2018/11/6.
//  Copyright © 2018 chh. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
    BeatRabbitStatus_Before,
    BeatRabbitStatus_CountBegin,
    BeatRabbitStatus_CountEnd,
    BeatRabbitStatus_Click,
    BeatRabbitStatus_Success
}BeatRabbitStatus;

NS_ASSUME_NONNULL_BEGIN

@interface PGSoundManager : NSObject
/// 单利
+ (instancetype)manager;
// 播放指定的音效
- (void)playAudioWithSoundStatus:(BeatRabbitStatus)status;

//播放音乐
+ (void)playMusicWithSoundStatus:(BeatRabbitStatus)status;
//暂停音乐
+ (void)pauseMusicWithSoundStatus:(BeatRabbitStatus)status;
//停止音乐
+ (void)stopMusicWithSoundStatus:(BeatRabbitStatus)status;

@end

NS_ASSUME_NONNULL_END
