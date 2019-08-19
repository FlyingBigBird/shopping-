//
//  AppDelegate.m
//  TextDemo
//
//  Created by BaoBaoDaRen on 2019/1/4.
//  Copyright © 2019年 BaoBao. All rights reserved.
//

#import "AppDelegate.h"
#import "FirstController.h"
#import "ViewController.h"
#import "TabViewController.h"
#import "SecondController.h"
#import "ThirdController.h"

@interface AppDelegate ()

@property (nonatomic, strong) TabViewController * rootVC;

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
//    self.rootVC = [[TabViewController alloc] init];
//    self.rootVC.title = @"";
//    self.window.rootViewController = self.rootVC;
    
    
    ViewController *oneVC = [[ViewController alloc] init];
    oneVC.title = @"首页";
    UINavigationController *oneNVC = [[UINavigationController alloc] initWithRootViewController:oneVC];
    self.window.rootViewController = oneNVC;

    /*
    FirstController *oneVC = [[FirstController alloc] init];
    oneVC.title = @"首页";
    UINavigationController *oneNVC = [[UINavigationController alloc] initWithRootViewController:oneVC];

    SecondController *twoVC = [[SecondController alloc] init];
    twoVC.title = @"热门";
    UINavigationController *twoNVC = [[UINavigationController alloc] initWithRootViewController:twoVC];

    ThirdController *ThirdVC = [[ThirdController alloc] init];
    ThirdVC.title = @"推荐";
    UINavigationController *ThirdNVC = [[UINavigationController alloc] initWithRootViewController:ThirdVC];
    
    oneNVC.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"首页" image:[UIImage imageNamed:@"shouye-2"] selectedImage:[UIImage imageNamed:@"shouye"]];
    twoNVC.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"热门" image:[UIImage imageNamed:@"remen-2"] selectedImage:[UIImage imageNamed:@"remen"]];
    ThirdNVC.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"推荐" image:[UIImage imageNamed:@"tuijianliebiao-2"] selectedImage:[UIImage imageNamed:@"tuijianliebiao"]];
   
    self.rootVC.tabBar.tintColor = [self colorWithHexString:@"#d81e06"];
    if (@available(iOS 10.0, *)) {
        self.rootVC.tabBar.unselectedItemTintColor = [self colorWithHexString:@"#ea986c"];
    } else {
        // Fallback on earlier versions
    }
    [self.rootVC.tabBar setBarTintColor:[UIColor whiteColor]];
    // 把数据中得视图器交给分栏控制器管理
    // 分栏控制器会自动将其管理的视图控制器的分栏按钮(UITabBarItem)放到分栏上显示
    self.rootVC.viewControllers = @[oneNVC, twoNVC, ThirdNVC];
    */
    
    return YES;
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

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
