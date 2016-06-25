//
//  ViewController.m
//  QRcode
//
//  Created by 张光鹏 on 16/6/25.
//  Copyright © 2016年 WadeZhang. All rights reserved.
//

#import "ViewController.h"
#import "QRcodeController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(100, 100, [UIScreen mainScreen].bounds.size.width - 200, 50)];
    button.layer.cornerRadius = 5;
    button.backgroundColor = [UIColor grayColor];
    [button setTitle:@"扫码" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(clickQRcode) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
}

- (void)clickQRcode{
    
    QRcodeController *codeController = [[QRcodeController alloc] init];
    [self.navigationController pushViewController:codeController animated:YES];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
