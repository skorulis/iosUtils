//
//  PullUpTabView.h
//  pulltest
//
//  Created by Alex Skorulis on 14/05/2013.
//  Copyright (c) 2013 Thomson Reuters. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PullUpTabView;

@protocol PullUpTabDelegate <NSObject>

- (UIView*) pullUpTabViewContent:(PullUpTabView*)pullUp;
- (UIView*) pullUpTabViewHandle:(PullUpTabView*)pullUp;
- (UIView*) pullUpTabViewSpinningHandle:(PullUpTabView*)pullUp;

@end

@interface PullUpTabView : UIView

@property (nonatomic, strong) id<PullUpTabDelegate> delegate;

- (void) reload;
- (void) toggleState;

@end
