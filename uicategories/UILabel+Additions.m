//
//  UILabel+Additions.m
//  robin
//
//  Created by Alex Skorulis on 30/05/2013.
//  Copyright (c) 2013 Alex Skorulis. All rights reserved.
//

#import "UILabel+Additions.h"

@implementation UILabel (Additions)

- (CGFloat) verticalSize {
    CGSize constraint = CGSizeMake(self.frame.size.width, 10000);
    CGSize ret =[self.text sizeWithFont:self.font constrainedToSize:constraint lineBreakMode:self.lineBreakMode];
    return ret.height;
}

@end
