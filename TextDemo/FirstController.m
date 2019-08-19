//
//  FirstController.m
//  TextDemo
//
//  Created by BaoBaoDaRen on 2019/5/21.
//  Copyright © 2019 BaoBao. All rights reserved.
//

#import "FirstController.h"
#import "ZCCardView.h"
#import "ScratchCardView.h"
#import "ZCRecordPage.h"
#import "TextDemo-Swift.h"

@interface FirstController () <UICollectionViewDataSource,UICollectionViewDelegate>

@property (nonatomic, strong) ZCRecordPage *recordV;
@property (nonatomic, strong) UICollectionView *collectV;
@end

@implementation FirstController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];

//    self.navigationController.navigationBar.hidden = NO;
//    [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationFade];
//    self.tabBarController.tabBar.hidden = NO;
//    self.view.backgroundColor = [UIColor whiteColor];
    
}
//隐藏状态栏
- (BOOL)prefersStatusBarHidden
{
    return NO;
}
- (void)viewWillDisappear:(BOOL)animated
{
//    self.tabBarController.tabBar.hidden = NO;
//
//    [self.recordV releaseEngine];
}
- (void)viewDidLoad {
    [super viewDidLoad];

//    [self doRecords];
    
    if ([self respondsToSelector:@selector(setEdgesForExtendedLayout:)])
    {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    self.navigationController.navigationBar.hidden = NO;
    self.automaticallyAdjustsScrollViewInsets = NO;
    if (@available(iOS 11.0, *)) {
        self.collectV.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        // Fallback on earlier versions
    }


    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];

    layout.minimumLineSpacing = 0;
    layout.minimumInteritemSpacing = 0;
    layout.itemSize = CGSizeMake(SCREEN_WIDTH, SCREEN_HEIGHT - NavBar_H - StatusBar_H - TabBar_H);
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    layout.headerReferenceSize = CGSizeMake(0, 0);
    layout.footerReferenceSize = CGSizeMake(0, 0);
    layout.sectionInset = UIEdgeInsetsZero;
    
    self.collectV = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - NavBar_H - StatusBar_H - TabBar_H) collectionViewLayout:layout];
    [self.view addSubview:self.collectV];
    self.collectV.dataSource = self;
    self.collectV.delegate = self;
    self.collectV.showsHorizontalScrollIndicator = NO;
    self.collectV.pagingEnabled = YES;
    self.collectV.backgroundColor = [UIColor whiteColor];
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 5;
}
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *const colString = @"horizonCellId";
    [self.collectV registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:colString];
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:colString forIndexPath:indexPath];
    if (cell == nil) {
        
        cell = [[UICollectionViewCell alloc] init];
    }
    if (indexPath.row == 0) {
        
        PageOne *page = [[PageOne alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - NavBar_H - StatusBar_H - TabBar_H)];
        [cell.contentView addSubview:page];
        
    }
    
    
    if (indexPath.row % 2 == 0) {
        
        cell.contentView.backgroundColor = [UIColor redColor];
    } else {
        cell.contentView.backgroundColor = [UIColor blueColor];
    }
    
    
    return cell;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    if ([kind isKindOfClass:[UICollectionElementKindSectionHeader class]]) {
        
        UICollectionReusableView *view = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"Header" forIndexPath:indexPath];
        view.frame = CGRectZero;
        return view;
    } else {
        
        UICollectionReusableView *view = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"footer" forIndexPath:indexPath];
        view.frame = CGRectZero;
        return view;

    }
}

- (BOOL)collectionView:(UICollectionView *)collectionView canMoveItemAtIndexPath:(NSIndexPath *)indexPath NS_AVAILABLE_IOS(9_0)
{
    return YES;
}
- (void)collectionView:(UICollectionView *)collectionView moveItemAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath*)destinationIndexPath NS_AVAILABLE_IOS(9_0)
{
    
}

/// Returns a list of index titles to display in the index view (e.g. ["A", "B", "C" ... "Z", "#"])
- (nullable NSArray<NSString *> *)indexTitlesForCollectionView:(UICollectionView *)collectionView API_AVAILABLE(tvos(10.2))
{
    return @[@"A",@"B",@"C",@"D",@"E",@"F",@"G",@"H",@"I",@"J",@"K"];
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
}




//- (void)doRecords
//{
//    [[UIApplication sharedApplication] setStatusBarHidden:YES];
//
//    self.recordV = [[ZCRecordPage alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) recordComplete:^(NSString * _Nonnull videoPath) {
//
//        TabController *tabVC = [[TabController alloc] init];
//        [self.navigationController pushViewController:tabVC animated:YES];
//    }];
//    [self.view addSubview:self.recordV];
//}


@end
