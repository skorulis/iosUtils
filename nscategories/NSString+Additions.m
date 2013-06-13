//
//  NSString+Additions.m
//  phringly
//
//  Created by Alex Skorulis on 13/06/13.
//  Copyright (c) 2013 Skorulis.com. All rights reserved.
//

#import "NSString+Additions.h"

@implementation NSString (Additions)

- (NSAttributedString*)attributedStringWithKerning:(float)kerning {
    NSDictionary* atts = @{NSKernAttributeName : @(kerning)};
    return [[NSAttributedString alloc] initWithString:self attributes:atts];
}

@end
