//
//  UIScrollView+Additions.h
//  phringly
//
//  Created by Alex Skorulis on 31/07/2013.
//  Copyright (c) 2013 Skorulis.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIView+Additions.h"

@interface UIScrollView (Additions)

- (float) zoomLevelToFitContent;
- (float) zoomLevelToFillContent;
- (void) setZoomToFitContent;

@end
