//
//  DrawingContext.h
//  robin
//
//  Created by Alex Skorulis on 16/03/2013.
//  Copyright (c) 2013 Alex Skorulis. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DrawingContext : NSObject

@property (nonatomic, assign) CGFloat scale;
@property (nonatomic, assign) CGContextRef ctx;

+ (DrawingContext*) getContext:(CGSize)size;
- (UIImage*) image;
- (void) setFillColor:(UIColor *)fillColor;
- (void) setLineWidth:(CGFloat)width;

@end
