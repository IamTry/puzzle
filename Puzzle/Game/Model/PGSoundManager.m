//
//  YXSoundManager.m
//  FishingGame
//
//  Created by YxTAN on 2018/11/6.
//  Copyright © 2018 chh. All rights reserved.
//

#import "PGSoundManager.h"
#import <AVFoundation/AVFoundation.h>

@implementation PGSoundManager
// 类方法中不能用成员属性,所以只能定义全局变量
static NSMutableDictionary *_sounds;
static NSMutableDictionary *_players;

+ (instancetype)manager {
    static PGSoundManager *_shared = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _shared = [[PGSoundManager alloc] init];
    });
    return _shared;
}

// 懒加载字典
+ (void)initialize
{
    _sounds = [NSMutableDictionary dictionary];
    _players = [NSMutableDictionary dictionary];
}

- (void)playAudioWithSoundStatus:(BeatRabbitStatus)status {
    NSString *soundName = [PGSoundManager getMusicNameWithSoundStatus:status];
    if (_sounds[soundName] == nil) { // 先通过字典取,没有的话创建
        SystemSoundID soundID = 0;
        NSURL *url = [[NSBundle mainBundle] URLForResource:soundName withExtension:nil];
        AudioServicesCreateSystemSoundID((__bridge CFURLRef _Nonnull)(url), &soundID);
        // 存入集合
        _sounds[soundName] = @(soundID);
    }
    
    // playing
    AudioServicesPlaySystemSound([_sounds[soundName] unsignedIntValue]);
}



+ (void)playMusicWithSoundStatus:(BeatRabbitStatus)status {
    
     NSString *musicName = [PGSoundManager getMusicNameWithSoundStatus:status];
    //判断是否为空，为空程序直接崩溃
    assert(musicName);
    // 1.定义播放器
    AVAudioPlayer *player = nil;
    // 2.从字典中取player,如果取出出来是空,则对应创建对应的播放器
    player = _players[musicName];
    if (player == nil) {
        // 2.1.获取对应音乐资源
        NSURL *fileUrl = [[NSBundle mainBundle] URLForResource:musicName withExtension:nil];
        if (fileUrl == nil) return;
        // 2.2.创建对应的播放器
        player = [[AVAudioPlayer alloc] initWithContentsOfURL:fileUrl error:nil];
        // 2.3.将player存入字典中
        [_players setObject:player forKey:musicName];
        if (status == BeatRabbitStatus_Click || status == BeatRabbitStatus_Success) {
            [player setNumberOfLoops:0];
        }
        // 2.4.准备播放
        [player prepareToPlay];
        
    }
    // 3.播放音乐
    [player play];
    
}
//暂停音乐
+ (void)pauseMusicWithSoundStatus:(BeatRabbitStatus)status
{
     NSString *musicName = [PGSoundManager getMusicNameWithSoundStatus:status];
    assert(musicName);
    // 1.取出对应的播放
    AVAudioPlayer *player = _players[musicName];
    // 2.判断player是否nil
    if (player) {
        [player pause];
        
    }
    
}
//停止音乐
+ (void)stopMusicWithSoundStatus:(BeatRabbitStatus)status
{
    NSString *musicName = [PGSoundManager getMusicNameWithSoundStatus:status];
    assert(musicName);
    // 1.取出对应的播放
    AVAudioPlayer *player = _players[musicName];
    // 2.判断player是否nil
    if (player) {
        [player stop];
        [_players removeObjectForKey:musicName];
        player = nil;
    }
}

+ (NSString *)getMusicNameWithSoundStatus:(BeatRabbitStatus)status{
    NSString *soundName = nil;
    if (status == BeatRabbitStatus_CountBegin) {
        soundName = @"click_music.mp3";
    }else if (status == BeatRabbitStatus_CountEnd){
        soundName = @"countEnd.mp3";
    }else if (status == BeatRabbitStatus_Click){
        soundName = @"click_music.mp3";
    }else if (status == BeatRabbitStatus_Before){
        soundName = @"RabitHappy.mp3";
    }else if (status == BeatRabbitStatus_Success){
        soundName = @"success_music.mp3";
    }
    return soundName;
}


@end
