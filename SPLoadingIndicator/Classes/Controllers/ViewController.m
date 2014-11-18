//
//  ViewController.m
//  SpinnerView
//
//  Created by Jan on 18/11/14.
//  Copyright (c) 2014 Tequila Apps. All rights reserved.
//

#import "ViewController.h"
#import "SPLoadingIndicator.h"

@interface ViewController ()

@property(nonatomic, strong) SPLoadingIndicator *loadingIndicatorView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.spinnerView = [[SPLoadingIndicator alloc] init];
//    [self.view addSubview:self.spinnerView];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];

    self.loadingIndicatorView.frame = CGRectMake(0, 0, 100, 100);
    self.loadingIndicatorView.center = self.view.center;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
