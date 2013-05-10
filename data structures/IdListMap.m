//
//  IdListMap.m
//  robin
//
//  Created by Alex Skorulis on 10/05/2013.
//  Copyright (c) 2013 Alex Skorulis. All rights reserved.
//

#import "IdListMap.h"

@implementation IdListMap

@dynamic count;

- (id) init {
    self = [super init];
    self.idMap = [NSMutableDictionary new];
    self.idList = [NSArray new];
    return self;
}

- (NSArray*) nextMissingIds:(int)count {
    NSMutableArray* ret = [NSMutableArray new];
    for(NSNumber* n in self.idList) {
        if(self.idMap[n] == nil) {
            [ret addObject:n];
            if(ret.count >=count) {
                break;
            }
        }
    }
    return ret;
}

- (NSUInteger) count {
    return self.idList.count;
}

- (id) itemAtRow:(int)row {
    id itemId = self.idList[row];
    return self.idMap[itemId];
}

@end
