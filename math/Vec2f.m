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

- (Vec2f*) maxE:(double)max {
    float l = [self len];
    if(l > max) {
        double d = max/l;
        x*=d;
        y*=d;
    }
    return self;
}

- (Vec2f*) minus:(Vec2f*)v {
    Vec2f* ret = [Vec2f new];
    ret.x = self.x - v.x;
    ret.y = self.y - v.y;
    return ret;
}

- (Vec2f*) normaliseE {
    double l = [self len];
    if(l > 0) {
        x/=l;
        y/=l;
    }
    return self;
}

- (Vec2f*) multE:(double)val {
    x*=val;
    y*=val;
    return self;
}

- (Vec2f*) clampE:(double)max {
    double l = self.len;
    if(l > max) {
        double m = l/max;
        x/=m;
        y/=m;
    }
    return self;
}

- (double) len {
    return sqrt(x*x + y*y);
}

- (double) dist:(Vec2f*)v {
    return sqrt( (x-v.x)*(x-v.x) + (y-v.y)*(y-v.y) );
}

- (double) dist:(double)x1 y:(double)y1 {
    return sqrt((x-x1)*(x-x1) + (y-y1)*(y-y1)); 
}

@end
