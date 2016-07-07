//
//  QRAnimationView.m
//  QRcode
//
//  Created by 张光鹏 on 16/7/6.
//  Copyright © 2016年 WadeZhang. All rights reserved.
//

#import "QRAnimationView.h"

@implementation QRAnimationView

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
    
    UIView *borderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 200, 200)];
    borderView.layer.borderWidth = 20;
    borderView.layer.borderColor = (__bridge CGColorRef _Nullable)([UIColor greenColor]);
    borderView.layer.cornerRadius = 5;
    borderView.backgroundColor = [UIColor redColor];
    [self addSubview:borderView];
    
    
    UILabel *line = [[UILabel alloc] initWithFrame: CGRectMake(0, 0, 200, 2)];
    line.backgroundColor = [UIColor greenColor];
    [self addSubview:line ];
    
    /* 添加动画 */
    
    [UIView animateWithDuration:2.5 delay:0.0 options:UIViewAnimationOptionRepeat animations:^{
        
        line.frame = CGRectMake(0, 200, 200, 2);
        
    } completion:nil];
    
}

@end
