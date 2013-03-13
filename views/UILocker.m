//
//  UILocker.m
//  robin
//
//  Created by Alex Skorulis on 03/03/2013.
//  Copyright (c) 2013 Alex Skorulis. All rights reserved.
//

#import "UILocker.h"
#import "UIView+Additions.h"

static UIFont* defaultFont;

@implementation UILocker

+ (UILocker*) lockView:(UIView*)view state:(UILockerState)state {
    UILocker* locker = [[UILocker alloc] initWithFrame:view.frame];
    locker.autoresizingMask = view.autoresizingMask;
    locker.target = view;
    [locker setState:state];
    [locker.target.superview addSubview:locker];
    if(defaultFont) {
        locker.label.font = defaultFont;
    }
    
    return locker;
}

+ (void) setDefaultFont:(UIFont*)font {
    defaultFont = font;
}

- (id)initWithFrame:(CGRect)frame {
    return [self = [super initWithFrame:frame] commonInit];
}

- (id) initWithCoder:(NSCoder *)aDecoder {
    return [self = [super initWithCoder:aDecoder] commonInit];
}

- (id) commonInit {
    self.label = [[UILabel alloc] initWithFrame:self.bounds];
    self.label.textAlignment = NSTextAlignmentCenter;
    self.label.backgroundColor = [UIColor clearColor];
    self.activity = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    self.activity.frame = self.bounds;
    self.activity.autoresizingMask = self.label.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    
    self.emptyString = NSLocalizedString(@"No items to display", nil);
    self.errorString = NSLocalizedString(@"An error has occured", nil);
    self.userInteractionEnabled = self.activity.userInteractionEnabled = self.label.userInteractionEnabled = FALSE;
    
    self.retryButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [self.retryButton setTitle:@"Retry" forState:UIControlStateNormal];
    self.retryButton.frame = CGRectMake(200, 200, 60, 30);
    [self.retryButton addTarget:self action:@selector(retryPressed) forControlEvents:UIControlEventTouchUpInside];
    
    [self addSubview:self.activity];
    [self addSubview:self.label];
    [self addSubview:self.retryButton];
    return self;
}

- (void) layoutSubviews {
    [super layoutSubviews];
    [self.retryButton centerInParentRounded];
    self.retryButton.y += 35;
}

- (void) setState:(UILockerState)state {
    self.label.hidden = state != kUILockerStateEmpty && state != kUILockerStateError;
    self.retryButton.hidden = state != kUILockerStateError;
    if(state == kUILockerStateEmpty) {
        self.label.text = self.emptyString;
    } else if(state == kUILockerStateError){
        self.label.text = self.errorString;
    }
    if(state == kUILockerStateLoading) {
        [self.activity startAnimating];
    } else {
        [self.activity stopAnimating];
    }
    
    self.activity.hidden = state != kUILockerStateLoading;
    self.target.hidden = state != kUILockerStateNormal;
}

- (void) retryPressed {
    
}

@end
