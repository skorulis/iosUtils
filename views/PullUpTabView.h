//
//  PullUpTabView.h
//  pulltest
//
//  Created by Alex Skorulis on 14/05/2013.
//  Copyright (c) 2013 Skorulis.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PullUpTabView;

typedef enum {
    kPullUpTabBottom,
    kPullUpTabTop,
    kPullUpTabLeft,
    kPullUpTabRight
    
} PullUpTabDirection;

@protocol PullUpTabDelegate <NSObject>

- (UIView*) pullUpTabViewContent:(PullUpTabView*)pullUp;
- (UIView*) pullUpTabViewHandle:(PullUpTabView*)pullUp;
- (UIView*) pullUpTabViewSpinningHandle:(PullUpTabView*)pullUp;

@end

@interface PullUpTabView : UIView

@property (nonatomic, assign) PullUpTabDirection direction;
@property (nonatomic, strong) id<PullUpTabDelegate> delegate;

- (void) reload;
- (void) toggleState;

@end
