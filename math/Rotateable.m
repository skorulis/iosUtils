//
//  Rotateable.m
//  phringly
//
//  Created by Alex Skorulis on 25/06/2013.
//  Copyright (c) 2013 Skorulis.com. All rights reserved.
//

#import "Rotateable.h"

@implementation Rotateable

- (id) init {
    self = [super init];
    self.rotSpeed = 5;
    return self;
}

- (void) update:(CGFloat)rot {
    if(self.rotActive) {
        self.lastRotTime = CACurrentMediaTime();
        self.lastRotAmount = rot - self.lastRot;
        self.rotation+=self.lastRotAmount*self.rotSpeed;
    } else {
        self.rotActive = TRUE;
    }
    self.lastRot = rot;
}

- (void) end {
    self.rotActive = FALSE;
}

@end
