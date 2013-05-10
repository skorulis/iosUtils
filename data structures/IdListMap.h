//
//  IdListMap.h
//  robin
//
//  Created by Alex Skorulis on 10/05/2013.
//  Copyright (c) 2013 Alex Skorulis. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface IdListMap : NSObject

@property (nonatomic, strong) NSArray* idList;
@property (nonatomic, strong) NSMutableDictionary* idMap;

@property (nonatomic, readonly) NSUInteger count;

- (NSArray*) nextMissingIds:(int)count;
- (id) itemAtRow:(int)row;

@end
