//
//  UIViewController+Additions.m
//  robin
//
//  Created by Alex Skorulis on 30/05/2013.
//  Copyright (c) 2013 Alex Skorulis. All rights reserved.
//

#import "UIViewController+Additions.h"

@implementation UIViewController (Additions)

- (void) addChildViewController:(UIViewController *)childViewController inSubView:(UIView *)subView {
    NSAssert(subView!=nil,@"Attempt to add child view controller into nil subview");
    NSAssert(childViewController!=nil,@"Attempt to add nil child view controller");
	
	childViewController.view.frame = subView.bounds;
	childViewController.view.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
	[self addChildViewController:childViewController];
	[subView addSubview:childViewController.view];
	[childViewController didMoveToParentViewController:self];
}

@end
