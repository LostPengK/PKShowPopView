//
//  ShowToastBaseView.m
//  qnche
//
//  Created by pengkang on 2018/1/16.
//  Copyright © 2018年 pengkang. All rights reserved.
//

#import "PKShowPopView.h"

@interface PKShowPopView()<CAAnimationDelegate>

@property(nonatomic,strong) UIView *coverView;

@property(nonatomic,assign) CGRect contentOriginFrame;


@end

@implementation PKShowPopView

-(instancetype)init{
    self = [super init];
    if (self) {
        [self _setSubview];
    }
    return self;
}

-(void)_setSubview{
    self.userTouchActionEnable = YES;
    self.addHideAnimation = YES;
    self.addShowAnimation = YES;
    self.showAnimationStyle = PKShowAnimationStyle_Detafult;
    self.hideAnimationStyle = PKHideAnimationStyle_Detafult;
    self.layoutPositon = PKAutoLayoutPosition_center;
    self.contentViewInsets = UIEdgeInsetsMake(0, 0, 0, 0);
    
    [self addSubview:self.coverView];
}

-(void)setBackColor:(UIColor *)backColor{
    _backColor = backColor;
    self.coverView.backgroundColor = backColor;
}


-(void)showOnView:(UIView *)view{
    if (!self.contentView) {
        return;
    }
    
    [view addSubview:self];
    
    self.frame = view.bounds;
    self.coverView.frame = view.bounds;
    
    self.coverView.alpha = 0.0;
    [self.layer removeAllAnimations];
    
    [self addSubview:self.contentView];
    
    if(self.useAutoLayout){
        self.contentView.translatesAutoresizingMaskIntoConstraints = NO;
        [self addAutoLayoutContentView];
    }
    
    [self setNeedsLayout];
    [self layoutIfNeeded];
    
    self.contentOriginFrame = self.contentView.frame;
    
    if (self.addShowAnimation) {
        [self showAnimation];
    }
    
    [UIView animateWithDuration:0.35 animations:^{
        self.coverView.alpha =  0.75;
    } completion:^(BOOL finished) {
        if (self.showCompletionBlock) {
            self.showCompletionBlock();
        }
    }];
}


-(void)hideContentView{
    self.userInteractionEnabled = NO;
    if (self.addHideAnimation) {
        switch (self.hideAnimationStyle) {
            case PKHideAnimationStyle_Detafult:{
                [self.contentView.layer addAnimation:[self defaultHideAnimation] forKey:@"scale-layer-hide"];
            }
                break;
            case PKHideAnimationStyle_toBottom:{
                [self HideToBottom];
            }
                break;
            case PKHideAnimationStyle_toTop:{
                [self hideToTop];
            }
                break;
            case PKHideAnimationStyle_toLeft:{
                [self hideToLeft];
            }
                break;
            case PKHideAnimationStyle_toRight:{
                [self hideToRight];
            }
                break;
            default:
                break;
        }
    }else{
        [self hide];
    }
}

-(void)hide{
    if (self.hideCompletionBlock) {
        self.hideCompletionBlock();
    }
    
    [self removeFromSuperview];
    
}

