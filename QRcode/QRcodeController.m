//
//  QRcodeController.m
//  QRcode
//
//  Created by 张光鹏 on 16/6/25.
//  Copyright © 2016年 WadeZhang. All rights reserved.
//

#import "QRcodeController.h"
#import <AVFoundation/AVFoundation.h>
#import "InPutView.h"
#import "QRAnimationView.h"
#import "Masonry.h"
#import "RDNavgationAndStateBar.h"
#import "PrefixHeader.pch"
#import "SubAlertVIew.h"

@interface QRcodeController ()<AVCaptureMetadataOutputObjectsDelegate,InputViewDelegate,SubAlertViewDelegate>
//输入设备 采集摄像头扑捉信息
@property (nonatomic, strong) AVCaptureDeviceInput *inPut;
//输出设备 解析输入设备采集到的信息
@property (nonatomic, strong) AVCaptureMetadataOutput *outPut;
//（特殊图层 能够展示摄像头采集到的画面） 展示输入设备采集到的信息
@property (nonatomic, strong) AVCaptureVideoPreviewLayer *previewLayer;
// 关联输入设备和输出设备：会话
@property (nonatomic, strong) AVCaptureSession *session;

@property (nonatomic, strong) RDNavgationAndStateBar *navgationAndStateBar;

@property (nonatomic, strong) UIButton *inPutButton;

@property (nonatomic, strong) InPutView *inputView;

@property (nonatomic, strong) QRAnimationView *animationView;

@property (nonatomic, strong) SubAlertVIew *subAlertView;

@end

@implementation QRcodeController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    //self.view.backgroundColor = [UIColor blackColor];
    
    [self initCaptureDevice];
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:self.view.bounds];
    imageView.image = [UIImage imageNamed:@"saoma_bg"];
    [self.view addSubview:imageView];
    
    [self initNavgationBar];
    [self initQRAnimationView];

}

- (void)initNavgationBar{
    
    self.navgationAndStateBar = [[RDNavgationAndStateBar alloc] initWithFrame:CGRectMakePlus(0, 0, 414, 67)];
    [self.navgationAndStateBar setNavgationBarTitle:@"新增上网卡"];
    //self.navgationAndStateBar.backgroundColor = [UIColor redColor];
    [self.view addSubview:self.navgationAndStateBar];
    
    self.inPutButton = [[UIButton alloc] initWithFrame:CGRectMakePlus(308, 26, 100, 32)];
    self.inPutButton.backgroundColor = [UIColor clearColor];
    self.inPutButton.titleLabel.font = [UIFont systemFontOfSize:15];
    [self.inPutButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.inPutButton.titleLabel.adjustsFontSizeToFitWidth = YES;
    [self.inPutButton setTitle:@"手动输入" forState:UIControlStateNormal];
    [self.inPutButton addTarget:self action:@selector(inPutAction) forControlEvents:UIControlEventTouchUpInside];
    //self.inPutButton.backgroundColor = [UIColor redColor];
    [self.navgationAndStateBar addSubview:self.inPutButton];
    
    self.inputView = [[InPutView alloc] initWithFrame:CGRectMakePlus(8, 26, 398, 32)];
    self.inputView.delegate = self;
    [self.inputView setHidden:YES];
    [self.navgationAndStateBar addSubview:self.inputView];
}

- (void)initQRAnimationView{
    
    self.animationView = [[QRAnimationView alloc] initWithFrame:CGRectMakePlus(64.4, 185.53, 285.2, 285.2)];
    //self.animationView.backgroundColor = [UIColor grayColor];
    [self.animationView setTipsWithTitle:@"请将条形码放入框内区域，即可自动扫描"];
    [self.view addSubview:self.animationView];
    
}

- (void)initCaptureDevice{
    
    // Do any additional setup after loading the view.
    //1.创建输入设备
    //AVCaptureDevice 设备 :  摄像头(video) 麦克风(audio)
    //AVCaptureDeviceInput 输入设备 default 默认后置
    //AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    NSArray *allDevice = [AVCaptureDevice devicesWithMediaType:AVMediaTypeVideo];
    self.inPut = [AVCaptureDeviceInput deviceInputWithDevice:[allDevice firstObject] error:nil];
    
    //2.创建输出设备
    self.outPut = [[AVCaptureMetadataOutput alloc] init];
    
    //解析-》返回数据
    [self.outPut setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
    
    //3.创建会话
    self.session = [[AVCaptureSession alloc] init];
    
    //4.关联会话
    if ([self.session canAddInput:self.inPut]) {
        [self.session addInput:self.inPut];
    }
    if ([self.session canAddOutput:self.outPut]) {
        [self.session addOutput:self.outPut];
    }
    
    //高数数据类型 条形码类型
    self.outPut.metadataObjectTypes = @[AVMetadataObjectTypeQRCode,AVMetadataObjectTypeEAN13Code, AVMetadataObjectTypeEAN8Code, AVMetadataObjectTypeCode128Code];
    
    //扫描框大小
    //[self.session setSessionPreset:AVCaptureSessionPreset640x480];
    
    //5.指定layer的frame然后添加到view上
    self.previewLayer = [[AVCaptureVideoPreviewLayer alloc] initWithSession:self.session];
    self.previewLayer.frame = self.view.bounds;
    //self.previewLayer.backgroundColor = [UIColor redColor];
    //self.view.backgroundColor = [UIColor redColor];
    [self.view.layer addSublayer:self.previewLayer];
    //开启会话
    [self.session startRunning];
    
}

#pragma mark ----captureDelegate
- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection{
    
    AVMetadataMachineReadableCodeObject *objc = [metadataObjects firstObject];
    NSString *str = objc.stringValue;
    
    NSLog(@"%@",str);
    
    if (!self.subAlertView) {
        self.subAlertView = [[SubAlertVIew alloc] initWithFrame:[UIScreen mainScreen].bounds subAlertViewType:SubAlertViewTypeOnlyButton];
        self.subAlertView.delegate = self;
    }
    self.subAlertView.content = @"请发放该用户全球上网卡1张";
    self.subAlertView.title = @"有效领取码!";
    [self.subAlertView setSureButtonTitle:@"请发卡"];
    [self.subAlertView showInSuperView:self.view];
    
    [self.animationView stopAnimation];
    
    //停止扫描
    [self.session stopRunning];
    [self.inputView.inputTextField resignFirstResponder];
}

#pragma mark ----buttonAction
- (void)inPutAction{
    [self.inputView setHidden:NO];
    [self.inPutButton setHidden:YES];
    [self.inputView.inputTextField becomeFirstResponder];
}

#pragma mark ----hidenKeyBoard
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    [self.inputView.inputTextField resignFirstResponder];
}

#pragma mark ----InputViewDelegate
- (void)inputCertainAction{
    
    [self.inPutButton setHidden:NO];
    
}

#pragma mark ----SubAlertViewDelegate
- (void)clickToConfirm{
    [self.previewLayer removeFromSuperlayer];
}

@end
