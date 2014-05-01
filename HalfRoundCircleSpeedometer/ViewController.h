//
//  ViewController.h
//  HalfRoundCircleSpeedometer
//
//  Created by Yogesh Suthar on 01/05/14.
//  Copyright (c) 2014 Appliton. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CircleCounter.h"

@interface ViewController : UIViewController <CircleCounterDelegate>

@property (strong, nonatomic) IBOutlet CircleCounter *circleCounter;
@property (weak, nonatomic) IBOutlet UILabel *lblPercentage;
@property (strong, nonatomic) IBOutlet UILabel *secondsLabel;

@end
