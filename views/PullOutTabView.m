//
//  PullOutTabView.m
//  phringly
//
//  Created by Alex Skorulis on 06/06/2013.
//  Copyright (c) 2013 Skorulis.com. All rights reserved.
//

#import "PullOutTabView.h"
#import "UIView+Additions.h"

@interface PullOutTabView ()

@property (nonatomic, strong) UIView* handleOuter;
@property (nonatomic, strong) UIView* contentOuter;
@property (nonatomic, strong) UIView* handle;
@property (nonatomic, strong) UIView* spinningHandle;
@property (nonatomic, strong) UIView* content;

@property (nonatomic, strong) UIPanGestureRecognizer* pan;
@property (nonatomic, strong) UITapGestureRecognizer* tap;

@end

@implementation PullOutTabView

- (void) awakeFromNib {
    [super awakeFromNib];
    
    self.allContentHolder = [[UIView alloc] initWithFrame:self.bounds];

    self.handleOuter = [UIView new];
    self.contentOuter = [UIView new];
    [self.allContentHolder addSubview:self.handleOuter];
    [self.allContentHolder addSubview:self.contentOuter];
    [self addSubview:self.allContentHolder];
    
    self.pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panned:)];
    self.tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapped:)];
    [self.handleOuter addGestureRecognizer:self.pan];
    [self.handleOuter addGestureRecognizer:self.tap];
}

- (void) reload {
    self.handle = [self.delegate pullUpTabViewHandle:self];
    self.spinningHandle = [self.delegate pullUpTabViewSpinningHandle:self];
    self.content = [self.delegate pullUpTabViewContent:self];
    
    [self.contentOuter addSubview:self.content];
    [self.handle addSubview:self.spinningHandle];
    [self.spinningHandle centerInParentRounded];
    
    [self.handleOuter addSubview:self.handle];
    [self layoutSubviews];
    if([self.delegate respondsToSelector:@selector(pullOutTabDidReload:)]) {
        [self.delegate pullOutTabDidReload:self];
    }
}

- (void) layoutSubviews {
    [super layoutSubviews];
    self.handleOuter.size = self.handle.size;
    self.contentOuter.size = self.content.size;
    
    if(self.direction == kPullOutTabBottom) {
        self.handleOuter.y = self.height - self.handleOuter.height;
    } else if(self.direction == kPullOutTabRight) {
        self.handleOuter.x = 0;
        self.contentOuter.x = self.handleOuter.width;
        self.allContentHolder.x = _tabOpen ? [self handleMinValue] : [self handleMaxValue];
        self.allContentHolder.width = self.contentOuter.width + self.handleOuter.width;
    } else if(self.direction == kPullOutTabLeft) {
        self.handleOuter.x = self.contentOuter.width;
        self.contentOuter.x = 0;
        self.allContentHolder.x = _tabOpen ? [self handleMaxValue] : [self handleMinValue];
        self.allContentHolder.width = self.contentOuter.width + self.handleOuter.width;
    }
    
    self.spinningHandle.transform = self.tabOpen ? CGAffineTransformMakeRotation(M_PI) : CGAffineTransformIdentity;
}

- (void) toggleState:(BOOL)animated {
    self.tabOpen = !self.tabOpen;
    float duration = animated ? 0.35f : 0;
    [UIView animateWithDuration:duration animations:^{
        [self layoutSubviews];
    }];
}

#pragma mark handling all 4 cases

- (CGFloat) handleMinValue {
    switch (self.direction) {
        case kPullOutTabBottom:
            return self.height - self.contentOuter.height;
        case kPullOutTabTop:
            return -self.contentOuter.height;
        case kPullOutTabLeft:
            return -self.contentOuter.width;
        case kPullOutTabRight:
            return self.width - self.contentOuter.width;
    }
}

- (CGFloat) handleMaxValue {
    switch (self.direction) {
        case kPullOutTabBottom:
            return self.height;
        case kPullOutTabTop:
            return 0;
        case kPullOutTabLeft:
            return 0;
        case kPullOutTabRight:
            return self.width;
    }
}

- (CGFloat) desiredPosition:(CGPoint)trans min:(CGFloat)min max:(CGFloat)max {
    switch (self.direction) {
        case kPullOutTabBottom:
            return self.tabOpen ? (min + trans.y) : (max + trans.y);
        case kPullOutTabTop:
            return self.tabOpen ? (max + trans.y) : (min + trans.y);
        case kPullOutTabLeft:
            return self.tabOpen ? (max + trans.x) : (min + trans.x);
        case kPullOutTabRight:
            return self.tabOpen ? (min + trans.x) : (max + trans.x);
    }
}


- (BOOL) isHorizontal {
    return self.direction == kPullOutTabRight || self.direction == kPullOutTabLeft;
}

- (BOOL) isVertical {
    return self.direction == kPullOutTabBottom || self.direction == kPullOutTabTop;
}

- (BOOL) isPullDown {
    return self.direction == kPullOutTabTop || self.direction == kPullOutTabLeft;
}

- (BOOL) isPullUp {
    return self.direction == kPullOutTabBottom || self.direction == kPullOutTabRight;
}

#pragma mark gestures

- (void) panned:(UIPanGestureRecognizer*)gesture {
    CGPoint transPoint = [gesture translationInView:self];
    CGFloat min = [self handleMinValue]; CGFloat max = [self handleMaxValue];
    CGFloat value = [self desiredPosition:transPoint min:min max:max];

    if(gesture.state == UIGestureRecognizerStateChanged) {
        value = MIN(value,max);
        value = MAX(value,min);
        float pct;
        if([self isPullUp]) {
            pct = 1-(value-min)/(max - min);
        } else {
            pct = (value-min)/(max - min);
        }
        self.allContentHolder.x = value;
        
        self.spinningHandle.transform = CGAffineTransformMakeRotation(M_PI*pct);
    } else if(gesture.state == UIGestureRecognizerStateEnded || gesture.state == UIGestureRecognizerStateFailed) {
        CGFloat mid = (min + max)/2;
        BOOL newTabState;
        if( (value < mid && [self isPullUp]) || (value > mid && [self isPullDown]) ) {
            newTabState = YES;
        } else {
            newTabState = FALSE;
        }
        if(newTabState != self.tabOpen) {
            [self.delegate pullUpTabStateChanged:self];
        }
        self.tabOpen = newTabState;
        [UIView animateWithDuration:0.35f animations:^{
            [self layoutSubviews];
        }];
        
    }
}

- (void) tapped:(UITapGestureRecognizer*)tap {
    if(tap.state == UIGestureRecognizerStateRecognized) {
        [self toggleState:TRUE];
    }
}

@end
