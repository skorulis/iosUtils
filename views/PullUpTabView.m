//
//  PullUpTabView.m
//  pulltest
//
//  Created by Alex Skorulis on 14/05/2013.
//  Copyright (c) 2013 Skorulis.com. All rights reserved.
//

#import "PullUpTabView.h"
#import "UIView+Additions.h"

#define PAN_Y_PAD 10

@interface PullUpTabView ()

@property (nonatomic, strong) UIView* handleOuter;
@property (nonatomic, strong) UIView* contentOuter;
@property (nonatomic, strong) UIView* panView;
@property (nonatomic, strong) UIView* handle;
@property (nonatomic, strong) UIView* spinningHandle;

@property (nonatomic, strong) UIPanGestureRecognizer* pan;
@property (nonatomic, strong) UITapGestureRecognizer* tap;
@property (nonatomic, assign) BOOL atTop;

@end

@implementation PullUpTabView

- (void) awakeFromNib {
    [super awakeFromNib];
    self.handleOuter = [[UIView alloc] initWithFrame:CGRectMake(0, self.height, self.width, 0)];
    self.contentOuter = [[UIView alloc] initWithFrame:CGRectMake(0, self.height, self.width, 0)];
    self.panView = [[UIView alloc] initWithFrame:CGRectMake(0, self.height, self.width, 0)];
    
    [self addSubview:self.contentOuter];
    [self addSubview:self.handleOuter];
    [self addSubview:self.panView];
    
    self.pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panned:)];
    self.tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapped:)];
    [self.panView addGestureRecognizer:self.pan];
    [self.panView addGestureRecognizer:self.tap];
}

- (void) panned:(UIPanGestureRecognizer*)gesture {
    CGPoint trans = [gesture translationInView:self];
    CGFloat y = 0;
    CGFloat min = [self handleMinY]; CGFloat max = [self handleMaxY];
    if(self.atTop) {
        y = min + trans.y;
    } else {
        y = max + trans.y;
    }
    
    if(gesture.state == UIGestureRecognizerStateChanged) {
        y = MIN(y,max);
        y = MAX(y,min);
        self.handleOuter.y = y;
        self.panView.y = y - PAN_Y_PAD;
        self.contentOuter.y = self.handleOuter.bottom;
        float pct = 1-(y-min)/(max - min);
        self.spinningHandle.transform = CGAffineTransformMakeRotation(M_PI*pct);
        
    } else if(gesture.state == UIGestureRecognizerStateEnded || gesture.state == UIGestureRecognizerStateFailed) {
        CGFloat mid = (min + max)/2;
        [UIView animateWithDuration:0.24f animations:^{
            CGFloat animPos;
            if(y < mid) {
                self.atTop = TRUE;
                animPos = min;
                self.spinningHandle.transform = CGAffineTransformMakeRotation(M_PI);
            } else {
                self.atTop = FALSE;
                animPos = max;
                self.spinningHandle.transform = CGAffineTransformIdentity;
            }
            self.handleOuter.y = animPos;
            self.panView.y = animPos;
            self.contentOuter.y = self.handleOuter.bottom;
        }];
    }
}

- (void) tapped:(UITapGestureRecognizer*)tap {
    if(tap.state == UIGestureRecognizerStateRecognized) {
        [self toggleState];
    }
}

- (void) toggleState {
    CGFloat min = [self handleMinY]; CGFloat max = [self handleMaxY];
    [UIView animateWithDuration:0.29f animations:^{
        CGFloat animPos;
        if(!self.atTop) {
            self.atTop = TRUE;
            animPos = min;
            self.spinningHandle.transform = CGAffineTransformMakeRotation(M_PI);
        } else {
            self.atTop = FALSE;
            animPos = max;
            self.spinningHandle.transform = CGAffineTransformIdentity;
        }
        self.handleOuter.y = animPos;
        self.panView.y = animPos;
        self.contentOuter.y = self.handleOuter.bottom;
    }];
}

- (CGFloat) handleMinY {
    return self.height - self.handleOuter.height - self.contentOuter.height;
}

- (CGFloat) handleMaxY {
    return self.height - self.handleOuter.height;
}

- (void) reload {
    self.handle = [self.delegate pullUpTabViewHandle:self];
    self.spinningHandle = [self.delegate pullUpTabViewSpinningHandle:self];
    
    [self.handle addSubview:self.spinningHandle];
    [self.spinningHandle centerInParentRounded];
    
    UIView* content = [self.delegate pullUpTabViewContent:self];
    
    [self.handleOuter addSubview:self.handle];
    [self.handle centerInParentHorizontalRounded];
    
    [self.contentOuter addSubview:content];
    [content centerInParentHorizontalRounded];
    
    self.contentOuter.height = content.height;
    self.handleOuter.height = self.handle.height;
    [self layoutSubviews];
}

- (void) layoutSubviews {
    [super layoutSubviews];
    
    self.handleOuter.y = self.height - self.handleOuter.height;
    self.contentOuter.y = self.height;
    CGFloat height = self.contentOuter.bottom - self.handleOuter.y;
    self.panView.frame = CGRectMake(0, self.handleOuter.y - PAN_Y_PAD, self.width, height + PAN_Y_PAD);
    
}

- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event {
    if(point.y < self.handleOuter.y) { return FALSE;}
    if(point.y > self.handleOuter.bottom) { return TRUE;}
    if(point.x < self.handle.x) { return FALSE;}
    if(point.x > self.handle.right) { return FALSE;}
    return TRUE;
}


@end
