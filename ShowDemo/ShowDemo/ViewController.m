//
//  ViewController.m
//  ShowDemo
//
//  Created by pengkang on 2019/2/26.
//  Copyright © 2019 pengk. All rights reserved.
//

#import "ViewController.h"
#import "PKShowPopView.h"

@interface NView : UIView

@end

@implementation NView

-(CGSize)intrinsicContentSize{
    return CGSizeMake([UIApplication sharedApplication].keyWindow.frame.size.width, [UIApplication sharedApplication].keyWindow.frame.size.height/2.0);
//    return CGSizeMake([UIApplication sharedApplication].keyWindow.frame.size.width/2.0, UIViewNoIntrinsicMetric );
}

@end

@interface ViewController ()

@property(nonatomic)PKShowPopView *popview;
@property(nonatomic)NView *vv;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //gloable config
    //method 1
    [PKShowPopConfig shareInstance].backColor = [UIColor redColor];
    [PKShowPopConfig shareInstance].duration = 0.3;
    
    //method 2
    [[PKShowPopConfig shareInstance] makeConfig:^(PKShowPopConfig *make) {
        make.duration = 0.2;
        make.backColor = [UIColor redColor];
    }];
    
    self.vv = [NView new];
    self.vv.backgroundColor = [UIColor yellowColor];
    self.vv.frame = CGRectMake(0, self.view.frame.size.height - 200, self.view.frame.size.width, 200);
    // Do any additional setup after loading the view, typically from a nib.
}

- (IBAction)showFrameLayout:(id)sender {
    
    [self showLabelAutolayout:NO];
}

- (IBAction)showAutuLayout:(id)sender {
    
    [self showLabelAutolayout:YES];
}

-(void)showLabelAutolayout:(BOOL)autolayout{
    
    UILabel *label = [UILabel new];
    label.numberOfLines = 0;
    label.text = @"春花秋月何时了，\n往事知多少,\n小楼昨夜又东风。\n雕栏玉砌应犹在，\n只是朱颜改。\n问君能有几多愁m，\n恰似一江春水向东流。";
    label.textColor = [UIColor redColor];
    label.backgroundColor = [UIColor blackColor];
    label.preferredMaxLayoutWidth = 300;
    
    self.popview.contentView = self.vv;
    
    if (autolayout) {
        self.popview.useAutoLayout = YES;
        self.popview.layoutPositon = PKAutoLayoutPosition_right|PKAutoLayoutPosition_top|PKAutoLayoutPosition_bottom ;
    }
    
//    self.popview.contentViewInsets = UIEdgeInsetsMake(100, 20, 20, 20);
    self.popview.popViewInsets  = UIEdgeInsetsMake(30, 0, 0, 0);
    [self.popview showOnView:[UIApplication sharedApplication].keyWindow];
    self.popview.showCompletionBlock = ^{
        
    };
    
    self.popview.hideCompletionBlock = ^{
    };
}

-(PKShowPopView *)popview{
    if (!_popview ) {
        PKShowPopView *pp = [[PKShowPopView alloc]init];
//        pp.useAutoLayout = YES;
//        pp.backColor = [UIColor blackColor];
        pp.showAnimationStyle = PKShowAnimationStyle_fromLeft;// arc4random_uniform(100)%5;;
        pp.hideAnimationStyle = PKHideAnimationStyle_toRight;//arc4random_uniform(100)%5;
//        pp.backAlpha = 0.75;
//        pp.userTouchActionEnable = YES;
//        pp.enablePanContentViewToHide = YES;
//        pp.duration = 0.35;
//        pp.panDirection = PKPanGestureRecognizerDirection_bottom;
        _popview = pp;
    }
    
    return _popview;
}

@end
