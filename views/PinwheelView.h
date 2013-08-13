//
//  PinwheelView.h
//  phringly
//
//  Created by Alex Skorulis on 25/06/2013.
//  Copyright (c) 2013 Skorulis.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PinwheelView;

@protocol PinwheelViewDelegate <NSObject>

- (int) numberOfPins:(PinwheelView*)pinwheel;
- (UIView*) pinwheel:(PinwheelView*)pinwheel viewForPin:(int)pin;


@optional

- (void) pinwheel:(PinwheelView*)pinwheel didSelectPin:(int)pin;
- (void) pinwheel:(PinwheelView*)pinwheel willRotateToPin:(int)pin;
- (void) pinwheel:(PinwheelView*)pinwheel didRotateToPin:(int)pin;
- (void) pinwheel:(PinwheelView*)pinwheel didRotate:(float)angle;

@end

@interface PinwheelView : UIView

//Distance a pin sits from the outside edge
@property (nonatomic, assign) CGFloat edgeDistance;
@property (nonatomic, assign) CGFloat ringWidth;
@property (nonatomic, assign) CGFloat startAngle;
@property (nonatomic, assign) CGFloat minimumTapMult;
@property (nonatomic, assign) CGFloat fadeSpeed;
@property (nonatomic, assign) NSTimeInterval animationSpeed;

@property (nonatomic, weak) id<PinwheelViewDelegate> delegate;
@property (nonatomic, strong) UIImage* backgroundImage;
@property (nonatomic, readonly, assign) int currentPin;

- (void) rotateToPin:(int)pin animated:(BOOL)animated;
- (int) distanceToPin:(int)pin;
- (void) reload;
- (float) pctActive;

@end
