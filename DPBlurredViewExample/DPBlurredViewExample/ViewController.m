//
//  ViewController.m
//  DPBlurredViewExample
//
//  Created by ILYA2606 on 17.09.13.
//  Copyright (c) 2013 Darkness Production. All rights reserved.
//

#import "ViewController.h"


@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //configure blurredView
    _blurredView.blurringFPS = 30;
    _blurredView.blurringRadius = _sl_radius.value;
    [_blurredView startBlurring];
    
    //set up pan gesture
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(didPan:)];
    pan.maximumNumberOfTouches = 1;
    [_blurredView addGestureRecognizer:pan];
}

- (void)viewDidUnload {
    [self setBlurredView:nil];
    [self setBlurredView:nil];
    [self setSl_radius:nil];
    [super viewDidUnload];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)didPan:(UIPanGestureRecognizer*)pan{
    if(pan.state == UIGestureRecognizerStateBegan){
        beginCenter = _blurredView.center;
    }
    else if(pan.state == UIGestureRecognizerStateChanged){
        CGPoint translation = [pan translationInView:_blurredView];
        CGPoint futureCenterPoint = CGPointMake(beginCenter.x+translation.x, beginCenter.y+translation.y);
        if(futureCenterPoint.x - _blurredView.frame.size.width/2 < 0)
            futureCenterPoint.x = _blurredView.frame.size.width/2;
        else if(futureCenterPoint.x + _blurredView.frame.size.width/2 > self.view.bounds.size.width)
            futureCenterPoint.x = self.view.bounds.size.width - _blurredView.frame.size.width/2;
        if(futureCenterPoint.y - _blurredView.frame.size.height/2 < 0)
            futureCenterPoint.y = _blurredView.frame.size.height/2;
        else if(futureCenterPoint.y + _blurredView.frame.size.height/2 > self.view.bounds.size.height)
            futureCenterPoint.y = self.view.bounds.size.height - _blurredView.frame.size.height/2;
        _blurredView.center = futureCenterPoint;
    }
}

#pragma mark - IBActions

- (IBAction)radiusChanged:(id)sender {
    _blurredView.blurringRadius = _sl_radius.value;
}

- (IBAction)startBlurring:(id)sender {
    [_blurredView startBlurring];
}

- (IBAction)stopBlurring:(id)sender {
    [_blurredView stopBlurring];
}
@end
