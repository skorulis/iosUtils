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
#define SPIKE_RATIO 0.46f
#define GAP_RATIO 0.03f
#define EDGE_GAP 0.03f

@implementation Graphics

+ (CGPathRef) newSkorulisLogoPath:(CGFloat)size {
    
    CGMutablePathRef path = CGPathCreateMutable();
    [self drawCircles:path size:size];
    
    [self drawSpike:path angle:-3*M_PI_4 size:size];
    [self drawSpike:path angle:-M_PI size:size];
    [self drawSpike:path angle:-M_PI_2 size:size];
    
    
    return path;
}

+ (CGPathRef) drawCircles:(CGMutablePathRef)path size:(CGFloat)size {
    if(path == NULL) {
        path = CGPathCreateMutable();
    }
    float rightCircleSize = RIGHT_CIRCLE_RATIO*size;
    float leftCircleSize = LEFT_CIRCLE_RATIO*size;
    CGPathAddEllipseInRect(path, NULL, CGRectMake(size-rightCircleSize-EDGE_GAP*size, size-rightCircleSize-EDGE_GAP*size, rightCircleSize, rightCircleSize));
    
    CGPathAddEllipseInRect(path, NULL, CGRectMake(EDGE_GAP*size, EDGE_GAP*size, leftCircleSize, leftCircleSize));
    return path;
}

+ (CGPathRef) drawSpike:(CGMutablePathRef)path angle:(CGFloat)angle size:(CGFloat)size {
    if(path == NULL) {
        path = CGPathCreateMutable();
    }
    float gapSize = GAP_RATIO * size;
    float spikeRadius = RIGHT_CIRCLE_RATIO*size*0.5 + gapSize;
    float spikeSize = SPIKE_RATIO*size;
    
    CGFloat rCirclePoint = size-RIGHT_CIRCLE_RATIO*size*0.5 - EDGE_GAP*size;
    
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
    return path;
}

@end
