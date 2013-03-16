//
//  DrawingContext.h
//  robin
//
//  Created by Alex Skorulis on 16/03/2013.
//  Copyright (c) 2013 Alex Skorulis. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DrawingContext : NSObject

@property (nonatomic, readonly) CGFloat scale;
@property (nonatomic, readonly) CGContextRef ctx;
@property (nonatomic, readonly) CGSize size;

+ (DrawingContext*) getContext:(CGSize)size;
- (UIImage*) image;
- (void) setFillColor:(UIColor *)fillColor;
- (void) setLineWidth:(CGFloat)width;
- (void) strokeElipse:(CGRect)rect;

@end
