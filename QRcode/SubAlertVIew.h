//
//  SubAlertVIew.h
//  QRcode
//
//  Created by 张光鹏 on 16/7/8.
//  Copyright © 2016年 WadeZhang. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, SubAlertViewType){
    
    SubAlertViewTypeOnlyButton,
    SubAlertViewTypeButton
    
};

@protocol SubAlertViewDelegate <NSObject>

@optional;
- (void)remove;

@optional;

- (void)clickToConfirm;

@end

@interface SubAlertVIew : UIView

@property (nonatomic, strong) NSString *content;

@property (nonatomic, strong) NSString *title;

- (id)initWithFrame:(CGRect)frame subAlertViewType:(SubAlertViewType)subAlertViewType;

@property (nonatomic, strong) id<SubAlertViewDelegate> delegate;

- (void)showInSuperView:(UIView *)view;

- (void)setSureButtonTitle:(NSString *)title;

@end
