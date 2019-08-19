//
//  ClientEngine.m
//  TextDemo
//
//  Created by BaoBaoDaRen on 2019/5/7.
//  Copyright © 2019 BaoBao. All rights reserved.
//

#import "ClientEngine.h"

@implementation ClientEngine

static ClientEngine *sManager = nil;
+ (ClientEngine *)sharedEntity
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sManager = [[ClientEngine alloc] init];
    });
    return sManager;
}

- (void)doPush:(UIViewController *)viewController hidTabbar:(BOOL)hidBar animated:(BOOL)isAnimated
{
    [UIApplication sharedApplication].delegate.window.rootViewController.tabBarController.tabBar.hidden = hidBar;
    [[UIApplication sharedApplication].delegate.window.rootViewController.navigationController pushViewController:viewController animated:isAnimated];
}
- (void)doPop:(UIViewController *)viewController hidTabbar:(BOOL)hidBar animated:(BOOL)isAnimated
{
    [UIApplication sharedApplication].delegate.window.rootViewController.tabBarController.tabBar.hidden = hidBar;
    [viewController.navigationController popViewControllerAnimated:isAnimated];
}
- (void)hidTabBar:(BOOL)showBar
{
    [UIApplication sharedApplication].delegate.window.rootViewController.tabBarController.tabBar.hidden = showBar;
}

- (UIColor *)colorWithHexString:(NSString *)stringToConvert
{
    UIColor *DEFAULT_VOID_COLOR = [UIColor whiteColor];
    NSString *cString = [[stringToConvert stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    
    if ([cString length] < 6)
    {
        return DEFAULT_VOID_COLOR;
    }
    if ([cString hasPrefix:@"#"])
    {
        cString = [cString substringFromIndex:1];
    }
    if ([cString length] != 6)
    {
        return DEFAULT_VOID_COLOR;
    }
    NSRange range;
    range.location = 0;
    range.length = 2;
    NSString *rString = [cString substringWithRange:range];
    
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    
    
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    
    return [UIColor colorWithRed:((float) r / 255.0f)
                           green:((float) g / 255.0f)
                            blue:((float) b / 255.0f)
                           alpha:1.0f];
}

@end
