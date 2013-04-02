//
//  UIColor+Additions.h
//  Calzone
//
//  Created by Alex Skorulis on 07/02/2013.
//  Copyright (c) 2013 Alex Skorulis. All rights reserved.
//

#import <UIKit/UIKit.h>

#define CGColorFromRGB(r, g, b, a) [[UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a] CGColor]
#define CGColorFromHexRGB(rgbValue, a) [[UIColor \
colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0xFF))/255.0 alpha:a] CGColor]
#define UIColorFromHexRGB(rgbValue, a) [UIColor \
colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0xFF))/255.0 alpha:a]
#define UIColorFromRGB(r, g, b, a) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]

@interface UIColor (Additions)

+ (UIColor*) randColor;

- (NSString*)rgbText;

@end
