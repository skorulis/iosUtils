//
//  Delta.m
//  phringly
//
//  Created by Alex Skorulis on 14/06/2013.
//  Copyright (c) 2013 Skorulis.com. All rights reserved.
//

#import "Delta.h"

@interface Delta () {
    double _lastValue;
    double _currentDelta;
}



@end

@implementation Delta

- (id) init {
    self = [super init];
    self.maxDelta = 0.5f;
    return self;
}

- (double) generateDelta {
    double time = CACurrentMediaTime();
    _currentDelta = (time - _lastValue);
    if(_currentDelta > 0.3) { _currentDelta = 0; }
    _lastValue = time;
    return _currentDelta;
}

- (double) currentDelta {
    return _currentDelta;
}

@end
