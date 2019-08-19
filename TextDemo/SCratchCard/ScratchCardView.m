//
//  ScratchCardView.m
//  TextDemo
//
//  Created by BaoBaoDaRen on 2019/5/23.
//  Copyright © 2019 BaoBao. All rights reserved.
//

#import "ScratchCardView.h"

@interface ScratchCardView () <UIGestureRecognizerDelegate>

@end

@implementation ScratchCardView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
//        line.jpg
        [self setScratchCardViewSubs];
    }
    return self;
}
- (void)setScratchCardViewSubs
{
    UIImageView *picV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 400, 300)];
    picV.image = [UIImage imageNamed:@"line.jpg"];
    [self addSubview:picV];
    
    UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 400, 300)];
    [self addSubview:lab];
    lab.text = @"发小一只小可爱";
    lab.font = [UIFont systemFontOfSize:14];
    lab.textAlignment = NSTextAlignmentCenter;
    lab.textColor = [UIColor blackColor];
    self.scratchContentView = lab;
    
    // 遮罩视图
    self.scratchMaskView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 400, 300)];
    [self addSubview:self.scratchMaskView];
    self.scratchMaskView.backgroundColor = [UIColor lightGrayColor];
    
    self.maskLayer = [[CAShapeLayer alloc] init];
    self.maskLayer.strokeColor = [UIColor redColor].CGColor;
    self.strokeLineWidth = 25;
    self.maskLayer.lineWidth = self.strokeLineWidth;
    self.strokeLineCap = kCALineCapRound;
    self.scratchContentView.layer.mask = self.maskLayer;
    
    
    
}
- (void)showContentView
{
    self.scratchContentView.layer.mask = nil;
}
- (void)resetState
{
    [self.maskPath removeAllPoints];
    self.maskLayer.path = nil;
    self.scratchContentView.layer.mask = self.maskLayer;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    CGPoint beginP = [[touches anyObject] locationInView:self.scratchContentView];
    [self.maskPath moveToPoint:beginP];
}
- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    CGPoint moveP = [[touches anyObject] locationInView:self.scratchContentView];
    [self.maskPath addLineToPoint:moveP];
    [self.maskPath moveToPoint:moveP];
    self.maskLayer.path = self.maskPath.CGPath;
    
    [self updateScratchScopePercent];
}
- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    
}
- (void)updateScratchScopePercent
{
    UIImage *img = [self getImageFromContentView];
    CGFloat percent = 0.2;//1 - [self getAlphaPixelPercent:img];
    percent = MAX(0, MIN(1, percent));
    
    [self.delegate scratchView:self didScratchedPercent:percent];
}
//获取透明像素占总像素的百分比
- (CGFloat)getAlphaPixelPercent:(UIImage *)img
{
    CGFloat width = img.size.width;
    CGFloat height = img.size.height;
    CGFloat capacity = width * height;
    
    // 得到像素数据
    NSData *pixelData = UIImagePNGRepresentation(img);
    // 创建颜色空间
    
    CGColorSpaceRef spaceRef = CGColorSpaceCreateDeviceRGB();
    int bitsPerCompent  = 8;
    int bytesPerRow = 4 * 8 * bitsPerCompent * width;
    // 上下文
    CGContextRef context = CGBitmapContextCreate(NULL, width, height, bitsPerCompent, bytesPerRow, spaceRef, kCGImageAlphaPremultipliedLast|kCGBitmapByteOrderDefault);
    // 绘制背景
    CGContextFillRect(context, CGRectMake(0, 0, width, height));
    CGContextSetRGBFillColor(context, 0.5, 0.22, 0.33, 1);
    CGContextSetRGBStrokeColor(context, 0, 1, 0, 1);
    CGContextFillRect(context, CGRectMake(0, 0, 300, 300));
    CGContextStrokeRect(context, CGRectMake(0, 0, width, height));

    CGFloat alphaPixelCount = 0;

    for (int x = 0; x < width; x++) {
        
        for (int y = 0; y < height; y++) {
            
            if ((pixelData.length - (y * width + x)) == 0) {
                
                alphaPixelCount += 1;
            }
        }
    }
    free((__bridge void *)(pixelData));
    return alphaPixelCount / capacity;
    
}
- (UIImage *)getImageFromContentView
{
    CGSize size = self.scratchContentView.bounds.size;
    UIGraphicsBeginImageContextWithOptions(size, false, [UIScreen mainScreen].scale);
    [self.scratchContentView.layer renderInContext:(CGContextRef)UIGraphicsGetCurrentContext];
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return img;
}


@end
