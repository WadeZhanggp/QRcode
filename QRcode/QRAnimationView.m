//
//  QRAnimationView.m
//  QRcode
//
//  Created by 张光鹏 on 16/7/6.
//  Copyright © 2016年 WadeZhang. All rights reserved.
//

#import "QRAnimationView.h"
#import <QuartzCore/QuartzCore.h>
#import "PrefixHeader.pch"



@interface QRAnimationView ()

@property (nonatomic, strong) UILabel * tipsLabel;

@property (nonatomic, strong) UIImageView *line;

@end

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
    
    self.line = [[UIImageView alloc] initWithFrame: CGRectMakePlus(-25, 0, 335.2, 2)];
    self.line.image = [UIImage imageNamed:@"saoma_bar"];
    [self addSubview:self.line ];
    
    /* 添加动画 */
    [UIView animateWithDuration:2.5 delay:1 options:UIViewAnimationOptionRepeat animations:^{
        
        self.line.frame = CGRectMakePlus(-25, 285.2, 335.2, 2);
        
    } completion:nil];
    
    self.tipsLabel = [[UILabel alloc] initWithFrame:CGRectMakePlus(10, 290.2, 265.2, 50)];
    self.tipsLabel.textAlignment = NSTextAlignmentCenter;
    self.tipsLabel.backgroundColor = [UIColor clearColor];
    self.tipsLabel.textColor = POINTCOLOR;
    self.tipsLabel.font = [UIFont systemFontOfSize:12];
    self.tipsLabel.adjustsFontSizeToFitWidth = YES;
    [self addSubview:self.tipsLabel];
    
}

- (void)setTipsWithTitle:(NSString *)title{
    
    self.tipsLabel.text = title;
    
}

- (void)stopAnimation{
    
    [self.line removeFromSuperview];
    
}

@end
