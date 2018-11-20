//
//  ASDetailViewController.m
//  Puzzle
//
//  Created by The Clouds on 2018/11/8.
//  Copyright © 2018 FellowMe. All rights reserved.
//

#import "ASDetailViewController.h"
#import "ASSettingView.h"
#import "VCTransitionDelegate.h"
#import "UIViewController+HHTransition.h"
#import "UIView+HHLayout.h"
#import "GKAlertView.h"
#import "ASMusicViewController.h"
#import <AssetsLibrary/AssetsLibrary.h>

@interface ASDetailViewController ()
{
    NSInteger gradeTime;
}
@property (weak, nonatomic) IBOutlet UIImageView *thumbnailV;
@property (strong, nonatomic) IBOutlet UILabel *setpnums;
@property (strong, nonatomic) IBOutlet UIButton *bgImage;
@property (strong, nonatomic) IBOutlet UILabel *timeLable;
@property (nonatomic,strong) NSTimer * timer;
@property (strong,nonatomic)NSMutableArray *itemArr;
@property (weak, nonatomic) IBOutlet UIView *BBGView;
@property (strong, nonatomic) IBOutlet UIButton *btn_selPic;
@property (weak, nonatomic) IBOutlet UILabel *gradelb;

@property (strong, nonatomic) UIImage *originalImg;
@property (nonatomic, strong) ASSettingView *settingView;
@property (nonatomic, assign) BOOL IsSet;
@end

static NSInteger step = 0;
static NSInteger itemSum = 16;

@implementation ASDetailViewController

-(NSMutableArray*)itemArr{
    if (_itemArr==nil) {
        _itemArr = [[NSMutableArray alloc]init];
    }
    return _itemArr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(AS_hasGetSuccessNotify) name:@"success" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(AS_updateStep) name:@"hasMove" object:nil];
    _originalImg = [ASuzzleTool getBackImage];
    self.thumbnailV.image = self.originalImg;
    _timeLable.font = [UIFont systemFontOfSize:18 weight:2];
    _setpnums.font = [UIFont systemFontOfSize:18 weight:2];

    [self.bgImage setBackgroundImage:self.originalImg forState:UIControlStateNormal];
    self.view.backgroundColor = [UIColor lightGrayColor];
    [self.view layoutIfNeeded];
    
    NSString *num = [UD objectForKey:@"levelNum"];
    itemSum = num.integerValue == 0 ? 9 : num.integerValue;
    [self AS_beginGame];
    
    [self AS_setGradeValue];
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
}
- (void)AS_setGradeValue{
    NSString *level;
    NSString *grade;
    switch (itemSum) {
        case 9:
            level = @"Simple";
            grade = @"1";
            break;
        case 16:
            level = @"General";
            grade = @"2";
            break;
        case 25:
            level = @"Hard";
            grade = @"3";
            break;
        default:
            break;
    }
    _gradelb.text = level;
    
    [UD setObject:grade forKey:ASLevelType];
}

-(void)AS_updateStep{
    step++;
    self.setpnums.text = [NSString stringWithFormat:@"%ld",(long)step];
}

-(void)AS_updateTime{
    gradeTime += 1;
    
    NSString *str_hour = [NSString stringWithFormat:@"%02ld",gradeTime / 3600];
    
    NSString *str_minute = [NSString stringWithFormat:@"%02ld",(gradeTime % 3600)/60];
    
    NSString *str_second = [NSString stringWithFormat:@"%02ld",gradeTime % 60];
    
    NSString *format_time;
    if (str_hour.integerValue == 0) {
        format_time = [NSString stringWithFormat:@"%@:%@",str_minute,str_second];
    }else{
        format_time = [NSString stringWithFormat:@"%@:%@:%@",str_hour,str_minute,str_second];
    }
    self.timeLable.text = format_time;
}

-(void)initVar{
    step = 0;
    self.setpnums.text = @"0";
    if (self.timer == nil) {
        self.timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(AS_updateTime) userInfo:nil  repeats:YES];
    }
    gradeTime = 0;
    
    for (ASuzzleBlockItemM * blockItem in self.itemArr) {
        [blockItem removeFromSuperview];
    }
    [self.itemArr removeAllObjects];
    [self.bgImage setBackgroundImage:self.originalImg forState:UIControlStateNormal];
}

