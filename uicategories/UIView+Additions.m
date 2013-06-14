//
//  UIView+Additions.m
//  robin
//
//  Created by Alex Skorulis on 14/03/2013.
//  Copyright (c) 2013 Alex Skorulis. All rights reserved.
//

#import "UIView+Additions.h"
#import <QuartzCore/QuartzCore.h>

@implementation UIView (Additions)

@dynamic bottom;
@dynamic right;
@dynamic x;
@dynamic y;
@dynamic width;
@dynamic height;

- (CGFloat) x
{
	return [self frame].origin.x;
}

- (void) setX: (CGFloat) x
{
	CGRect rect = [self frame];
	rect.origin.x = x;
	[self setFrame:rect];
}

- (CGFloat) y
{
	return [self frame].origin.y;
}

- (void) setY: (CGFloat) y
{
	CGRect rect = [self frame];
	rect.origin.y = y;
	[self setFrame:rect];
}

- (CGFloat) width {
	return [self frame].size.width;
}

- (void) setWidth: (CGFloat) width {
	CGRect rect = [self frame];
	rect.size.width = width;
	[self setFrame:rect];
}

- (CGFloat) height {
	return [self frame].size.height;
}

- (void) setHeight: (CGFloat) height {
	CGRect rect = [self frame];
	rect.size.height = height;
	[self setFrame:rect];
}

- (CGSize) size {
    return self.frame.size;
}

- (void) setSize:(CGSize)size {
    CGRect rect = [self frame];
    rect.size = size;
    [self setFrame:rect];
}

- (void) centerInParentRounded {
	self.x =roundf( (self.superview.width  - self.width)  / 2.0f);
	self.y =roundf( (self.superview.height - self.height) / 2.0f);
}

- (void) centerInParentVerticalRounded {
	self.y = roundf((self.superview.height - self.height) / 2.0f);
}

- (void) centerInParentHorizontalRounded {
	self.x =roundf( (self.superview.width  - self.width)  / 2.0f);
}

- (CGFloat) bottom {
	return self.y + self.height;
}

- (CGFloat) right {
    return self.x + self.width;
}

- (UIImage *) renderImage {
    UIGraphicsBeginImageContextWithOptions(self.bounds.size, self.opaque, 0.0);
    [self.layer renderInContext:UIGraphicsGetCurrentContext()];
    
    UIImage * img = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return img;
}

@end
