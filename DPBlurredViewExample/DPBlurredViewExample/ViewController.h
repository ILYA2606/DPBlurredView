//
//  ViewController.h
//  DPBlurredViewExample
//
//  Created by ILYA2606 on 17.09.13.
//  Copyright (c) 2013 Darkness Production. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DPBlurredView.h"

@interface ViewController : UIViewController{
    CGPoint beginCenter;
}
@property (strong, nonatomic) IBOutlet DPBlurredView *blurredView;
@property (strong, nonatomic) IBOutlet UISlider *sl_radius;

- (IBAction)radiusChanged:(id)sender;
- (IBAction)startBlurring:(id)sender;
- (IBAction)stopBlurring:(id)sender;

@end
