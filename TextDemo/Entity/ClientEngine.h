//
//  ClientEngine.h
//  TextDemo
//
//  Created by BaoBaoDaRen on 2019/5/7.
//  Copyright © 2019 BaoBao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ClientEngine : NSObject

// 引擎入口
+ (ClientEngine *)sharedEntity;

- (UIColor *)colorWithHexString:(NSString *)stringToConvert;

/*
 * 是否显示tabbar...
 */
- (void)hidTabBar:(BOOL)showBar;

- (void)doPop:(UIViewController *)viewController hidTabbar:(BOOL)hidBar animated:(BOOL)isAnimated;

- (void)doPush:(UIViewController *)viewController hidTabbar:(BOOL)hidBar animated:(BOOL)isAnimated;


@end

NS_ASSUME_NONNULL_END
