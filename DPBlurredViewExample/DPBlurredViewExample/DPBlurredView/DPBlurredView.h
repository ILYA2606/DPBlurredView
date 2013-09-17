//
//  DPBlurredView.h
//  DPBlurredViewExample
//
//  Created by ILYA2606 on 17.09.13.
//  Copyright (c) 2013 Darkness Production. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import <Accelerate/Accelerate.h>

@interface DPBlurredView : UIView{
    NSTimer *timerForBlurring;
}

@property (nonatomic) float blurringRadius;
@property (nonatomic) float blurringFPS;

-(void)startBlurring;
-(void)stopBlurring;

@end
