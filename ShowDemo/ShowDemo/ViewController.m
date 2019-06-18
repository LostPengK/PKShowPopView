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

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
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
    
    NView *vv = [NView new];
    vv.backgroundColor = [UIColor yellowColor];
    if (!autolayout) {
        vv.frame = CGRectMake(100, 100, 100, 100);
    }
    
    self.popview.contentView = vv;
    if (autolayout) {
        self.popview.layoutPositon = PKAutoLayoutPosition_left|PKAutoLayoutPosition_right|PKAutoLayoutPosition_bottom ;
    }
    
//    self.popview.contentViewInsets = UIEdgeInsetsMake(self.view.frame.size.height/2.0, 0, 0, 0);
//    self.popview.popViewInsets  = UIEdgeInsetsMake(0, 0, 50, 0);
    [self.popview showOnView:self.view];
    self.popview.showCompletionBlock = ^{
        
    };
    
    self.popview.hideCompletionBlock = ^{
    };
}

-(PKShowPopView *)popview{
    if (!_popview ) {
        PKShowPopView *pp = [[PKShowPopView alloc]init];
        pp.useAutoLayout = YES;
        pp.backColor = [UIColor blackColor];
        pp.showAnimationStyle = PKShowAnimationStyle_fromBottom;// arc4random_uniform(100)%5;;
        pp.hideAnimationStyle = PKHideAnimationStyle_toBottom;//arc4random_uniform(100)%5;
        pp.backAlpha = 0.75;
        pp.userTouchActionEnable = YES;
        pp.enablePanContentViewToHide = YES;
        pp.duration = 0.35;
        pp.panDirection = PKPanGestureRecognizerDirection_bottom;
        _popview = pp;
    }
    
    return _popview;
}

@end
