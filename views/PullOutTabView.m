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
    
    self.backgroundColor = [UIColor greenColor];
    
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
    [self layoutSubviews];
}

#pragma mark handling all 4 cases

- (CGFloat) handleMinY {
    return self.height - self.handleOuter.height - self.contentOuter.height;
}

- (CGFloat) handleMaxY {
    return self.height - self.handleOuter.height;
}

- (CGFloat) handleMinX {
    return self.width - self.handleOuter.width - self.contentOuter.width;
}

- (CGFloat) handleMaxX {
    return self.width - self.handleOuter.width;
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
    CGPoint trans = [gesture translationInView:self];
    
}

- (void) tapped:(UITapGestureRecognizer*)tap {
    if(tap.state == UIGestureRecognizerStateRecognized) {
        [UIView animateWithDuration:0.35f animations:^{
            [self toggleState];
        }];
        
    }
}

@end
