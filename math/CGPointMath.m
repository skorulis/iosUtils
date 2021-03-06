//
//  CGPointMath.m
//  phringly
//
//  Created by Alex Skorulis on 31/05/2013.
//  Copyright (c) 2013 Skorulis.com. All rights reserved.
//

#import "CGPointMath.h"

@implementation CGPointMath

+ (CGFloat) dist:(CGPoint)p1 p2:(CGPoint)p2 {
    CGFloat f = (p1.x - p2.x)*(p1.x - p2.x) + (p1.y - p2.y)*(p1.y - p2.y);
    return sqrtf(f);
}

+ (CGPoint) normalise:(CGPoint)p1 {
    CGFloat len = [self length:p1];
    if(len == 0) { return CGPointMake(0, 0); }
    return CGPointMake(p1.x/len, p1.y/len);
}

+ (CGFloat) length:(CGPoint)p1 {
    return sqrt(p1.x*p1.x + p1.y*p1.y);
}

+ (CGFloat) dotProduct:(CGPoint)p1 p2:(CGPoint)p2 {
    return p1.x*p2.x + p1.y*p2.y;
}

+ (CGFloat) rotation:(CGPoint)point {
    return atan2f(point.y, point.x);
}

+ (CGPoint) point:(CGPoint)p1 minus:(CGPoint)p2 {
    return CGPointMake(p1.x-p2.x, p1.y-p2.y);
}

+ (CGPoint) pointFromAngle:(CGFloat)angle {
    return CGPointMake(cosf(angle), sinf(angle));
}

+ (CGPoint) mult:(CGPoint)point scalar:(float)s {
    return CGPointMake(point.x*s, point.y*s);
}

+ (CGPoint) add:(CGPoint)p1 p2:(CGPoint)p2 {
    return CGPointMake(p1.x + p2.x, p1.y + p2.y);
}

+ (CGPoint) round:(CGPoint)p {
    return CGPointMake(roundf(p.x), roundf(p.y));
}

@end
