//
//  ViewController.m
//  PopView
//
//  Created by pengkang on 2019/1/22.
//  Copyright © 2019年 pengkang. All rights reserved.
//

#import "ViewController.h"
#import "PKShowPopView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
    [self showLabel];
    
    
}

-(void)showLabel{
    UILabel *label = [UILabel new];
    label.numberOfLines = 0;
    label.text = @"labelFakeViewControllerFakeViewControllerFakeViewControllerFakeViewControllerFakeViewControllerFakeViewController";
    label.textColor = [UIColor redColor];
    label.backgroundColor = [UIColor blackColor];
    label.preferredMaxLayoutWidth = 100;
    
    PKShowPopView *pp = [[PKShowPopView alloc]init];
    pp.useAutoLayout = YES;
    pp.contentView = label;
    pp.backColor = [UIColor lightGrayColor];
    pp.showAnimationStyle = PKShowAnimationStyle_fromBottom;
    pp.hideAnimationStyle = arc4random_uniform(100)%5;
    pp.layoutPositon = PKAutoLayoutPosition_center ;
    pp.contentViewInsets = UIEdgeInsetsMake(0, 60, 0, 60);
    [pp showOnView:self.view];
    pp.showCompletionBlock = ^{
        NSLog(@"showCompletionBlock");
    };
    
    __weak typeof(self) weakself = self;
    pp.hideCompletionBlock = ^{
        NSLog(@"hideCompletionBlock");
        [weakself showLabel];
    };
}

@end
