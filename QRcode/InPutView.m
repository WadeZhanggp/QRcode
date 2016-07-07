//
//  InPutView.m
//  QRcode
//
//  Created by 张光鹏 on 16/7/6.
//  Copyright © 2016年 WadeZhang. All rights reserved.
//

#import "InPutView.h"

#define SIZE [UIScreen mainScreen].bounds.size

@implementation InPutView

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self createUI];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self createUI];
    }
    return self;
}

- (void)createUI{
    
    self.backgroundColor = [UIColor colorWithRed:69/255.0 green:190/255.0 blue:199/255.0 alpha:1];
    
    self.inputTextField = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width - 20 - 50, 28)];
    self.inputTextField.layer.cornerRadius = 5;
    self.inputTextField.backgroundColor = [UIColor whiteColor];
    self.inputTextField.keyboardType = UIKeyboardTypeNumberPad;
    self.inputTextField.placeholder = @"请手动输入您的条形码数字编码";
    self.inputTextField.textColor = [UIColor grayColor];
    [self addSubview:self.inputTextField];
    
    UIButton *certainButton = [[UIButton alloc] initWithFrame:CGRectMake(self.frame.size.width - 50, 0, 50, 28)];
    certainButton.backgroundColor = [UIColor greenColor];
    certainButton.layer.cornerRadius = 5;
    [certainButton setTitle:@"确认" forState:UIControlStateNormal];
    [certainButton addTarget:self action:@selector(certainAction) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:certainButton];
    
}

- (void)certainAction{
    
    [self setHidden:YES];
    [self.inputTextField resignFirstResponder];
    
}

@end
