//
//  ZCRecordPage.m
//  TextDemo
//
//  Created by BaoBaoDaRen on 2019/5/24.
//  Copyright © 2019 BaoBao. All rights reserved.
//

#import "ZCRecordPage.h"
#import "WCLRecordEngine.h"
#import "WCLRecordProgressView.h"
#import <MobileCoreServices/MobileCoreServices.h>
#import <MediaPlayer/MediaPlayer.h>
#import <AVFoundation/AVFoundation.h>

typedef NS_ENUM(NSUInteger, UploadVieoStyle) {
  
    VideoRecord = 0,
    VideoLocation,
};

@interface ZCRecordPage () <WCLRecordEngineDelegate>

// 视频录制
// 底部遮罩
@property (strong, nonatomic) UIImageView * videoShadeImageView;

// 录制/暂停
@property (strong, nonatomic) UIButton * recordBt;

// 切换摄像头
@property (strong, nonatomic) UIButton *changeCameraBT;

// 下一步
@property (strong, nonatomic) UIButton *previewBtn;

@property (nonatomic, strong) WCLRecordProgressView   *progressView;
@property (strong, nonatomic) WCLRecordEngine         *recordEngine;
@property (assign, nonatomic) BOOL                    allowRecord;//允许录制
@property (assign, nonatomic) UploadVieoStyle         videoStyle;//视频的类型
@property (strong, nonatomic) UIImagePickerController *moviePicker;//视频选择器
@property (strong, nonatomic) MPMoviePlayerViewController *playerVC;

@end

@implementation ZCRecordPage

