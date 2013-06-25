//
//  Rotateable.h
//  phringly
//
//  Created by Alex Skorulis on 25/06/2013.
//  Copyright (c) 2013 Skorulis.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Rotateable : NSObject

@property (nonatomic, assign) BOOL rotActive;
@property (nonatomic, assign) CGFloat lastRotAmount;
@property (nonatomic, assign) CGFloat lastRot;
@property (nonatomic, assign) NSTimeInterval lastRotTime;
@property (nonatomic, assign) CGFloat rotation;
@property (nonatomic, assign) CGFloat rotSpeed;

- (void) update:(CGFloat)rot;
- (void) end;

@end
