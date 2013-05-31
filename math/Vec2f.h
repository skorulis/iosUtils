//
//  Vec2f.h
//  nodewar
//
//  Created by Alex Skorulis on 26/02/12.
//  Copyright (c) 2012 Skorulis.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Vec2f : NSObject

@property double x;
@property double y;

+ (Vec2f*) vec:(double)x y:(double)y;
- (id) initWithX:(double)x y:(double)y;
- (Vec2f*) addE:(Vec2f*)vec mult:(double)mult;
- (double) len;
- (double) dist:(Vec2f*)v;
- (double) dist:(double)x y:(double)y;
- (Vec2f*) minus:(Vec2f*)v;
- (Vec2f*) normaliseE;
- (Vec2f*) multE:(double)val;
- (Vec2f*) clampE:(double)max;

@end
