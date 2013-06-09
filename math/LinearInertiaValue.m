//
//  LinearInertiaValue.m
//  phringly
//
//  Created by Alex Skorulis on 08/06/2013.
//  Copyright (c) 2013 Skorulis.com. All rights reserved.
//

#import "LinearInertiaValue.h"

@interface LinearInertiaValue () {
    double lastTime;
}

@end

@implementation LinearInertiaValue

- (void) setInitialValue:(double)initialValue {
    _initialValue = initialValue;
    lastTime = CACurrentMediaTime();
}

- (double) getCurrentValue {
    double currentTime = CACurrentMediaTime();
    
}

@end
