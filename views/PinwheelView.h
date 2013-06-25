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
- (void) pinwheel:(PinwheelView*)pinwheel didSelectPin:(int)pin;
- (void) pinwheel:(PinwheelView*)pinwheel didRotateToPin:(int)pin;

@end

@interface PinwheelView : UIView

//Distance a pin sits from the outside edge
@property (nonatomic, assign) CGFloat edgeDistance;

@property (nonatomic, weak) id<PinwheelViewDelegate> delegate;

- (void) rotateToPin:(int)pin;
- (void) setBackgroundImage:(UIImage*)image;
- (void) reload;

@end
