//
//  UIColor+Additions.m
//  Calzone
//
//  Created by Alex Skorulis on 07/02/2013.
//  Copyright (c) 2013 Alex Skorulis. All rights reserved.
//

#import "UIColor+Additions.h"



@implementation UIColor (Additions)

+ (UIColor*) randColor {
    float r = (float)rand() / RAND_MAX;
    float g = (float)rand() / RAND_MAX;
    float b = (float)rand() / RAND_MAX;
    return [UIColor colorWithHue:r saturation:g brightness:b alpha:1.0];
}

- (NSString*)rgbText {
    CGFloat red,green,blue,alpha;
    [self getRed:&red green:&green blue:&blue alpha:&alpha];
    return [NSString stringWithFormat:@"%f %f %f %f",red,green,blue,alpha];
}

@end
