//
//  CGPointMath.h
//  phringly
//
//  Created by Alex Skorulis on 31/05/2013.
//  Copyright (c) 2013 Skorulis.com
//

#import <Foundation/Foundation.h>

@interface CGPointMath : NSObject

+ (CGFloat) dist:(CGPoint)p1 p2:(CGPoint)p2;
+ (CGPoint) normalise:(CGPoint)p1;
+ (CGFloat) length:(CGPoint)p1;
+ (CGFloat) dotProduct:(CGPoint)p1 p2:(CGPoint)p2;
+ (CGFloat) rotation:(CGPoint)point;

+ (CGPoint) point:(CGPoint)p1 minus:(CGPoint)p2;
+ (CGPoint) pointFromAngle:(CGFloat)angle;

+ (CGPoint) mult:(CGPoint)point scalar:(float)s;
+ (CGPoint) add:(CGPoint)p1 p2:(CGPoint)p2;


@end
