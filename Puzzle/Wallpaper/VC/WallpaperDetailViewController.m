//
//  WallpaperDetailViewController.m
//  Puzzle
//
//  Created by The Clouds on 2018/11/19.
//  Copyright © 2018 FellowMe. All rights reserved.
//

#import "WallpaperDetailViewController.h"
#import "RequestManager.h"
#import "WallpaperDetailCell.h"

@interface WallpaperDetailViewController ()<UICollectionViewDataSource,UICollectionViewDelegate>
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (nonatomic, strong) NSMutableArray *dataSource;
@end

@implementation WallpaperDetailViewController

#pragma mark - LazyLoad
- (NSMutableArray *)dataSource{
    if (!_dataSource) {
        _dataSource = [NSMutableArray array];
    }
    return _dataSource;
}
#pragma mark - Super
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationView setTitle:self.detailTitle];
    self.collectionView.contentInset = UIEdgeInsetsMake(STATE_HEIGHT, 0, 0, 0);
    WeakSelf
//    [self.navigationView addLeftButtonWithImage:[UIImage imageNamed:@"back"] clickCallBack:^(UIView *view) {
//        [wself.navigationController popViewControllerAnimated:YES];
//    }];

    [self creatCollectionView];
    [self loadingDetail];
}

#pragma mark - Init
- (void)creatCollectionView{
    UICollectionViewFlowLayout * layout = [[UICollectionViewFlowLayout alloc]init];
    CGFloat space  = 8;
    CGFloat W = (self.view.frame.size.width - 4 * space) / 3 - 2;
    layout.itemSize = CGSizeMake(W, W + 10);
    layout.sectionInset = UIEdgeInsetsMake(space, space, space, space);
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    [_collectionView setCollectionViewLayout:layout animated:YES];
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
}
#pragma mark - PublicMethod
#pragma mark - Events
#pragma mark - Delegate
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dataSource.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    WallpaperDetailCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"WallpaperDetailCell" forIndexPath:indexPath];
    if (self.dataSource.count) {
        cell.model = self.dataSource[indexPath.row];
    }
    return cell;
}

#pragma mark - <UICollectionViewDelegate>
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    if (self.dataSource.count > indexPath.row) {
//        SDPhotoBrowser *photoBrowser = [SDPhotoBrowser new];
//        photoBrowser.delegate = self;
//        photoBrowser.currentImageIndex = indexPath.item;
//        photoBrowser.imageCount = self.browserImages.count;
//        photoBrowser.sourceImagesContainerView = self.collectionView;
//        [photoBrowser show];
    }
}
#pragma mark - LoadFromService
#pragma mark - PrivateMethod


- (void)loadingDetail{
    NSDictionary *params = @{@"order": @"new",
                             @"adult": @"false"};
    
    NSString *urlStr = [NSString stringWithFormat:@"http://service.picasso.adesk.com/v1/wallpaper/category/%@/wallpaper", self.categoryID];
    
    [[RequestManager manager] GET:urlStr parameters:params success:^(id  _Nullable responseObj) {
        if (!responseObj || ![responseObj isKindOfClass:[NSDictionary class]]) return;
        
        if ([responseObj[@"msg"] isEqualToString:@"success"]) {
            [self.dataSource removeAllObjects];
            
            NSArray *newObjects = [WallPaperModel mj_objectArrayWithKeyValuesArray:responseObj[@"res"][@"wallpaper"]];
            [self.dataSource addObjectsFromArray:newObjects];
            [self.collectionView reloadData];
        }
        
    } failure:^(NSError * _Nonnull error) {
        
    }];
}




@end
