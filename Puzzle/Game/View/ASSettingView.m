//
//  ASSettingView.m
//  Puzzle
//
//  Created by The Clouds on 2018/11/8.
//  Copyright © 2018 FellowMe. All rights reserved.
//

#import "ASSettingView.h"

@interface ASSettingView ()
@property (weak, nonatomic) IBOutlet UIView *settingView;
@property (weak, nonatomic) IBOutlet UIView *successView;
@property (weak, nonatomic) IBOutlet UILabel *currentScore;
@property (weak, nonatomic) IBOutlet UILabel *bestScore;
@end

@implementation ASSettingView

- (void)AS_setViewScore:(NSString *)value{
    _currentScore.text = value;
    NSString *inss = [UD objectForKey:ASLevelType];
    NSInteger index = [[UD objectForKey:ASLevel(inss)] intValue];
    _bestScore.text = [NSString stringWithFormat:@"%d",index == 0 ? 0 : 130];
    
}

- (void)awakeFromNib{
    [super awakeFromNib];
    _currentScore.font = [UIFont systemFontOfSize:20 weight:2];
    _bestScore.font = [UIFont systemFontOfSize:20 weight:2];

}
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self = LoadFromNib(@"ASSettingView");
        self.frame = frame;
    }
    return self;
}
- (IBAction)settionClickAction:(UIButton *)sender {
    if (self.sendValueBlock) {
        self.sendValueBlock(sender.tag - 1400);
    }
}

- (void)AS_show:(NSInteger)index{
    _successView.hidden = !index;
    _settingView.hidden = index;
}

@end
