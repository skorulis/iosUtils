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
    float rightCircleSize = rightCircleRatio*size;
    
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathAddEllipseInRect(path, NULL, CGRectMake(size-rightCircleSize, size-rightCircleSize, rightCircleSize, rightCircleSize));
    
    
    return path;
}

@end
