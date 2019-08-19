//
//  ScratchCardView.h
//  TextDemo
//
//  Created by BaoBaoDaRen on 2019/5/23.
//  Copyright © 2019 BaoBao. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol ScratchCardViewDelegate <NSObject>

- (void)scratchView:(UIView *)scratchView didScratchedPercent:(CGFloat)percent;

@end

@interface ScratchCardView : UIView

@property (nonatomic, strong) UILabel *scratchContentView;

@property (nonatomic, strong) UIView *scratchMaskView;
@property (nonatomic, strong) NSString *strokeLineCap;

@property (nonatomic, strong) CAShapeLayer *maskLayer;
@property (nonatomic, strong) UIBezierPath *maskPath;

@property (nonatomic, assign) CGFloat strokeLineWidth;

@property (nonatomic, weak) id <ScratchCardViewDelegate> delegate;


@end

NS_ASSUME_NONNULL_END
