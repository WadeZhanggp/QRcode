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

#define SIZE [UIScreen mainScreen].bounds.size

@interface QRcodeController ()<AVCaptureMetadataOutputObjectsDelegate>
//输入设备 采集摄像头扑捉信息
@property (nonatomic, strong) AVCaptureDeviceInput *inPut;
//输出设备 解析输入设备采集到的信息
@property (nonatomic, strong) AVCaptureMetadataOutput *outPut;
//（特殊图层 能够展示摄像头采集到的画面） 展示输入设备采集到的信息
@property (nonatomic, strong) AVCaptureVideoPreviewLayer *previewLayer;
// 关联输入设备和输出设备：会话
@property (nonatomic, strong) AVCaptureSession *session;

@property (nonatomic, strong) InPutView *inputView;

@end

@implementation QRcodeController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor blackColor];
    [self initCaptureDevice];
    [self initNavgationBar];
    [self initQRAnimationView];
    
}

- (void)initNavgationBar{
    
    UIView *navgationView = [[UIView alloc] initWithFrame:CGRectMake(0, 20, SIZE.width, 44)];
    navgationView.backgroundColor = [UIColor colorWithRed:69/255.0 green:190/255.0 blue:199/255.0 alpha:1];
    [self.view addSubview:navgationView];
    
    UIView *statusBarView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, SIZE.width, 20)];
    
    statusBarView.backgroundColor = [UIColor colorWithRed:69/255.0 green:190/255.0 blue:199/255.0 alpha:1];
    [self.view addSubview:statusBarView];
    [self prefersStatusBarHidden];
    
    UIImageView *backView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"back_arrow"]];
    backView.frame = CGRectMake(8, 6, 28, 28);
    [navgationView addSubview:backView];
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake((SIZE.width - 100)/2, 6, 100, 28)];
    titleLabel.text = @"扫码";
    titleLabel.font = [UIFont systemFontOfSize:20];
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    [navgationView addSubview:titleLabel];
    
    UIButton *inPutButton = [[UIButton alloc] initWithFrame:CGRectMake(SIZE.width - 8 - 60, 6, 60, 28)];
    inPutButton.backgroundColor = [UIColor clearColor];
    inPutButton.titleLabel.font = [UIFont systemFontOfSize:15];
    [inPutButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [inPutButton setTitle:@"手动输入" forState:UIControlStateNormal];
    [inPutButton addTarget:self action:@selector(inPutAction) forControlEvents:UIControlEventTouchUpInside];
    [navgationView addSubview:inPutButton];
    
    self.inputView = [[InPutView alloc] initWithFrame:CGRectMake(8, 6, SIZE.width - 16, 28)];
    [self.inputView setHidden:YES];
    [navgationView addSubview:self.inputView];
}

- (void)initQRAnimationView{
    
    QRAnimationView *animationView = [[QRAnimationView alloc] initWithFrame:CGRectMake(0, 0, 200, 300)];
    animationView.center = self.view.center;
    [self.view addSubview:animationView];
    
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
    //停止扫描
    [self.session stopRunning];
    //移除layer
    [self.previewLayer removeFromSuperlayer];
    [self.inputView.inputTextField resignFirstResponder];
    //[self.navigationController popViewControllerAnimated:YES];
    
}

#pragma mark ----buttonAction
- (void)inPutAction{
    [self.inputView setHidden:NO];
}

#pragma mark ----hidenKeyBoard
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    [self.inputView.inputTextField resignFirstResponder];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
