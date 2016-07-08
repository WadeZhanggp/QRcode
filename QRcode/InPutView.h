//
//  InPutView.h
//  QRcode
//
//  Created by 张光鹏 on 16/7/6.
//  Copyright © 2016年 WadeZhang. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol InputViewDelegate <NSObject>

@optional

- (void)inputCertainAction;

@end

@interface InPutView : UIView

@property (nonatomic, strong) UITextField *inputTextField;

@property (nonatomic, weak) id<InputViewDelegate>delegate;

@end
