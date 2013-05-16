//
//  UIView+Additions.h
//  robin
//
//  Created by Alex Skorulis on 14/03/2013.
//  Copyright (c) 2013 Alex Skorulis. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Additions)

@property (nonatomic, assign) CGFloat x;
@property (nonatomic, assign) CGFloat y;
@property (nonatomic, assign) CGFloat width;
@property (nonatomic, assign) CGFloat height;
@property (nonatomic, assign, readonly) CGFloat bottom;

- (void) centerInParentRounded;

- (void) centerInParentVerticalRounded;
- (void) centerInParentHorizontalRounded;

@end
