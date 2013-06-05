//
//  SKLingerGestureRecognizer.m
//  phringly
//
//  Created by Alex Skorulis on 03/06/2013.
//  Copyright (c) 2013 Skorulis.com. All rights reserved.
//

#import "SKLingerGestureRecognizer.h"
#import <UIKit/UIGestureRecognizerSubclass.h>

@interface SKLingerGestureRecognizer () {
    BOOL lingered;
}

@property (nonatomic, strong) NSTimer* timer;

@end

@implementation SKLingerGestureRecognizer

- (id) initWithTarget:(id)target action:(SEL)action {
    self = [super initWithTarget:target action:action];
    self.lingerTime = 0.2f;
    return self;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    NSLog(@"Began");
    self.state = UIGestureRecognizerStatePossible;
    self.timer = [NSTimer scheduledTimerWithTimeInterval:self.lingerTime target:self selector:@selector(recognize) userInfo:nil repeats:NO];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    NSLog(@"Moved");
    if(lingered) {
        self.state = UIGestureRecognizerStateChanged;
    } else {
        [self.timer invalidate]; self.timer = nil;
        self.state = UIGestureRecognizerStateFailed;
    }
}

- (void) touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    [self.timer invalidate]; self.timer = nil;
    self.state = UIGestureRecognizerStateEnded;
}

- (void) recognize {
    NSLog(@"RECOG");
    self.state = UIGestureRecognizerStateBegan;
    lingered = TRUE;
    self.timer = nil;
}

- (void) reset {
    [super reset];
    lingered = FALSE;
}

@end
