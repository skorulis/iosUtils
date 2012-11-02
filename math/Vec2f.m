//
//  Vec2f.m
//  nodewar
//
//  Created by Alex Skorulis on 26/02/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Vec2f.h"

@implementation Vec2f

@synthesize x,y;

- (Vec2f*) addE:(Vec2f*)vec mult:(double)mult {
    x+=vec.x*mult;
    y+=vec.y*mult;
    return self;
}

- (double) dist:(double)x1 y:(double)y1 {
    return sqrt((x-x1)*(x-x1) + (y-y1)*(y-y1)); 
}

@end