#pragma mark addAutoLayoutContentView
-(void)addAutoLayoutContentView{
    
    if (self.layoutPositon == PKAutoLayoutPosition_center){
        NSLayoutConstraint *consX = [NSLayoutConstraint constraintWithItem:_contentView  attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0];
        NSLayoutConstraint *conY = [NSLayoutConstraint constraintWithItem:_contentView attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0];
        NSLayoutConstraint *consLeft = [NSLayoutConstraint constraintWithItem:_contentView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationGreaterThanOrEqual toItem:self attribute:NSLayoutAttributeLeft multiplier:1.0 constant:self.contentViewInsets.left];
        NSLayoutConstraint *consRight = [NSLayoutConstraint constraintWithItem:_contentView attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationLessThanOrEqual toItem:self attribute:NSLayoutAttributeRight multiplier:1.0 constant:-self.contentViewInsets.right];
        NSLayoutConstraint *consTop = [NSLayoutConstraint constraintWithItem:_contentView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationGreaterThanOrEqual toItem:self attribute:NSLayoutAttributeTop multiplier:1.0 constant:self.contentViewInsets.top];
        NSLayoutConstraint *consBottom = [NSLayoutConstraint constraintWithItem:_contentView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationLessThanOrEqual toItem:self attribute:NSLayoutAttributeBottom multiplier:1.0 constant:-self.contentViewInsets.bottom];
        consBottom.priority = UILayoutPriorityDefaultLow;
        [self addConstraints:@[consLeft,consRight,consTop,consBottom]];
        [self addConstraints:@[consX,conY]];
    }
    
    if (self.layoutPositon & PKAutoLayoutPosition_top) {
        NSLayoutConstraint *consTop = [NSLayoutConstraint constraintWithItem:_contentView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationGreaterThanOrEqual toItem:self attribute:NSLayoutAttributeTop multiplier:1.0 constant:self.contentViewInsets.top];
        [self addConstraint:consTop];
        
    }
    
    if (self.layoutPositon & PKAutoLayoutPosition_left) {
        NSLayoutConstraint *consLeft = [NSLayoutConstraint constraintWithItem:_contentView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationGreaterThanOrEqual toItem:self attribute:NSLayoutAttributeLeft multiplier:1.0 constant:self.contentViewInsets.left];
        [self addConstraint:consLeft];
    }
    
    if (self.layoutPositon & PKAutoLayoutPosition_bottom) {
        NSLayoutConstraint *consBottom = [NSLayoutConstraint constraintWithItem:_contentView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationLessThanOrEqual toItem:self attribute:NSLayoutAttributeBottom multiplier:1.0 constant:-self.contentViewInsets.bottom];
        [self addConstraint:consBottom];
    }
    
    if (self.layoutPositon & PKAutoLayoutPosition_right) {
        NSLayoutConstraint *consRight = [NSLayoutConstraint constraintWithItem:_contentView attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationLessThanOrEqual toItem:self attribute:NSLayoutAttributeRight multiplier:1.0 constant:-self.contentViewInsets.right];
        [self addConstraint:consRight];
    }
    
    if (((self.layoutPositon & PKAutoLayoutPosition_top) && (self.layoutPositon & PKAutoLayoutPosition_center)) || ((self.layoutPositon & PKAutoLayoutPosition_bottom) && (self.layoutPositon & PKAutoLayoutPosition_center))) {
        NSLayoutConstraint *consX = [NSLayoutConstraint constraintWithItem:_contentView  attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0];
        [self addConstraint:consX];
    }
    
    if (((self.layoutPositon & PKAutoLayoutPosition_left) && (self.layoutPositon & PKAutoLayoutPosition_center)) || ((self.layoutPositon & PKAutoLayoutPosition_right) && (self.layoutPositon & PKAutoLayoutPosition_center))) {
        NSLayoutConstraint *consY = [NSLayoutConstraint constraintWithItem:_contentView  attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0];
        [self addConstraint:consY];
    }
    
}


-(void)showAnimation{
    switch (self.showAnimationStyle) {
        case PKShowAnimationStyle_Detafult:{
            [self.contentView.layer addAnimation:[self defaultShowAnimation] forKey:@"scale-layer"];
        }
            break;
        case PKShowAnimationStyle_fromBottom:{
            [self showFromBottom];
        }
            break;
        case PKShowAnimationStyle_fromTop:{
            [self showFromTop];
        }
            break;
        case PKShowAnimationStyle_fromLeft:{
            [self showFromLeft];
        }
            break;
        case PKShowAnimationStyle_fromRight:{
            [self showFromRight];
        }
            break;
        default:
            break;
    }
}

-(CAAnimation *)defaultShowAnimation{
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    animation.duration = 0.25; // 动画持续时间
    animation.repeatCount = 1; // 重复次数
    animation.fromValue = [NSNumber numberWithFloat:0.001];
    animation.toValue = [NSNumber numberWithFloat:1.0];
    animation.fillMode = kCAFillModeForwards;
    animation.removedOnCompletion = NO;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    [animation setValue:@"show" forKey:@"AnimationKey"];
    return animation;
}


