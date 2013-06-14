//
//  Delta.h
//  phringly
//
//  Created by Alex Skorulis on 14/06/2013.
//  Copyright (c) 2013 Skorulis.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Delta : NSObject

@property (nonatomic, readonly) double currentDelta;
@property (nonatomic, assign) double maxDelta;

- (double) generateDelta;

@end
