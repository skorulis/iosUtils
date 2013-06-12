//
//  Graphics.h
//  PathTester
//
//  Created by Alex Skorulis on 10/06/13.
//  Copyright (c) 2013 Alex Skorulis. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Graphics : NSObject

+ (CGPathRef) newSkorulisLogoPath:(CGFloat)size;
+ (CGPathRef) drawSpike:(CGMutablePathRef)path angle:(CGFloat)angle size:(CGFloat)size;
+ (CGPathRef) drawCircles:(CGMutablePathRef)path size:(CGFloat)size;
+ (UIImage*) imageFromColor:(UIColor*)color;

@end
