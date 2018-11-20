//
//  WallPaperViewController.m
//  Puzzle
//
//  Created by The Clouds on 2018/11/19.
//  Copyright © 2018 FellowMe. All rights reserved.
//

#import "WallPaperViewController.h"
#import "RequestManager.h"
#import "WallPaperModel.h"
#import <MJRefresh.h>
#import "WallPaperCell.h"
#import <UIImageView+WebCache.h>
#import "WallpaperDetailViewController.h"

@interface WallPaperViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (nonatomic, strong) NSMutableArray *classGroup;

@end

@implementation WallPaperViewController
#pragma mark - LazyLoad
- (NSMutableArray *)classGroup{
    if (!_classGroup) {
        _classGroup = [NSMutableArray array];
    }
    return _classGroup;
}
#pragma mark - Super
- (void)viewDidLoad {
    [super viewDidLoad];
    [self creatCollectionView];
    [self loadData];
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
//    [_collectionView registerClass:[WallPaperCell class] forCellWithReuseIdentifier:@"WallPaperCell"];
}
#pragma mark - PublicMethod
#pragma mark - Events
#pragma mark - Delegate
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.classGroup.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    WallPaperCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"WallPaperCell" forIndexPath:indexPath];
    if (self.classGroup) {
        
        WallPaperModel *model = self.classGroup[indexPath.row];
        cell.titlelb.text = model.name ? model.name : @"";
        [cell.imgV sd_setImageWithURL:[NSURL URLWithString:model.cover]];
    }
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
}

#pragma mark - LoadFromService
- (void)loadData{
//    [MYProgressHUD showHUDWithIndeterminate:@"Loading..."];
    [[RequestManager manager] GET:url_classify parameters:nil success:^(id  _Nullable responseObj) {
        [self endRefreshing];
        if (!responseObj || ![responseObj isKindOfClass:[NSDictionary class]]) return;
        
        if ([responseObj[@"msg"] isEqualToString:@"success"]) {
            
            self.classGroup = [WallPaperModel mj_objectArrayWithKeyValuesArray:responseObj[@"res"][@"category"]];
            
            if (self.classGroup.count) {
                [self.collectionView reloadData];
            }
        }
        
    } failure:^(NSError * _Nonnull error) {
        
        [self endRefreshing];
    }];
    
}
#pragma mark - PrivateMethod
- (void)endRefreshing {
    if ([self.collectionView.mj_header isRefreshing]) {
        [self.collectionView.mj_header endRefreshing];
    }
    if ([self.collectionView.mj_footer isRefreshing]) {
        [self.collectionView.mj_footer endRefreshing];
    }
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
        if ([segue.identifier isEqualToString:@"WallpaperDetailSegue"]) {
            NSIndexPath* indexPath = [self.collectionView indexPathForCell:sender];
            WallpaperDetailViewController *detailVC = (WallpaperDetailViewController *)segue.destinationViewController;
            WallPaperModel *model = self.classGroup[indexPath.row];

//            [detailVC.navigationView  setTitle:model.name];
            detailVC.categoryID = model.Id;
            detailVC.detailTitle = model.name;
        }
}
@end
