//
//  PullOutTabView.h
//  phringly
//
//  Created by Alex Skorulis on 06/06/2013.
//  Copyright (c) 2013 Skorulis.com. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    kPullOutTabBottom,
    kPullOutTabTop,
    kPullOutTabLeft,
    kPullOutTabRight
    
} PullOutTabDirection;

@class PullOutTabView;

@protocol PullOutTabDelegate <NSObject>

- (UIView*) pullUpTabViewContent:(PullOutTabView*)pullUp;
- (UIView*) pullUpTabViewHandle:(PullOutTabView*)pullUp;
- (UIView*) pullUpTabViewSpinningHandle:(PullOutTabView*)pullUp;
- (void) pullUpTabStateChanged:(PullOutTabView*)pullUp;

@end


@interface PullOutTabView : UIView

@property (nonatomic, assign) PullOutTabDirection direction;
@property (nonatomic, strong) id<PullOutTabDelegate> delegate;
@property (nonatomic, assign) BOOL tabOpen;

- (void) reload;
- (void) toggleState;

@end
