//
//  ASMianViewController.m
//  Puzzle
//
//  Created by The Clouds on 2018/11/8.
//  Copyright © 2018 FellowMe. All rights reserved.
//

#import "ASMianViewController.h"
#import "ASDetailViewController.h"
#import "LEImagePickerTool.h"
#import "ASuzzleTool.h"

@interface ASMianViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *picImgV;
@property (weak, nonatomic) IBOutlet UIButton *selImgBtn;
@property (weak, nonatomic) IBOutlet UIButton *startBtn;
@property (nonatomic, strong) UIImage *originalImg;
@end

@implementation ASMianViewController

#pragma mark - LazyLoad
#pragma mark - Super
- (void)viewDidLoad {
    [super viewDidLoad];
    _picImgV.layer.borderColor = [UIColor whiteColor].CGColor;
    _picImgV.layer.borderWidth = 6;
    _picImgV.layer.masksToBounds = YES;
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    if ([ASuzzleTool getBackImage] == nil) {
        [ASuzzleTool AS_saveBackImage:[self loadImage:[UIImage imageNamed:@"pic"]]];
    }
    _picImgV.image = [ASuzzleTool getBackImage];

}
#pragma mark - Init
#pragma mark - PublicMethod
- (UIImage*)loadImage:(UIImage*)aImage{
    
    CGRect rect = CGRectMake(0, 0, kScreenWidth - 20 , kScreenWidth - 20);//创建矩形框
    UIGraphicsBeginImageContext(rect.size);//根据size大小创建一个基于位图的图形上下文
    CGContextRef currentContext = UIGraphicsGetCurrentContext();//获取当前quartz 2d绘图环境
    CGContextClipToRect(currentContext, rect);//设置当前绘图环境到矩形框
    [aImage drawInRect:rect];
    UIImage *cropped = UIGraphicsGetImageFromCurrentImageContext();//获得图片
    UIGraphicsEndImageContext();//从当前堆栈中删除quartz 2d绘图环境
    return cropped;
}
#pragma mark - Events
- (IBAction)startBtn:(id)sender {
    ASDetailViewController *detailVC = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"ASDetailViewController"];
    CGPoint touchPoint = CGPointMake(kScreenWidth/2, kScreenHeight/2);
    [self hh_presentCircleVC:detailVC point:touchPoint completion:nil];
}
- (IBAction)selectLocationImg:(id)sender {
    WeakSelf
    [LEImagePickerTool selectImageWithController:self edit:YES completion:^(UIImage *image) {
        wself.originalImg = [wself loadImage:image];
        [wself.picImgV setImage:image];
        [ASuzzleTool AS_saveBackImage:[wself loadImage:image]];
    }];
}

#pragma mark - Delegate
#pragma mark - LoadFromService
#pragma mark - PrivateMethod

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
