//
//  LinearInertiaValue.h
//  phringly
//
//  Created by Alex Skorulis on 08/06/2013.
//  Copyright (c) 2013 Skorulis.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LinearInertiaValue : NSObject

@property (nonatomic, assign) double value;
@property (nonatomic, assign) double inertia;

- (double) updateValue:(double)delta;

@end
