//
//  ShowToastBaseView.h
//  qnche
//
//  Created by pengkang on 2018/1/16.
//  Copyright © 2018年 pengkang. All rights reserved.
//

//弹窗类的继承此类

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    PKShowAnimationStyle_Detafult,
    PKShowAnimationStyle_fromBottom,
    PKShowAnimationStyle_fromTop,
    PKShowAnimationStyle_fromLeft,
    PKShowAnimationStyle_fromRight,
} PKShowAnimationStyle;

typedef enum : NSUInteger {
    PKHideAnimationStyle_Detafult,
    PKHideAnimationStyle_toBottom,
    PKHideAnimationStyle_toTop,
    PKHideAnimationStyle_toLeft,
    PKHideAnimationStyle_toRight,
} PKHideAnimationStyle;

typedef NS_OPTIONS(NSUInteger, PKAutoLayoutStyle) {
    PKAutoLayoutPosition_center = 1 << 0,
    PKAutoLayoutPosition_top = 1 << 1,
    PKAutoLayoutPosition_left = 1 << 2,
    PKAutoLayoutPosition_bottom = 1 << 3,
    PKAutoLayoutPosition_right = 1 << 4,
};

typedef enum : NSUInteger {
    PKPanGestureRecognizerDirection_top = 1,
    PKPanGestureRecognizerDirection_left = 2 ,
    PKPanGestureRecognizerDirection_bottom = 3 ,
    PKPanGestureRecognizerDirection_right = 4,
} PKPanGestureRecognizerDirection;


@interface PKShowPopView : UIView

-(void)showOnView:(UIView *)view;

-(void)hideContentView;

@property(nonatomic,copy) void(^showCompletionBlock)(void);

@property(nonatomic,copy) void(^hideCompletionBlock)(void);

//contentView
@property(nonatomic,strong) UIView *contentView;

//animation group for contentview
@property(nonatomic,strong) NSArray *animationArr;

//duration default is 0.35
@property(nonatomic,assign) float duration;

//default is PKShowAnimationStyle_Detafult
@property(nonatomic,assign) PKShowAnimationStyle showAnimationStyle;

//default is PKHideAnimationStyle_Detafult
@property(nonatomic,assign) PKHideAnimationStyle hideAnimationStyle;

//default is YES
@property(nonatomic,assign) BOOL userTouchActionEnable;

//default is YES
@property(nonatomic,assign) BOOL addShowAnimation;

//default is YES
@property(nonatomic,assign) BOOL addHideAnimation;

//default is NO
@property(nonatomic,assign) BOOL useAutoLayout;

//default is AutoLayoutPositon_center
@property(nonatomic,assign) PKAutoLayoutStyle layoutPositon;

//default is [UIColor whiteColor];
@property(nonatomic,strong) UIColor *backColor;
//default is 0.75;
@property(nonatomic,assign) CGFloat backAlpha;

//default is zero;
@property(nonatomic,assign) UIEdgeInsets  contentViewInsets;

//popview's Insets in superview. default is zero;
@property(nonatomic,assign) UIEdgeInsets  popViewInsets;

//enable user pan to hide contentview.default is NO. works only when allowUserPanContentView is YES
@property(nonatomic,assign) BOOL  enablePanContentViewToHide;

//PKPanGestureRecognizerDirection
@property(nonatomic,assign) PKPanGestureRecognizerDirection  panDirection;

// pan to hide min distance percent. less than this,content view will back to origin place,otherwise content will hide. default is 0.1;
@property(nonatomic,assign) CGFloat panToHideMinPerecent;

@end
