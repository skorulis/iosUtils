//
//  PanningTableViewCell.m
//  robin
//
//  Created by Alex Skorulis on 26/04/2013.
//  Copyright (c) 2013 Alex Skorulis. All rights reserved.
//

#import "PanningTableViewCell.h"
#import "UIView+Additions.h"

@interface PanningTableViewCell ()

@property (nonatomic, strong) UIPanGestureRecognizer* pan;

@end

@implementation PanningTableViewCell

- (void) awakeFromNib {
    [super awakeFromNib];
    self.pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(didPan:)];
    self.pan.delegate = self;
    self.maxTranslation = 80;
    self.triggerPadding = 5;
    [self addGestureRecognizer:self.pan];
}

- (BOOL)gestureRecognizerShouldBegin:(UIPanGestureRecognizer *)gestureRecognizer {
    if([gestureRecognizer isKindOfClass:UIPanGestureRecognizer.class]) {
        UIView *cell = [gestureRecognizer view];
        CGPoint translation = [gestureRecognizer translationInView:[cell superview]];
        
        return fabsf(translation.x) > fabsf(translation.y);
    }
    return NO;
}

- (void) didPan:(UIPanGestureRecognizer*)gesture {
    if(gesture.state == UIGestureRecognizerStateChanged) {
        CGPoint translation = [gesture translationInView:self];
        CGFloat x = translation.x;
        x = MIN(x, 0);
        x = MAX(x, -self.maxTranslation);
        
        self.contentView.x = x;
    } else if(gesture.state == UIGestureRecognizerStateEnded) {
        if(self.contentView.x <= -(self.maxTranslation-self.triggerPadding) ) {
            [self.panDelegate cellDidPanRight:self];
        }
        [self animateToPosition];
    }
}

- (void) animateToPosition {
    [UIView animateWithDuration:0.2f delay:0 options:0 animations:^{
        self.contentView.x = 0;
    } completion:nil];
}

@end
