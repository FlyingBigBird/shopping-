//
//  ZCRecordPage.h
//  TextDemo
//
//  Created by BaoBaoDaRen on 2019/5/24.
//  Copyright © 2019 BaoBao. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZCRecordPage : UIView

typedef void (^RecordCompleteBlock)(NSString *videoPath);
@property (nonatomic, copy) RecordCompleteBlock complete;

- (void)releaseEngine;

- (instancetype)initWithFrame:(CGRect)frame recordComplete:(RecordCompleteBlock)complete; 

@end

NS_ASSUME_NONNULL_END
