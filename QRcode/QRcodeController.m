//
//  QRcodeController.m
//  QRcode
//
//  Created by 张光鹏 on 16/6/25.
//  Copyright © 2016年 WadeZhang. All rights reserved.
//

#import "QRcodeController.h"
#import <AVFoundation/AVFoundation.h>

@interface QRcodeController ()<AVCaptureMetadataOutputObjectsDelegate>
//输入设备 采集摄像头扑捉信息
@property (nonatomic, strong) AVCaptureDeviceInput *inPut;
//输出设备 解析输入设备采集到的信息
@property (nonatomic, strong) AVCaptureMetadataOutput *outPut;
//（特殊图层 能够展示摄像头采集到的画面） 展示输入设备采集到的信息
@property (nonatomic, strong) AVCaptureVideoPreviewLayer *previewLayer;
// 关联输入设备和输出设备：会话
@property (nonatomic, strong) AVCaptureSession *session;

@end

@implementation QRcodeController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor blackColor];
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
    
    //高数数据类型 二维码类型
    self.outPut.metadataObjectTypes = @[AVMetadataObjectTypeQRCode];
    
    //扫描框大小
    [self.session setSessionPreset:AVCaptureSessionPreset640x480];
    
    
    //5.指定layer的frame然后添加到view上
    self.previewLayer = [[AVCaptureVideoPreviewLayer alloc] initWithSession:self.session];
    self.previewLayer.frame = self.view.bounds;
    
    [self.view.layer addSublayer:self.previewLayer];
    
    //开启会话
    [self.session startRunning];
}

- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection{
    
    AVMetadataMachineReadableCodeObject *objc = [metadataObjects firstObject];
    NSString *str = objc.stringValue;
    NSLog(@"%@",str);
    //停止扫描
    [self.session stopRunning];
    //移除layer
    [self.previewLayer removeFromSuperlayer];
    [self.navigationController popViewControllerAnimated:YES];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