-(void)showFromLeft{
    CGRect frame = self.contentView.frame;
    CGRect frame1 = self.contentView.frame;
    frame.origin.x = -frame.size.width;
    self.contentView.frame = frame;
    
    [UIView animateWithDuration:0.35 animations:^{
        self.contentView.frame = frame1;
    } completion:^(BOOL finished) {
        
    }];
}

-(void)hideToLeft{
    CGRect frame = self.contentView.frame;
    frame.origin.x = -frame.size.width;
    
    [UIView animateWithDuration:0.35 animations:^{
        self.contentView.frame = frame;
    } completion:^(BOOL finished) {
        [self hide];
    }];
}

-(void)showFromRight{
    CGRect frame = self.contentView.frame;
    CGRect frame1 = self.contentView.frame;
    frame.origin.x = self.frame.size.width;
    self.contentView.frame = frame;
    
    [UIView animateWithDuration:0.35 animations:^{
        self.contentView.frame = frame1;
    } completion:^(BOOL finished) {
        
    }];
}

-(void)hideToRight{
    CGRect frame = self.contentView.frame;
    frame.origin.x = self.frame.size.width;
    
    [UIView animateWithDuration:0.35 animations:^{
        self.contentView.frame = frame;
    } completion:^(BOOL finished) {
        [self hide];
    }];
}

-(void)showFromTop{
    
    CGRect frame = self.contentView.frame;
    CGRect frame1 = self.contentView.frame;
    frame.origin.y = -frame.size.height;
    self.contentView.frame = frame;
    
    [UIView animateWithDuration:0.35 animations:^{
        self.contentView.frame = frame1;
    } completion:^(BOOL finished) {
        
    }];
}

-(void)hideToTop{
    
    CGRect frame = self.contentView.frame;
    frame.origin.y = -frame.size.height;
    
    [UIView animateWithDuration:0.35 animations:^{
        self.contentView.frame = frame;
    } completion:^(BOOL finished) {
        [self hide];
    }];
}

-(void)showFromBottom{
    
    CGRect frame = self.contentOriginFrame;
    CGRect frame1 = self.contentOriginFrame;
    
    frame.origin.y = self.frame.size.height;
    self.contentView.frame = frame;
    
    [UIView animateWithDuration:0.35 animations:^{
        self.contentView.frame = frame1;
    } completion:^(BOOL finished) {
        
    }];
}

-(void)HideToBottom{
    CGRect frame = self.contentView.frame;
    frame.origin.y = self.frame.size.height;
    
    [UIView animateWithDuration:0.35 animations:^{
        self.contentView.frame = frame;
        self.coverView.alpha =  0.0;
    } completion:^(BOOL finished) {
        [self hide];
    }];
}

-(CAAnimation *)defaultHideAnimation{
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    animation.duration = 0.25; // 动画持续时间
    animation.repeatCount = 1; // 重复次数
    animation.fromValue = [NSNumber numberWithFloat:1.0];
    animation.toValue = [NSNumber numberWithFloat:0.01];
    animation.removedOnCompletion = NO;
    animation.fillMode = kCAFillModeForwards;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    animation.delegate = self;
    [animation setValue:@"hide" forKey:@"AnimationKey"];
    return animation;
}

#pragma mark CAAnimationDelegate
-(void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag{
    if ([[anim valueForKey:@"AnimationKey"]isEqualToString:@"hide"]) {
        [self hide];
    }
}

-(void)animationDidStart:(CAAnimation *)anim{
    
}


#pragma mark action
-(void)tapCoverView{
    if (self.userTouchActionEnable) {
        [self hideContentView];
    }
}

#pragma mark getter

-(UIView *)coverView{
    if (!_coverView) {
        _coverView = [[UIView alloc]init];
        _coverView.backgroundColor = [UIColor whiteColor];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapCoverView)];
        [_coverView addGestureRecognizer:tap];
    }
    return _coverView;
}


@end