- (instancetype)initWithFrame:(CGRect)frame recordComplete:(RecordCompleteBlock)complete
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.complete = complete;
        
        [self authorizationPrepared];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(VideoRecordShouldBegin) name:@"VideoRecordBegin" object:nil];

        [self setZCRecordPageSubs:frame];
        
    }
    return self;
}
- (void)authorizationPrepared
{
    // 麦克风
    AVAuthorizationStatus status = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeAudio];
    if (status == AVAuthorizationStatusNotDetermined) {
        
        // 尚未选择权限...
        [[AVAudioSession sharedInstance] requestRecordPermission:^(BOOL granted) {
            // CALL YOUR METHOD HERE - as this assumes being called only once from user interacting with permission alert!
            if (granted) {
                // Microphone enabled code
            }
            else {
                // Microphone disabled code
            }
        }];
    } else if (status == AVAuthorizationStatusAuthorized) {
        
        // 已授权...
        
    } else {
        
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"您尚未允许应用访问您的麦克风，请在系统“设置”的权限管理中，允许访问麦克风" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
            // 跳转到设置页面...
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
        }];
        
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        [alert addAction:cancelAction];
        [alert addAction:okAction];
        [[UIApplication sharedApplication].delegate.window.rootViewController presentViewController:alert animated:YES completion:nil];
    }
    
    AVAuthorizationStatus mediaStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    if (mediaStatus == AVAuthorizationStatusNotDetermined) {
      
        // 捕获设备媒体授权...
        [AVCaptureDevice requestAccessForMediaType:AVMediaTypeVideo completionHandler:^(BOOL granted) {
            
            if (granted) {
                NSLog(@"允许访问");
            }else {
                NSLog(@"拒绝访问");
            }
        }];
    } else if (mediaStatus == AVAuthorizationStatusAuthorized) {
        // 已授权...
    } else {
        
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"您尚未允许应用访问您的相机，请在系统“设置”的权限管理中，允许访问相机" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
            // 跳转到设置页面...
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
        }];
        
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        [alert addAction:cancelAction];
        [alert addAction:okAction];
        [[UIApplication sharedApplication].delegate.window.rootViewController presentViewController:alert animated:YES completion:nil];
    }
}
- (void)setZCRecordPageSubs:(CGRect)supframe
{
    [self recordProgress:0.001];
    [self setRecordParameters];
    
    [self changeCameraAction:self.recordBt];
}
- (void)VideoRecordShouldBegin
{
    [self setRecordParameters];
}
- (void)setRecordParameters
{
    if (_recordEngine == nil)
    {
        [self.recordEngine previewLayer].frame = self.bounds;
        [self.layer insertSublayer:[self.recordEngine previewLayer] atIndex:0];
    }
    [self.recordEngine startUp];
    self.allowRecord = YES;
}
#pragma mark - set、get方法
- (WCLRecordEngine *)recordEngine {
    if (_recordEngine == nil) {
        _recordEngine = [[WCLRecordEngine alloc] init];
        _recordEngine.delegate = self;
    }
    return _recordEngine;
}
- (void)releaseEngine
{
    [self.recordEngine shutdown];
}
- (UIButton *)changeCameraBT
{
    if (!_changeCameraBT) {
        
        // 切换摄像头
        _changeCameraBT = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - 15 - 40, NavBar_H + StatusBar_H + 50, 32, 24)];
        
        [self addSubview:_changeCameraBT];
        [_changeCameraBT setBackgroundImage:[UIImage imageNamed:@"qiehuanshexiangtou1"] forState:UIControlStateNormal];
        [_changeCameraBT addTarget:self action:@selector(changeCameraAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _changeCameraBT;
}
- (WCLRecordProgressView *)progressView
{
    if (!_progressView) {
        
        _progressView = [[WCLRecordProgressView alloc] initWithFrame:CGRectMake(10, NavBar_H + StatusBar_H + 15, SCREEN_WIDTH - 20, 7)];
        [self addSubview:_progressView];
        _progressView.layer.masksToBounds = YES;
        _progressView.layer.cornerRadius = 7 / 2;
        
        _progressView.backgroundColor = [UIColor lightGrayColor];
        _progressView.progressBgColor = [UIColor lightGrayColor];
        _progressView.progressColor = [UIColor redColor];
        _progressView.contentMode = UIViewContentModeScaleToFill;

        if (@available(iOS 9.0, *)) {
            _progressView.semanticContentAttribute = UISemanticContentAttributeUnspecified;
        } else {
            // Fallback on earlier versions
        }
        _progressView.alpha = 1;
    }
    return _progressView;
}
- (UIButton *)recordBt
{
    if (!_recordBt) {
        
        _recordBt = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 65, 65)];
        _recordBt.center = CGPointMake(SCREEN_WIDTH / 2, SCREEN_HEIGHT - 25 - 65);
        [self addSubview:_recordBt];
        [_recordBt setBackgroundImage:[UIImage imageNamed:@"kaishi"] forState:UIControlStateNormal];
        [_recordBt addTarget:self action:@selector(recordAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _recordBt;
}
#pragma mrk - 录制
- (void)recordAction:(UIButton *)sender
{
    self.previewBtn.hidden = NO;
    if (self.allowRecord)
    {
        self.videoStyle = VideoRecord;
        self.recordBt.selected = !self.recordBt.selected;
        if (self.recordBt.selected)
        {
            if (self.recordEngine.isCapturing)
            {
                [self.recordEngine resumeCapture];
                [self recordNextAction:self.previewBtn];
                [self.recordBt setBackgroundImage:[UIImage imageNamed:@"bf"] forState:UIControlStateNormal];
                
            }else
            {
                [self.recordEngine startCapture];
                [self.recordBt setBackgroundImage:[UIImage imageNamed:@"zanting"] forState:UIControlStateNormal];
            }
        }else
        {
            [self.recordEngine pauseCapture];
            [self recordNextAction:self.previewBtn];
            [self.recordBt setBackgroundImage:[UIImage imageNamed:@"bf"] forState:UIControlStateNormal];
        }
        [self adjustViewFrame];
    }
}
- (UIButton *)previewBtn
{
    if (!_previewBtn) {
        
        _previewBtn = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - 25 - 35, SCREEN_HEIGHT - 25 - 35, 35, 35)];
        _previewBtn.center = CGPointMake(SCREEN_WIDTH - 25 - 35, _recordBt.center.y);
        [_previewBtn setBackgroundImage:[UIImage imageNamed:@"wancheng-"] forState:UIControlStateNormal];
        [self addSubview:_previewBtn];
       
        [_previewBtn addTarget:self action:@selector(recordNextAction:) forControlEvents:UIControlEventTouchUpInside];

    }
    return _previewBtn;
}
- (void)adjustViewFrame {

    [UIView transitionWithView:self.changeCameraBT duration:0.3 options:UIViewAnimationOptionTransitionCrossDissolve animations:^{
        
        if (self.recordBt.selected)
        {
            self.changeCameraBT.hidden = YES;
        }else
        {
            self.changeCameraBT.hidden = NO;
        }
    } completion:^(BOOL finished) {
        
    }];
}
#pragma mark - WCLRecordEngineDelegate
- (void)recordProgress:(CGFloat)progress {
   
    if (progress >= 1) {
        [self recordAction:self.recordBt];
        self.allowRecord = NO;
    }
    self.progressView.progress = progress;

}
#pragma mark - 切换摄像头
- (void)changeCameraAction:(UIButton *)sender
{
    self.changeCameraBT.selected = !self.changeCameraBT.selected;
    if (self.changeCameraBT.selected == YES) {
        //前置摄像头
        [self.recordEngine changeCameraInputDeviceisFront:YES];
    }else {
        [self.recordEngine changeCameraInputDeviceisFront:NO];
    }
}
#pragma mark - 预览...
- (void)recordNextAction:(UIButton *)sender
{
    if (_recordEngine.videoPath.length > 0)
    {
        [self.recordEngine stopCaptureHandler:^(UIImage *movieImage) {
            __weak typeof(self) weakSelf = self;
            weakSelf.playerVC = [[MPMoviePlayerViewController alloc] initWithContentURL:[NSURL fileURLWithPath:weakSelf.recordEngine.videoPath]];
            weakSelf.playerVC.moviePlayer.scalingMode = MPMovieScalingModeAspectFit;
            
            [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(playVideoFinished:) name:MPMoviePlayerPlaybackDidFinishNotification object:[weakSelf.playerVC moviePlayer]];
            [[weakSelf.playerVC moviePlayer] prepareToPlay];
            
            [[UIApplication sharedApplication].delegate.window.rootViewController presentMoviePlayerViewControllerAnimated:weakSelf.playerVC];
            
            [[weakSelf.playerVC moviePlayer] play];
        }];
    }else {
        NSLog(@"请先录制视频~");
    }
}
//当点击Done按键或者播放完毕时调用此函数
- (void) playVideoFinished:(NSNotification *)theNotification {
 
    MPMoviePlayerController *player = [theNotification object];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:MPMoviePlayerPlaybackDidFinishNotification object:player];
    [player stop];
    [self.playerVC dismissMoviePlayerViewControllerAnimated];
    
    self.playerVC = nil;
    
    NSLog(@"视频保存地址:%@",self.recordEngine.videoPath);
    [self setRecordParameters];
   
    if (self.complete) {
        self.complete(self.recordEngine.videoPath);
    }
}

@end
