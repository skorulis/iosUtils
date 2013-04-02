//
//  DrawingContext.h
//  robin
//
//  Created by Alex Skorulis on 16/03/2013.
//  Copyright (c) 2013 Alex Skorulis. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DrawingContext : NSObject

@property (nonatomic, readonly) CGContextRef ctx;
@property (nonatomic, readonly) CGSize size;

+ (DrawingContext*) getContext:(CGSize)size;
- (UIImage*) image;
- (void) setFillColor:(UIColor *)fillColor;
- (void) setStrokeColor:(UIColor*)color;
- (void) setLineWidth:(CGFloat)width;
- (void) strokeElipse:(CGRect)rect;

- (void) strokePath;

- (void) addElipseToPath:(CGRect)rect;
- (void) moveToPoint:(CGFloat)x y:(CGFloat)y;
- (void) addLineToPoint:(CGFloat)x y:(CGFloat)y;

@end
