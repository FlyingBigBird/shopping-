//
//  SecondController.h
//  TextDemo
//
//  Created by BaoBaoDaRen on 2019/5/6.
//  Copyright © 2019 BaoBao. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SecondController : UIViewController

@property (nonatomic, strong) UIButton *controlBtn;

@property (nonatomic, strong) UIButton *topBtn;
@property (nonatomic, strong) UIButton *centerLetfBtn;
@property (nonatomic, strong) UIButton *centerRightBtn;

@property (nonatomic, assign) CGRect orginRect;

@property (nonatomic, assign) BOOL isExtrense;
@property (nonatomic, assign) CGFloat btnWH;

@property (nonatomic, assign) BOOL bloom;
@property (nonatomic, assign) CGFloat bloomRadius;


@end

NS_ASSUME_NONNULL_END
