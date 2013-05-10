//
//  IdListMap.m
//  robin
//
//  Created by Alex Skorulis on 10/05/2013.
//  Copyright (c) 2013 Alex Skorulis. All rights reserved.
//

#import "IdListMap.h"

@interface IdListMap () {
    NSMutableArray* lists;
}



@end

@implementation IdListMap


- (id)initWithSectionCount:(int)sections {
    self = [super init];
    _sectionCount = sections;
    return [self commonInit];
}

- (id) init {
    self = [super init];
    _sectionCount = 1;
    return [self commonInit];
}

- (IdListMap*) commonInit {
    self.idMap = [NSMutableDictionary new];
    lists = [NSMutableArray new];
    for(int i=0; i < _sectionCount; ++i) {
        [lists addObject:[NSMutableArray new]];
    }
    return self;
}

- (NSArray*) nextMissingIds:(int)count section:(int)section {
    NSMutableArray* ret = [NSMutableArray new];
    NSArray* idList = lists[section];
    for(NSNumber* n in idList) {
        if(self.idMap[n] == nil) {
            [ret addObject:n];
            if(ret.count >=count) {
                break;
            }
        }
    }
    return ret;
}

- (NSUInteger)countForSection:(int)section {
    return  ((NSArray*)lists[section]).count;
}

- (id)itemAtIndexPath:(NSIndexPath*)indexPath {
    NSArray* items = lists[indexPath.section];
    return self.idMap[items[indexPath.row]];
}

- (void) setListForSection:(int)section ids:(NSArray*)ids {
    NSMutableArray* a = lists[section];
    [a removeAllObjects];
    [a addObjectsFromArray:ids];
}

- (BOOL) hasId:(id)identifer inSection:(int)section {
    NSArray* items = lists[section];
    for(id item in items) {
        if([item isEqual:identifer]) {
            return TRUE;
        }
    }
    return FALSE;
}

- (NSArray*)idsForSection:(int)section {
    return lists[section];
}

- (int) indexOfId:(id)i section:(int)section {
    NSArray* list = lists[section];
    return [list indexOfObject:i];
}

- (void) removeId:(id)i fromSection:(int)section {
    NSMutableArray* list = lists[section];
    [list removeObject:i];
}

- (void) addId:(id)i inSection:(int)section {
    NSMutableArray* list = lists[section];
    [list addObject:i];
}

@end
