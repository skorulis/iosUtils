//
//  UIImage+Additions.m
//  robin
//
//  Created by Alex Skorulis on 8/05/13.
//  Copyright (c) 2013 Alex Skorulis. All rights reserved.
//

#import "UIImage+Additions.h"
#import <QuartzCore/QuartzCore.h>

@implementation UIImage (Additions)

- (UIImage*) fullStretchable {
    int midX = self.size.width/2;
    int midY = self.size.height/2;
    return [self resizableImageWithCapInsets:UIEdgeInsetsMake(midY, midX, midY, midX)];
}

+ (UIImage *) imageWithView:(UIView *)view {
    UIGraphicsBeginImageContextWithOptions(view.bounds.size, view.opaque, 0.0);
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    
    UIImage * img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return img;
}

+ (UIImage *) imageWithLayer:(CALayer*)layer {
    UIGraphicsBeginImageContextWithOptions(layer.bounds.size, layer.opaque, 0.0);
    [layer renderInContext:UIGraphicsGetCurrentContext()];
    
    UIImage * img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return img;
}

- (UIImage *) cropToCentreSquare {
    int min = MIN(self.size.width,self.size.height);
    double x = (self.size.width - min) / 2.0;
    double y = (self.size.height - min) / 2.0;
    
    CGRect cropRect = CGRectMake(x, y, min, min);
    CGImageRef imageRef = CGImageCreateWithImageInRect([self CGImage], cropRect);
    
    UIImage *cropped = [UIImage imageWithCGImage:imageRef];
    CGImageRelease(imageRef);
    
    return cropped;
}

@end
