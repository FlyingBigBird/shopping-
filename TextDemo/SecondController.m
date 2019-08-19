//
//  SecondController.m
//  TextDemo
//
//  Created by BaoBaoDaRen on 2019/5/6.
//  Copyright © 2019 BaoBao. All rights reserved.
//

#import "SecondController.h"

@interface SecondController () <CAAnimationDelegate>

@end

@implementation SecondController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.btnWH = 50;
    self.orginRect = CGRectMake(SCREEN_WIDTH - 15 - self.btnWH, SCREEN_HEIGHT / 2 - self.btnWH / 2, self.btnWH, self.btnWH);
    self.controlBtn = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - 15 - self.btnWH, SCREEN_HEIGHT / 2 - self.btnWH / 2, self.btnWH, self.btnWH)];
    [self.view addSubview:self.controlBtn];
    self.controlBtn.backgroundColor = [UIColor lightGrayColor];
    self.controlBtn.layer.masksToBounds = YES;
    self.controlBtn.layer.cornerRadius = self.btnWH / 2;
    
    self.topBtn = [[UIButton alloc] initWithFrame:self.orginRect];
    [self.view addSubview:self.topBtn];
    [self cornerWithButton:self.topBtn withHiden:YES];
    
    self.centerLetfBtn = [[UIButton alloc] initWithFrame:self.orginRect];
    [self.view addSubview:self.centerLetfBtn];
    [self cornerWithButton:self.centerLetfBtn withHiden:YES];

    self.centerRightBtn = [[UIButton alloc] initWithFrame:self.orginRect];
    [self.view addSubview:self.centerRightBtn];
    [self cornerWithButton:self.centerRightBtn withHiden:YES];

    [self.controlBtn addTarget:self action:@selector(extendBegin) forControlEvents:UIControlEventTouchUpInside];

    
}
- (void)extendBegin
{
    if (self.isExtrense == YES) {
        
        // 收起
        [self doPackUp];
    } else {
        
        // 展开
        [self doOpen];
    }
    self.isExtrense = !self.isExtrense;
}
- (void)doPackUp
{
    [UIView transitionWithView:self.topBtn duration:1 options:UIViewAnimationOptionTransitionCrossDissolve animations:^{
        
        [self beginRotateEnded:self.topBtn];
    } completion:^(BOOL finished) {
        
        [UIView transitionWithView:self.topBtn duration:1 options:UIViewAnimationOptionTransitionCrossDissolve animations:^{
            
            self.topBtn.frame = self.orginRect;
            [self beginRotate:self.topBtn withAngle:-45];

        } completion:^(BOOL finished) {
            
            self.topBtn.hidden = YES;
        }];
    }];
}
- (void)doOpen
{
    [UIView transitionWithView:self.topBtn duration:1 options:UIViewAnimationOptionTransitionCrossDissolve animations:^{
        
        self.topBtn.hidden = NO;
        self.topBtn.frame = CGRectMake(SCREEN_WIDTH / 2 - self.btnWH / 2, SCREEN_HEIGHT / 2 - self.btnWH, self.btnWH, self.btnWH);
        [self beginRotate:self.topBtn withAngle:45];

    } completion:^(BOOL finished) {
        
        [UIView transitionWithView:self.topBtn duration:1 options:UIViewAnimationOptionTransitionCrossDissolve animations:^{
        
            [self beginRotateEnded:self.topBtn];

        } completion:^(BOOL finished) {
            
        }];
    }];
   
    [UIView transitionWithView:self.centerLetfBtn duration:1 options:UIViewAnimationOptionTransitionCrossDissolve animations:^{
        
        
    } completion:^(BOOL finished) {
        
    }];
    [UIView transitionWithView:self.centerRightBtn duration:1 options:UIViewAnimationOptionTransitionCrossDissolve animations:^{
        
        
    } completion:^(BOOL finished) {
        
    }];
}
- (void)changedFrame
{
    self.topBtn.frame = CGRectMake(SCREEN_WIDTH / 2 - self.btnWH / 2, SCREEN_HEIGHT / 2 - self.btnWH, self.btnWH, self.btnWH);
    self.centerLetfBtn.frame = CGRectMake(SCREEN_WIDTH / 2 - self.btnWH, SCREEN_HEIGHT / 2, self.btnWH, self.btnWH);
    self.centerRightBtn.frame = CGRectMake(SCREEN_WIDTH / 2, SCREEN_HEIGHT / 2, self.btnWH, self.btnWH);
}
- (void)beginRotate:(UIButton *)sender withAngle:(CGFloat)angleDegree
{
//    [UIView beginAnimations:nil context:nil];
//    [UIView setAnimationDuration:1];
//    sender.transform = CGAffineTransformRotate(sender.transform, (180) * (180.0 / M_PI));
//    [UIView commitAnimations];
    
    CGFloat perAngle = M_PI/180.0;
    CGFloat turnNum = 1;
    
    CABasicAnimation* rotationAnimation;
    rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotationAnimation.toValue = [NSNumber numberWithFloat:angleDegree * perAngle + 360 * perAngle * turnNum];
    rotationAnimation.duration = 1;
    rotationAnimation.cumulative = YES;
    rotationAnimation.delegate = self;
    
    //由快变慢
    rotationAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    rotationAnimation.fillMode=kCAFillModeForwards;
    rotationAnimation.removedOnCompletion = NO;
    [sender.layer addAnimation:rotationAnimation forKey:@"rotationAnimation"];
    
}
- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
//    [self beginRotateEnded:self.topBtn];
}

- (void)beginRotateEnded:(UIButton *)sender
{
//    [UIView beginAnimations:nil context:nil];
//    [UIView setAnimationDuration:1];
//    sender.transform = CGAffineTransformRotate(sender.transform, M_PI_4);
//    [UIView commitAnimations];
    CGFloat perAngle = M_PI/180.0;
    
    CABasicAnimation* rotationAnimation;
    rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotationAnimation.toValue = [NSNumber numberWithFloat:-1 * perAngle];
    rotationAnimation.duration = 1;
    rotationAnimation.cumulative = YES;
    rotationAnimation.delegate = self;
    
    //由快变慢
    rotationAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    rotationAnimation.fillMode=kCAFillModeForwards;
    rotationAnimation.removedOnCompletion = NO;
    [sender.layer addAnimation:rotationAnimation forKey:@"rotationAnimation"];
    
}
//- (CGFloat)getRadianDegreeFromTransform:(CGAffineTransform)transform
//{
//    CGFloat rotate = acosf(transform.a);
//    // 旋转180度后，需要处理弧度的变化
//    if (transform.b < 0)
//    {
//        rotate = M_PI*2 - rotate;
//    }
//    return rotate;
//}



- (void)cornerWithButton:(UIButton *)sender withHiden:(BOOL)isHid
{
    sender.layer.masksToBounds = YES;
    sender.layer.cornerRadius = self.btnWH / 2;
    sender.hidden = isHid;
    [sender setImage:[UIImage imageNamed:@"pdf"] forState:UIControlStateNormal];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
