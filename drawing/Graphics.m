//
//  Graphics.m
//  PathTester
//
//  Created by Alex Skorulis on 10/06/13.
//  Copyright (c) 2013 Alex Skorulis. All rights reserved.
//

#import "Graphics.h"
#import <QuartzCore/QuartzCore.h>
#import "CGPointMath.h"

#define SPIKE_RADIANS M_PI / 5
#define RIGHT_CIRCLE_RATIO 0.43f
#define LEFT_CIRCLE_RATIO 0.25f
#define SPIKE_RATIO 0.51f
#define GAP_RATIO 0.03f

@implementation Graphics

+ (CGPathRef) newSkorulisLogoPath:(CGFloat)size {
    float rightCircleSize = RIGHT_CIRCLE_RATIO*size;
    float leftCircleSize = LEFT_CIRCLE_RATIO*size;
    
    
    
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathAddEllipseInRect(path, NULL, CGRectMake(size-rightCircleSize, size-rightCircleSize, rightCircleSize, rightCircleSize));
    
    CGPathAddEllipseInRect(path, NULL, CGRectMake(0, 0, leftCircleSize, leftCircleSize));
    
    [self drawSpike:path angle:-3*M_PI_4 size:size];
    [self drawSpike:path angle:-M_PI size:size];
    [self drawSpike:path angle:-M_PI_2 size:size];
    
    
    return path;
}

+ (void) drawSpike:(CGMutablePathRef)path angle:(CGFloat)angle size:(CGFloat)size {
    float gapSize = GAP_RATIO * size;
    float spikeRadius = RIGHT_CIRCLE_RATIO*size*0.5 + gapSize;
    float spikeSize = SPIKE_RATIO*size;
    
    CGFloat rCirclePoint = size-RIGHT_CIRCLE_RATIO*size*0.5;
    
    CGPoint dir1 = [CGPointMath pointFromAngle:(angle-(SPIKE_RADIANS/2))];
    CGPoint dir = [CGPointMath pointFromAngle:(angle)];
    
    float x = rCirclePoint + dir1.x*spikeRadius;
    float y = rCirclePoint + dir1.y*spikeRadius;
    
    CGPathMoveToPoint(path, NULL, x, y);
    
    CGPathAddRelativeArc(path, NULL, rCirclePoint, rCirclePoint, spikeRadius, (angle-SPIKE_RADIANS/2), SPIKE_RADIANS);
    
    x = rCirclePoint + dir.x*(spikeRadius+spikeSize);
    y = rCirclePoint + dir.y*(spikeRadius+spikeSize);
    
    CGPathAddLineToPoint(path, NULL, x, y);
    
    x = rCirclePoint + dir1.x*spikeRadius;
    y = rCirclePoint + dir1.y*spikeRadius;
    
    
    CGPathAddLineToPoint(path, NULL, x, y);
    
}

@end
