//
//  UILocker.m
//  robin
//
//  Created by Alex Skorulis on 03/03/2013.
//  Copyright (c) 2013 Alex Skorulis. All rights reserved.
//

#import "UILocker.h"

@implementation UILocker

+ (UILocker*) lockView:(UIView*)view state:(UILockerState)state {
    UILocker* locker = [[UILocker alloc] initWithFrame:view.frame];
    locker.autoresizingMask = view.autoresizingMask;
    locker.target = view;
    [locker setState:state];
    return locker;
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
    
    [self addSubview:self.activity];
    [self addSubview:self.label];
    return self;
}

- (void) setState:(UILockerState)state {
    self.label.hidden = state == kUILockerStateEmpty || state == kUILockerStateError;
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

@end
