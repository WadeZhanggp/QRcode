//
//  RDNavgationAndStateBar.m
//  QRcode
//
//  Created by 张光鹏 on 16/7/7.
//  Copyright © 2016年 WadeZhang. All rights reserved.
//

#import "RDNavgationAndStateBar.h"
#import "Masonry.h"
#import "PrefixHeader.pch"

@interface RDNavgationAndStateBar ()

@property (nonatomic, strong) UIView *navgationView;

@property (nonatomic, strong) UIView *statusBarView;

@property (nonatomic, strong) UIImageView *backView;

@property (nonatomic, strong) UILabel *titleLabel;

@end

@implementation RDNavgationAndStateBar

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
    NSLog(@"height = %f",SIZE.height/736 * 67);
    self.navgationView = [[UIView alloc] initWithFrame:self.frame];
    self.navgationView.backgroundColor = NAVGATIONCOLOR;
    [self addSubview:self.navgationView];
    
    self.backView = [[UIImageView alloc] initWithFrame:CGRectMakePlus(8, 26, 32, 32)];
    //self.backView.backgroundColor = [UIColor redColor];
    self.backView.image = [UIImage imageNamed:@"back_arrow"];
    [self.navgationView addSubview:self.backView];
    
    self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMakePlus(100, 26, 214, 32)];
    //self.titleLabel.backgroundColor = [UIColor redColor];
    self.titleLabel.font = [UIFont systemFontOfSize:21];
    self.titleLabel.adjustsFontSizeToFitWidth = YES;
    self.titleLabel.textColor = [UIColor whiteColor];
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    [self.navgationView addSubview:self.titleLabel];
    
}

- (void)setNavgationBarTitle:(NSString *)title{
    
    self.titleLabel.text = title;
    
}

@end