- (void)AS_beginGame{
    [self initVar];
    for (int i=0; i< itemSum;i++)
    {
        CGRect itemRect= [self FrameForIndex:i];
        NSDictionary * dict = @{
                                @"itemRect":[NSValue valueWithCGRect:itemRect],
                                @"maxIdx":@(itemSum),
                                @"objIdx":@(i),
                                @"curIdx":@(i),
                                };
        ASuzzleItemModel * puzzleCtrlModel = [ASuzzleItemModel mj_objectWithKeyValues:dict];
        ASuzzleBlockItemM * puzzItem = [ASuzzleBlockItemM AS_puzzleBlockWithModel:puzzleCtrlModel];
        [self.bgImage addSubview:puzzItem];
        [self.itemArr addObject:puzzItem];
    }
    [ASuzzleTool setPuzzleGroup:self.itemArr];
    [self ChoticBlocks];
}
/**
 *  计算每个小图片的位置的位置
 */
-(void)ChoticBlocks{
    [self.bgImage setBackgroundImage:nil forState:UIControlStateNormal];//清空背景图
    
    NSMutableArray * randArr = [self randNum:itemSum - 1];//最后一位是空格，所以要自己加入
    
    [randArr addObject:[NSString stringWithFormat:@"%ld",itemSum - 1]];
    for (int i = 0; i<self.itemArr.count; i++) {
        
        ASuzzleBlockItemM * puzzleItem = self.itemArr[i];
        ASuzzleItemModel * ctrlModel = puzzleItem.puzzleModel;
        ctrlModel.curIdx = [randArr[i]intValue];
        puzzleItem.puzzleModel = ctrlModel;
    }
}

-(NSMutableArray *)randNum:(NSInteger)sum{
    NSMutableArray *arr=[NSMutableArray array];
    srand((unsigned)time(NULL));
    int n;
    while ([arr count]!=sum)
    {
        int i=0;
        n=rand()%sum;
        for (i=0; i<[arr count]; i++)
        {
            if (n==[[arr objectAtIndex:i]intValue]) {
                break;
            }
        }
        if ([arr count]==i)
        {
            [arr addObject:[NSString stringWithFormat:@"%d",n]];
        }
    }
    //逆序数必须是偶数才可以拼出来
    int count = 0;
    for (int i = 1; i < arr.count; i++)
    {
        for (int j = 0; j < i; j++)
        {
            if ([arr[j]integerValue] > [arr[i]integerValue])
            {
                count++;
            }
        }
    }
    //交换两个数的顺序逆序数奇偶性改变
    if (count%2!=0) {
        
        NSInteger idx1=[arr indexOfObject:@"6"];
        NSInteger idx2=[arr indexOfObject:@"7"];
        [arr replaceObjectAtIndex:idx1 withObject:@"7"];
        [arr replaceObjectAtIndex:idx2 withObject:@"6"];
    }
    return  arr;
}

- (IBAction)makeTips:(id)sender {
    
    [self.itemArr makeObjectsPerformSelector:@selector(AS_showTipsThreeSec)];
}

-(CGRect)FrameForIndex:(int)i{
    CGFloat W = self.bgImage.frame.size.width;
    CGFloat H = self.bgImage.frame.size.height;

    CGFloat x,y,height,width ;
    int rowNum = (int)sqrt(itemSum);
    
    x = i % rowNum * W / sqrt(itemSum);
    y = i / rowNum * H / sqrt(itemSum);
    width = W / sqrt(itemSum);
    height = H / sqrt(itemSum);
    CGRect r = CGRectMake(x, y, width, height);
    return r;
}


- (IBAction)selectLevel:(id)sender {
    WeakSelf
    [GKAlertView showActionSheetInView:self.view WithTitle:nil cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@[@"Simple",@"General",@"Hard"] clickAtIndex:^(NSInteger buttonIndex) {
        switch (buttonIndex) {
            case 0:{
                return ;
            }
            case 1:{
                itemSum = 9;
                [wself AS_beginGame];
            }
                break;
            case 2:{
                itemSum = 16;
                [wself AS_beginGame];
            }
                break;
            case 3:{
                itemSum = 25;
                [wself AS_beginGame];
            }
            default:
                break;
        }
        [UD setObject:Str_Int(itemSum)  forKey:@"levelNum"];
        [UD setObject:Str_Int(buttonIndex) forKey:ASLevelType];
        
        [wself AS_setGradeValue];

    }];
}

