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
    
    UIPinchGestureRecognizer *pinch = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(didPinch:)];
    [_blurredView addGestureRecognizer:pinch];
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

-(void)didPinch:(UIPinchGestureRecognizer*)pinch{
    if(pinch.state == UIGestureRecognizerStateBegan){
        beginCenter = _blurredView.center;
        beginSize = _blurredView.frame.size;
    }
    else if(pinch.state == UIGestureRecognizerStateChanged){
        NSLog(@"%f", pinch.scale);
        float scale = pinch.scale;
        float newWidth = beginSize.width*scale;
        float newHeight = beginSize.height*scale;
        if(beginCenter.x-newWidth/2 < 0)
            newWidth = beginCenter.x * 2;
        if(beginCenter.x+newWidth/2 > self.view.bounds.size.width)
            newWidth = (self.view.bounds.size.width - beginCenter.x) * 2;
        if(beginCenter.y-newHeight/2 < 0)
            newHeight = beginCenter.y * 2;
        if(beginCenter.y+newHeight/2 > self.view.bounds.size.height)
            newHeight = (self.view.bounds.size.height - beginCenter.y) * 2;
        _blurredView.frame = CGRectMake(beginCenter.x-newWidth/2, beginCenter.y-newHeight/2, newWidth, newHeight);
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
