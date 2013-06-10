//
//  Graphics.m
//  PathTester
//
//  Created by Alex Skorulis on 10/06/13.
//  Copyright (c) 2013 Alex Skorulis. All rights reserved.
//

#import "Graphics.h"
#import <QuartzCore/QuartzCore.h>

@implementation Graphics

+ (CGPathRef) newSkorulisLogoPath:(CGFloat)size {
    float rightCircleRatio = 0.4f;
    float leftCircleRatio = 0.2f;
    float gapRatio = 0.05f;
    float spikeRadians = M_PI / 12;
    float rightCircleSize = rightCircleRatio*size;
    float leftCircleSize = leftCircleRatio*size;
    float gapSize = gapRatio * size;
    float spikeRadius = rightCircleSize + gapSize;
    
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathAddEllipseInRect(path, NULL, CGRectMake(size-rightCircleSize, size-rightCircleSize, rightCircleSize, rightCircleSize));
    
    CGPathAddEllipseInRect(path, NULL, CGRectMake(0, 0, leftCircleSize, leftCircleSize));
    
    CGPathMoveToPoint(path, NULL, <#CGFloat x#>, <#CGFloat y#>)
    
    return path;
}

@end
