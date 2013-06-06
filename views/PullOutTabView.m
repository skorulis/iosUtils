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

@property (nonatomic, assign) BOOL tabOpen;

@end

@implementation PullOutTabView

- (void) awakeFromNib {
    [super awakeFromNib];
    
    self.handleOuter = [UIView new];
    self.contentOuter = [UIView new];
    [self addSubview:self.handleOuter];
    [self addSubview:self.contentOuter];
    
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
}

- (void) layoutSubviews {
    [super layoutSubviews];
    self.handleOuter.size = self.handle.size;
    self.contentOuter.size = self.content.size;
    
    if(self.direction == kPullOutTabBottom) {
        self.handleOuter.y = self.height - self.handleOuter.height;
    } else if(self.direction == kPullOutTabRight) {
        self.handleOuter.x = self.width - self.handleOuter.width - (_tabOpen ? self.contentOuter.width : 0);
        self.contentOuter.x = self.width - (_tabOpen ? self.contentOuter.width : 0);
    }
    
    NSLog(@"Frame %@",NSStringFromCGRect(self.handleOuter.frame));
}

- (void) toggleState {
    self.tabOpen = !self.tabOpen;
    [UIView animateWithDuration:0.35f animations:^{
        [self layoutSubviews];
    }];
}

#pragma mark handling all 4 cases

- (CGFloat) handleMinValue {
    switch (self.direction) {
        case kPullOutTabBottom:
            return self.height - self.handleOuter.height - self.contentOuter.height;
        case kPullOutTabTop:
            return 0;
        case kPullOutTabLeft:
            return 0;
        case kPullOutTabRight:
            return self.width - self.handleOuter.width - self.contentOuter.width;
    }
}

- (CGFloat) handleMaxValue {
    switch (self.direction) {
        case kPullOutTabBottom:
            return self.height - self.handleOuter.height;
        case kPullOutTabTop:
            return self.contentOuter.height;
        case kPullOutTabLeft:
            return self.contentOuter.width;
        case kPullOutTabRight:
            return self.width - self.handleOuter.width;
    }
}

- (CGFloat) desiredPosition:(CGPoint)trans min:(CGFloat)min max:(CGFloat)max {
    switch (self.direction) {
        case kPullOutTabBottom:
            return self.tabOpen ? (min + trans.y) : (max + trans.y);
        case kPullOutTabTop:
        case kPullOutTabLeft:
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
        if([self isHorizontal]) {
            self.handleOuter.x = value;
            self.contentOuter.x = self.handleOuter.right;
        } else {
            self.handleOuter.y = value;
            self.contentOuter.y = self.handleOuter.bottom;
        }
    } else if(gesture.state == UIGestureRecognizerStateEnded || gesture.state == UIGestureRecognizerStateFailed) {
        CGFloat mid = (min + max)/2;
        if(value < mid) {
            self.tabOpen = YES;
        } else {
            self.tabOpen = FALSE;
        }
        [UIView animateWithDuration:0.35f animations:^{
            [self layoutSubviews];
        }];
        
    }
}

- (void) tapped:(UITapGestureRecognizer*)tap {
    if(tap.state == UIGestureRecognizerStateRecognized) {
        [self toggleState];
    }
}

@end
