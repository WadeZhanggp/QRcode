//
//  SubAlertVIew.m
//  QRcode
//
//  Created by 张光鹏 on 16/7/8.
//  Copyright © 2016年 WadeZhang. All rights reserved.
//

#import "SubAlertVIew.h"
#import "PrefixHeader.pch"

static const CGFloat kSubAlertViewWidth = 540/2;
static const CGFloat kSubAlertViewHeight = 285/2;
static const CGFloat kGrayViewWidth = 540/2;
static const CGFloat kGrayViewHeight = 88/2;
#define GRAYVIEW_COLOR [UIColor colorWithRed:245.0/255.0 green:245.0/255.0 blue:245.0/255.0 alpha:1]

@interface SubAlertVIew ()

@property (nonatomic, strong) UIView *blackView;
@property (nonatomic, strong) UIView *subAlertView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *messageLabel;
@property (nonatomic, strong) UIButton *cancelButton;
@property (nonatomic, strong) UIButton *sureButton;
@property (nonatomic, strong) UIView *buttonView;

@end

@implementation SubAlertVIew

- (id)initWithFrame:(CGRect)frame subAlertViewType:(SubAlertViewType)subAlertViewType{
    
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.blackView = [[UIView alloc] initWithFrame:frame];
        self.blackView.alpha = 0.0;
        [self addSubview:self.blackView];
        
        self.subAlertView = [[UIView alloc] initWithFrame:CGRectMake((frame.size.width - kSubAlertViewWidth) / 2, (frame.size.height - kSubAlertViewHeight)/2, kSubAlertViewWidth, kSubAlertViewHeight)];
        self.subAlertView.backgroundColor = [UIColor colorWithRed:244/255.0 green:244/255.0 blue:244/255.0 alpha:0.9];
        self.subAlertView.layer.masksToBounds = YES;
        //self.subAlertView.alpha = 1;
        [self addSubview:self.subAlertView];
        
        self.buttonView = [[UIView alloc] initWithFrame:CGRectMake(0, kSubAlertViewHeight - kGrayViewHeight, kGrayViewWidth, kGrayViewHeight)];
        //self.buttonView.backgroundColor = GRAYVIEW_COLOR;
        [self.subAlertView addSubview:self.buttonView];
        
        self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 15, kSubAlertViewWidth - 30, (kSubAlertViewHeight - kGrayViewHeight)/2 - 15)];
        //self.titleLabel.backgroundColor = [UIColor greenColor];
        self.titleLabel.numberOfLines = 0;
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        self.titleLabel.textColor = TEXTCOLOR;
        [self.subAlertView addSubview:self.titleLabel];
        
        self.messageLabel = [[UILabel alloc] initWithFrame:CGRectMake(15,(kSubAlertViewHeight - kGrayViewHeight)/2 , kSubAlertViewWidth - 30, (kSubAlertViewHeight - kGrayViewHeight)/2 - 15)];
        //self.messageLabel.backgroundColor = [UIColor redColor];
        self.messageLabel.numberOfLines = 0;
        self.messageLabel.textAlignment = NSTextAlignmentCenter;
        self.messageLabel.textColor = TEXTCOLOR;
        self.messageLabel.font = [UIFont systemFontOfSize:16];
        [self.subAlertView addSubview:self.messageLabel];
        
        self.cancelButton = [[UIButton alloc] init];
        self.cancelButton.backgroundColor = [UIColor clearColor];
        [self.cancelButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        self.cancelButton.titleLabel.font = [UIFont systemFontOfSize:16];
        [self.cancelButton addTarget:self action:@selector(clickToCancel) forControlEvents:UIControlEventTouchUpInside];
        [self.buttonView addSubview:self.cancelButton];
        
        self.sureButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.sureButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        self.sureButton.titleLabel.font = [UIFont systemFontOfSize:16];
        [self.sureButton addTarget:self action:@selector(clickToSure) forControlEvents:UIControlEventTouchUpInside];
        [self.buttonView addSubview:self.sureButton];
        
        if (subAlertViewType == SubAlertViewTypeOnlyButton) {
            
            self.sureButton.frame = CGRectMake(0, 0, kGrayViewWidth, kGrayViewHeight);
            
        }else{
            self.cancelButton.frame = CGRectMake(0, 0, kGrayViewWidth/2, kGrayViewHeight);
            [self.cancelButton setTitle:@"取消" forState:UIControlStateNormal];
            self.sureButton.frame = CGRectMake(kGrayViewWidth/2, 0, kGrayViewWidth/2, kGrayViewHeight);
            [self.sureButton setTitle:@"确认" forState:UIControlStateNormal];
        }

    }
    
    return self;
}

- (void)showInSuperView:(UIView *)view{
    [UIView animateWithDuration:0.5 delay:0.0 options:7 << 16 animations:^{
        self.blackView.alpha = 0.4;
        self.subAlertView.alpha = 1;
        self.alpha = 1;
        [view addSubview:self];
    } completion:^(BOOL finished) {
        
    }];
}

- (NSString *)content{
    if (self.messageLabel.text.length == 0) {
        return nil;
    }
    return self.messageLabel.text;
}

- (void)setContent:(NSString *)content{
    
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:content];
    [str addAttribute:NSForegroundColorAttributeName value:CERTAINCOLOR range:NSMakeRange(11,1)];
    self.messageLabel.attributedText = str;
    self.messageLabel.bounds = CGRectMake(0, 0, kSubAlertViewWidth - 30, 60);
    //NSDictionary *attributes = @{NSFontAttributeName:[UIFont systemFontOfSize:17],};
//    CGSize textSize = [content boundingRectWithSize:self.messageLabel.bounds.size
//                                            options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
//                                         attributes:attributes
//                                            context:nil].size;
    //self.messageLabel.frame = CGRectMake(15, (kSubAlertViewHeight - kGrayViewHeight - textSize.height)/2 , kSubAlertViewWidth - 30, textSize.height);
    self.messageLabel.frame = CGRectMake(15,(kSubAlertViewHeight - kGrayViewHeight)/2 , kSubAlertViewWidth - 30, (kSubAlertViewHeight - kGrayViewHeight)/2 - 15);
}

- (NSString *)title{
    if (self.titleLabel.text.length == 0) {
        return nil;
    }
    return self.titleLabel.text;
}

- (void)setTitle:(NSString *)title{
    
    self.titleLabel.text = title;
    
}

- (void)setSureButtonTitle:(NSString *)title{
    
    self.cancelButton.alpha = 0;
    [self.sureButton setTitle:title forState:UIControlStateNormal];
    self.sureButton.titleLabel.font = [UIFont systemFontOfSize:18];
    [self.sureButton setTitleColor:CERTAINCOLOR forState:UIControlStateNormal];
    
}

- (void)clickToCancel{
    [UIView animateWithDuration:0.5 delay:0.0 options:7 << 16 animations:^{
        self.blackView.alpha = 0;
        self.subAlertView.alpha = 0;
        self.alpha = 0;
    } completion:^(BOOL finished) {
            }];
    if (self.delegate && [self.delegate respondsToSelector:@selector(remove)]) {
        [self.delegate remove];
    }
}

- (void)clickToSure{
    [UIView animateWithDuration:0.5 delay:0.0 options:7 << 16 animations:^{
        self.blackView.alpha = 0;
        self.subAlertView.alpha = 0;
        self.alpha = 0;
    } completion:^(BOOL finished) {
    }];
    if (self.delegate && [self.delegate respondsToSelector:@selector(clickToConfirm)]) {
        [self.delegate clickToConfirm];
    }
    
}

@end
