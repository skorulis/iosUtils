//
//  LinearInertiaValue.m
//  phringly
//
//  Created by Alex Skorulis on 08/06/2013.
//  Copyright (c) 2013 Skorulis.com. All rights reserved.
//

#import "LinearInertiaValue.h"

@implementation LinearInertiaValue

- (double) updateValue:(double)delta {
    _value -= _value * 0.5 * delta;
    return _value;
}

@end
