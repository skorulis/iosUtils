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

- (int) hexValue {
    CGColorSpaceRef space = CGColorGetColorSpace(self.CGColor);
    size_t comps = CGColorSpaceGetNumberOfComponents(space);
    if(comps == 3) {
        return self.hexValueRGB;
    } else if(comps == 1) {
        return self.hexValueWhite;
    }
    NSAssert(FALSE,@"Unknown colour space %@",self);
    return 0;
}

- (int) hexValueWhite {
    CGFloat wf,af;
    [self getWhite:&wf alpha:&af];
    int w = wf*255;
    return (w << 16) + (w << 8) + w;
}

- (int) hexValueRGB {
    CGFloat rf,gf,bf,af;
    [self getRed:&rf green:&gf blue:&bf alpha:&af];
    int r,g,b;
    r = rf*255; g = gf*255; b = bf*255;
    return (r << 16) + (g << 8) + b;
}

@end
