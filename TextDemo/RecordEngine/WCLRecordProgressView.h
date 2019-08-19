//
//  WCLRecordProgressView.h
//  Youqun
//
//  Created by 王崇磊 on 16/5/19.
//  Copyright © 2016年 W_C__L. All rights reserved.
//

#import <UIKit/UIKit.h>

IB_DESIGNABLE

@interface WCLRecordProgressView : UIView

@property (assign, nonatomic) CGFloat progress;//当前进度
@property (strong, nonatomic) UIColor *progressBgColor;//进度条背景颜色
@property (strong, nonatomic) UIColor *progressColor;//进度条颜色
@property (assign, nonatomic) CGFloat loadProgress;//加载好的进度
@property (strong, nonatomic) UIColor *loadProgressColor;//已经加载好的进度颜色

@end
