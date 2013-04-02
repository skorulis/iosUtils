//
//  DrawingContext.m
//  robin
//
//  Created by Alex Skorulis on 16/03/2013.
//  Copyright (c) 2013 Alex Skorulis. All rights reserved.
//

#import "DrawingContext.h"

@implementation DrawingContext

@synthesize ctx = ctx;

+ (DrawingContext*) getContext:(CGSize)size {
    return [[DrawingContext alloc] initWithSize:size];
}

- (id) initWithSize:(CGSize)size {
    self = [super init];
    UIGraphicsBeginImageContextWithOptions(size, NO, 0.0f);
    ctx = UIGraphicsGetCurrentContext();
    _size = size;
    return self;
}

- (void) setFillColor:(UIColor *)fillColor {
    CGContextSetFillColorWithColor(self.ctx, fillColor.CGColor);
}

- (void) setStrokeColor:(UIColor*)color {
    CGContextSetStrokeColorWithColor(ctx, color.CGColor);
}

- (void) setLineWidth:(CGFloat)width {
    CGContextSetLineWidth(ctx, width);
}

- (void) strokeElipse:(CGRect)rect {
    CGRect sRect = CGRectMake(rect.origin.x, rect.origin.y, rect.size.width, rect.size.height);
    CGContextStrokeEllipseInRect(ctx, sRect);
}

- (void) moveToPoint:(CGFloat)x y:(CGFloat)y {
    CGContextMoveToPoint(ctx, x, y);
}

- (void) addLineToPoint:(CGFloat)x y:(CGFloat)y {
    CGContextAddLineToPoint(ctx, x, y);
}

- (void) moveToPoint:(CGPoint)point {
    CGContextMoveToPoint(ctx, point.x, point.y);
}

- (void) addElipseToPath:(CGRect)rect {
    CGContextAddEllipseInRect(ctx, rect);
}

- (void) strokePath {
    CGContextStrokePath(ctx);
}

- (UIImage*) image {
    return UIGraphicsGetImageFromCurrentImageContext();
}

- (void) dealloc {
    UIGraphicsEndImageContext();
}

@end
