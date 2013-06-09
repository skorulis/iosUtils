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
    if(self.size.height == self.size.width) { return self;}

    UIImage* tmp = [UIImage imageWithCGImage:self.CGImage];
    
    int min = MIN(tmp.size.width,tmp.size.height);
    double x = (tmp.size.width - min) / 2.0;
    double y = (tmp.size.height - min) / 2.0;
    
    CGRect cropRect = CGRectMake(x, y, min, min);
    CGImageRef imageRef = CGImageCreateWithImageInRect([tmp CGImage], cropRect);
    
    UIImage *cropped = [UIImage imageWithCGImage:imageRef scale:1.0 orientation:self.imageOrientation];
    CGImageRelease(imageRef);
    
    return cropped;
}

- (UIImage*) rotate90 {
    UIImage * ret = [[UIImage alloc] initWithCGImage:self.CGImage scale: 1.0 orientation: UIImageOrientationLeft];
    return ret;
    /*UIGraphicsBeginImageContext(self.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextRotateCTM (context, M_PI_2);
    
    UIImage* ret = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return ret;*/
}

@end
