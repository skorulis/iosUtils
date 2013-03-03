//
//  UILocker.m
//  robin
//
//  Created by Alex Skorulis on 03/03/2013.
//  Copyright (c) 2013 Alex Skorulis. All rights reserved.
//

#import "UILocker.h"

@implementation UILocker

- (id)initWithFrame:(CGRect)frame {
    return [self = [super initWithFrame:frame] commonInit];
}

- (id) initWithCoder:(NSCoder *)aDecoder {
    return [self = [super initWithCoder:aDecoder] commonInit];
}

- (id) commonInit {
    return self;
}

@end
