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

@implementation Graphics

+ (CGPathRef) newSkorulisLogoPath:(CGFloat)size {
    float rightCircleRatio = 0.4f;
    float leftCircleRatio = 0.2f;
    float gapRatio = 0.05f;
    float spikeRadians = M_PI / 12;
    float rightCircleSize = rightCircleRatio*size;
    float leftCircleSize = leftCircleRatio*size;
    float gapSize = gapRatio * size;
    float spikeRadius = rightCircleSize/2 + gapSize;
    float spikeSize = 0.3f*size;
    
    CGFloat rCirclePoint = size-rightCircleSize/2;
    
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathAddEllipseInRect(path, NULL, CGRectMake(size-rightCircleSize, size-rightCircleSize, rightCircleSize, rightCircleSize));
    
    CGPathAddEllipseInRect(path, NULL, CGRectMake(0, 0, leftCircleSize, leftCircleSize));
    
    CGPoint dir = [CGPointMath pointFromAngle:-M_PI];
    
    float x = rCirclePoint + dir.x*spikeRadius;
    float y = rCirclePoint + dir.y*spikeRadius;
    
    
    CGPathMoveToPoint(path, NULL, x, y);
    x = rCirclePoint + dir.x*(spikeRadius+spikeSize);
    y = rCirclePoint + dir.y*(spikeRadius+spikeSize);
    CGPathAddLineToPoint(path, NULL, x, y);
    return path;
}

@end
