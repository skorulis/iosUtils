//
//  UIImage+Additions.m
//  robin
//
//  Created by Alex Skorulis on 8/05/13.
//  Copyright (c) 2013 Alex Skorulis. All rights reserved.
//

#import "UIImage+Additions.h"

@implementation UIImage (Additions)

- (UIImage*) fullStretchable {
    int midX = self.size.width/2;
    int midY = self.size.height/2;
    return [self resizableImageWithCapInsets:UIEdgeInsetsMake(midY, midX, midY, midX)];
}

@end
