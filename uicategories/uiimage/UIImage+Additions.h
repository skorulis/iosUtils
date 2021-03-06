//
//  UIImage+Additions.h
//  robin
//
//  Created by Alex Skorulis on 8/05/13.
//  Copyright (c) 2013 Alex Skorulis. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Additions)

- (UIImage*) fullStretchable;
+ (UIImage *) imageWithView:(UIView *)view;
+ (UIImage *) imageWithLayer:(CALayer*)layer;
- (UIImage *) cropToCentreSquare;
- (UIImage*) cropToRect:(CGRect)rect;
- (UIImage *)fixOrientation;
- (CGRect) centreSquare;

@end
