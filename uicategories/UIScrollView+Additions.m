//
//  UIScrollView+Additions.m
//  phringly
//
//  Created by Alex Skorulis on 31/07/2013.
//  Copyright (c) 2013 Skorulis.com. All rights reserved.
//

#import "UIScrollView+Additions.h"

@implementation UIScrollView (Additions)

- (float) zoomLevelToFitContent {
    float zoom = MIN(self.width/self.contentSize.width,self.height/self.contentSize.height);
    return zoom;
}

- (float) zoomLevelToFillContent {
    float zoom = MAX(self.width/self.contentSize.width,self.height/self.contentSize.height);
    return MIN(zoom, 1);
}

- (void) setZoomToFitContent {
    self.minimumZoomScale = [self zoomLevelToFitContent];
    self.maximumZoomScale = 1;
}

@end
