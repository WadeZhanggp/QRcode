//
//  InPutView.m
//  QRcode
//
//  Created by 张光鹏 on 16/7/6.
//  Copyright © 2016年 WadeZhang. All rights reserved.
//

#import "InPutView.h"
#import "PrefixHeader.pch"

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
    
    self.backgroundColor = [UIColor clearColor];
    
    self.inputTextField = [[UITextField alloc] initWithFrame:CGRectMakePlus(0, 0, 320, 32)];
    self.inputTextField.layer.cornerRadius = 5;
    self.inputTextField.backgroundColor = [UIColor whiteColor];
    self.inputTextField.keyboardType = UIKeyboardTypeNumberPad;
    self.inputTextField.placeholder = @"请手动输入您的条形码数字编码";
    self.inputTextField.adjustsFontSizeToFitWidth = YES;
    self.inputTextField.textColor = [UIColor grayColor];
    self.inputTextField.clearButtonMode = UITextFieldViewModeAlways;
    [self addSubview:self.inputTextField];
    
    UIButton *certainButton = [[UIButton alloc] initWithFrame:CGRectMakePlus(330, 0, 68, 32)];
    certainButton.backgroundColor = [UIColor colorWithRed:0/255.0 green:216/255.0 blue:167/255.0 alpha:1];
    certainButton.layer.cornerRadius = 5;
    [certainButton setTitle:@"确认" forState:UIControlStateNormal];
    [certainButton addTarget:self action:@selector(certainAction) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:certainButton];
    
}

- (void)certainAction{
    
    [self setHidden:YES];
    [self.inputTextField resignFirstResponder];
    if (self.delegate && [self.delegate respondsToSelector:@selector(inputCertainAction)]) {
        [self.delegate inputCertainAction];
    }
    
}

@end
