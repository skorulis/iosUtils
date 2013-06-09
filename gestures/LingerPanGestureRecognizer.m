//
//  LingerPanGestureRecognizer.m
//  phringly
//
//  Created by Alex Skorulis on 09/06/2013.
//  Copyright (c) 2013 Skorulis.com. All rights reserved.
//

#import "LingerPanGestureRecognizer.h"
#import <UIKit/UIGestureRecognizerSubclass.h>

@interface LingerPanGestureRecognizer ()

@property (nonatomic, assign) double touchTime;
@property (nonatomic, strong) NSTimer* timer;
@property (nonatomic, strong) UITouch* touch;

@end

@implementation LingerPanGestureRecognizer

- (void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [super touchesBegan:touches withEvent:event];
    if(self.state == UIGestureRecognizerStatePossible) {
        self.touch = [touches anyObject];
        self.touchTime = CACurrentMediaTime();
        self.timer = [NSTimer scheduledTimerWithTimeInterval:self.lingerTime target:self selector:@selector(lingered) userInfo:nil repeats:NO];
        NSLog(@"TOUCH");
    }
}

- (void) touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    double currentTime = CACurrentMediaTime();
    [self.timer invalidate]; self.timer = nil;
    if(currentTime - self.touchTime < self.lingerTime) {
        self.state = UIGestureRecognizerStateFailed;
    } else {
        [super touchesMoved:touches withEvent:event];
    }
}

- (void) lingered {
    NSLog(@"Lingered");
    self.timer = nil;
    id<LingerPanGestureRecognizerDelegate> d = (id<LingerPanGestureRecognizerDelegate>) self.delegate;
    if([d respondsToSelector:@selector(gestureLingered:touch:)]) {
        [d gestureLingered:self touch:self.touch];
    }
}

- (void) setDelegate:(id<LingerPanGestureRecognizerDelegate>)delegate {
    [super setDelegate:delegate];
}

- (void) setState:(UIGestureRecognizerState)state {
    NSLog(@"Moved to state %d",state);
    [self.timer invalidate]; self.timer = nil;
    [super setState:state];
}

@end
