//
//  IdListMap.h
//  robin
//
//  Created by Alex Skorulis on 10/05/2013.
//  Copyright (c) 2013 Alex Skorulis. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface IdListMap : NSObject

@property (nonatomic, readonly) NSUInteger sectionCount;
@property (nonatomic, strong) NSMutableDictionary* idMap;

- (id)initWithSectionCount:(int)sections;

- (NSArray*) nextMissingIds:(int)count section:(int)section;

- (NSUInteger)countForSection:(int)section;
- (id)itemAtIndexPath:(NSIndexPath*)indexPath;
- (void) setListForSection:(int)section ids:(NSArray*)ids;
- (BOOL) hasId:(id)identifer inSection:(int)section;
- (NSArray*)idsForSection:(int)section;
- (int) indexOfId:(id)i section:(int)section;
- (void) removeId:(id)i fromSection:(int)section;
- (void) addId:(id)i inSection:(int)section;

@end
