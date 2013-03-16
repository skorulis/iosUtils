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
@synthesize scale = scale;

+ (DrawingContext*) getContext:(CGSize)size {
    return [[DrawingContext alloc] initWithSize:size];
}

- (id) initWithSize:(CGSize)size {
    self = [super init];
    scale = [[UIScreen mainScreen] scale];
    UIGraphicsBeginImageContext(CGSizeMake(size.width*scale, size.height*scale));
    ctx = UIGraphicsGetCurrentContext();
    _size = size;
    return self;
}

- (void) setFillColor:(UIColor *)fillColor {
    CGContextSetFillColorWithColor(self.ctx, fillColor.CGColor);
}

- (void) setLineWidth:(CGFloat)width {
    CGContextSetLineWidth(ctx, width*self.scale);
}

- (void) strokeElipse:(CGRect)rect {
    CGRect sRect = CGRectMake(rect.origin.x*scale, rect.origin.y*scale, rect.size.width*scale, rect.size.height*scale);
    CGContextStrokeEllipseInRect(ctx, sRect);
}

- (UIImage*) image {
    return UIGraphicsGetImageFromCurrentImageContext();
}

- (void) dealloc {
    UIGraphicsEndImageContext();
}

@end
