//
//  ViewController.m
//  HalfRoundCircleSpeedometer
//
//  Created by Yogesh Suthar on 01/05/14.
//  Copyright (c) 2014 Appliton. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () {
    CGFloat percentage;
}

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    percentage = 5;
    
    self.circleCounter.delegate = self;
    
    [self.circleCounter startWithSeconds:10 endSecond:percentage withColor:[UIColor greenColor]];
    
    self.lblPercentage.text = [NSString stringWithFormat:@"%f", percentage * 10];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