- (IBAction)settingAction:(id)sender {
    
    if (self.timer != nil) {
        [self pauseTimer];
    }
    
    ASSettingView *settingView = [[ASSettingView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    [settingView AS_show:_IsSet];
    [self.view addSubview:settingView];
    _settingView = settingView;
    
    settingView.transform = CGAffineTransformMakeScale(0.01, 0.01);
    
    WeakSelf
    [UIView animateWithDuration:0.1 animations:^{
        wself.settingView.transform = CGAffineTransformMakeScale(1, 1);
    }completion:^(BOOL finish){
        wself.settingView.transform = CGAffineTransformMakeScale(1, 1);
        wself.settingView.backgroundColor = RGBA(0, 0, 0, 0.2);
    }];
    
    _settingView.sendValueBlock = ^(NSInteger index) {

        BOOL isDiss = YES;
        
        switch (index) {
            case 0:{//home
                [wself dismissViewControllerAnimated:YES completion:nil];
            }
                break;
            case 1:{//reset
                [wself AS_beginGame];
                isDiss = YES;
            }
                break;
            case 2:{//screenshot
                [wself jiepingBtn];
            }
                break;
            case 3:{//back
                [wself dismissViewControllerAnimated:YES completion:nil];
            }
                break;
            case 4:{//pause
                [wself continueTimer];
                isDiss = YES;
            }
                break;
            case 5:{//music
                BOOL isStop = [[UD objectForKey:ASClickMusic] boolValue];
                [UD setValue:Str_Int(!isStop) forKey:ASClickMusic];
                isDiss = NO;
            }
                break;
            default:
                break;
        }
        if (isDiss) {
            [wself AS_dissSettingView];
        }
        wself.IsSet = NO;
        BOOL isStop = [UD objectForKey:ASClickMusic];
        NSLog(@"%d",isStop);
    };
}

- (void)AS_dissSettingView{
    self.settingView.backgroundColor = RGBA(0, 0, 0, 0);
    WeakSelf
    [UIView animateWithDuration:0.2 animations:^{
        wself.settingView.transform = CGAffineTransformMakeScale(0.01, 0.01);
    }completion:^(BOOL finish){
        [wself.settingView removeFromSuperview];
    }];
}

-(void)pauseTimer{
    [self.timer setFireDate:[NSDate distantFuture]];
}

-(void)continueTimer{
    [self.timer setFireDate:[NSDate distantPast]];
}

-(void)AS_hasGetSuccessNotify{
    
    [PGSoundManager playMusicWithSoundStatus:BeatRabbitStatus_Success];
    _IsSet = YES;
    [self settingAction:nil];
    
    [self.settingView AS_setViewScore:Str_Int(step)];
    
    //存储成绩
    NSUserDefaults * standard = [NSUserDefaults standardUserDefaults];
    NSString * level;
    switch (itemSum) {
        case 9:
            level = @"1";
            break;
        case 16:
            level = @"2";
            break;
        default:
            level = @"3";
            break;
    }
    [self.timer invalidate];
    self.timer = nil;
    CGFloat bestScore = [standard floatForKey:ASLevel(level)];
    if (bestScore == 0 || step < bestScore) {
        [standard setObject:Str_Int(step) forKey:ASLevel(level)];
        [standard synchronize];
    }
}

- (void)jiepingBtn{
    
    UIImage * image = [self captureImageFromView:self.view];
    
    ALAssetsLibrary * library = [ALAssetsLibrary new];
    
    NSData * data = UIImageJPEGRepresentation(image, 1.0);
    
    [library writeImageDataToSavedPhotosAlbum:data metadata:nil completionBlock:nil];
    
}
-(UIImage *)captureImageFromView:(UIView *)view{
    
    UIGraphicsBeginImageContextWithOptions(self.view.frame.size,NO, 0);
    
    [[UIColor clearColor] setFill];
    
    [[UIBezierPath bezierPathWithRect:self.view.bounds] fill];
    
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    [self.view.layer renderInContext:ctx];
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return image;
    
}
@end
