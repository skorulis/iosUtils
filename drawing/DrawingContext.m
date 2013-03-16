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
    
    DrawingContext* dc = [DrawingContext new];
    dc.scale = [[UIScreen mainScreen] scale];
    size.height*=dc.scale; size.width*=dc.scale;
    UIGraphicsBeginImageContext(size);
    dc.ctx = UIGraphicsGetCurrentContext();
    
    return dc;
}

- (void) setFillColor:(UIColor *)fillColor {
    CGContextSetFillColorWithColor(self.ctx, fillColor.CGColor);
}

- (void) setLineWidth:(CGFloat)width {
    CGContextSetLineWidth(ctx, width*self.scale);
}

- (UIImage*) image {
    return UIGraphicsGetImageFromCurrentImageContext();
}

- (void) dealloc {
    UIGraphicsEndImageContext();
}

@end
