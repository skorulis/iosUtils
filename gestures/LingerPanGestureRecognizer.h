//
//  LingerPanGestureRecognizer.h
//  phringly
//
//  Created by Alex Skorulis on 09/06/2013.
//  Copyright (c) 2013 Skorulis.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LingerPanGestureRecognizer;

@protocol LingerPanGestureRecognizerDelegate <UIGestureRecognizerDelegate>

@optional

- (void) gestureLingered:(LingerPanGestureRecognizer*)gesture touch:(UITouch*)touch;

@end

@interface LingerPanGestureRecognizer : UIPanGestureRecognizer

@property (nonatomic, assign) CGFloat lingerTime;

- (void) setDelegate:(id<LingerPanGestureRecognizerDelegate>)delegate;


@end
