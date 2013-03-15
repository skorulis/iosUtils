//
//  UILocker.h
//  robin
//
//  Created by Alex Skorulis on 03/03/2013.
//  Copyright (c) 2013 Alex Skorulis. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    kUILockerStateLoading = 0,
    kUILockerStateEmpty = 1,
    kUILockerStateNormal = 2,
    kUILockerStateError = 3
    
} UILockerState;

@interface UILocker : UIView

@property (nonatomic, weak) UIView* target;
@property (nonatomic, strong) UILabel* label;
@property (nonatomic, strong) UIActivityIndicatorView* activity;
@property (nonatomic, assign) UILockerState state;

@property (nonatomic, strong) NSString* emptyString;
@property (nonatomic, strong) NSString* errorString;

@property (nonatomic, strong) UIButton* retryButton;

@property (nonatomic, copy) void (^retryBlock)(void);

+ (UILocker*) lockView:(UIView*)view state:(UILockerState)state;

+ (void) setDefaultFont:(UIFont*)font;



@end
