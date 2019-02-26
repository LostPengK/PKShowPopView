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
    return CGSizeMake(100, 100);
}

@end

@interface ViewController ()

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
    label.text = @"labelNSLayoutConstraintNSLayoutConstraintNSLayoutConstraintNSLayoutConstraintNSLayoutConstraintNSLayoutConstraintlabelNSLayoutConstraintNSLayoutConstraintNSLayoutConstraintNSLayoutConstraintNSLayoutConstraintNSLayoutConstraint";
    label.textColor = [UIColor redColor];
    label.backgroundColor = [UIColor blackColor];
    label.preferredMaxLayoutWidth = 300;
    
    NView *vv = [NView new];
    vv.backgroundColor = [UIColor yellowColor];
    if (!autolayout) {
        vv.frame = CGRectMake(100, 100, 100, 100);
    }
    
    
    PKShowPopView *pp = [[PKShowPopView alloc]init];
    pp.useAutoLayout = autolayout;
    pp.contentView = vv;
    pp.backColor = [UIColor redColor];
    pp.showAnimationStyle = arc4random_uniform(100)%5;;
    pp.hideAnimationStyle = arc4random_uniform(100)%5;
    
    if (autolayout) {
        pp.layoutPositon = PKAutoLayoutPosition_center ;
    }
    
    pp.contentViewInsets = UIEdgeInsetsMake(0, 0, 0, 0);
    
    [pp showOnView:self.view];
    pp.showCompletionBlock = ^{
        NSLog(@"showCompletionBlock===%@===%@",self.view.constraints,label.constraints);
    };
    
    pp.hideCompletionBlock = ^{
        
        NSLog(@"hideCompletionBlock,label.constraints===%@",label.constraints);
    };
}



@end
