//
//  UITableView+Additions.m
//  robin
//
//  Created by Alex Skorulis on 02/03/2013.
//  Copyright (c) 2013 Alex Skorulis. All rights reserved.
//

#import "UITableView+Additions.h"

@implementation UITableView (Additions)

- (void) registerDefaultNibForClass:(Class)c {
    [self registerNib:[UINib nibWithNibName:NSStringFromClass(c) bundle:nil] forCellReuseIdentifier:NSStringFromClass(c)];
}

- (UITableViewCell*) dequeueDefaultCellForClass:(Class)c indexPath:(NSIndexPath*)indexPath {
    return [self dequeueReusableCellWithIdentifier:NSStringFromClass(c) forIndexPath:indexPath];
}

- (void) animateEmptyInsert:(int)count withRowAnimation:(UITableViewRowAnimation)rowAnimation {
    [self beginUpdates];
    NSMutableArray* n = [NSMutableArray new];
    for(int i=0; i < count; ++i) {
        [n addObject:[NSIndexPath indexPathForRow:i inSection:0]];
    }
    [self insertRowsAtIndexPaths:n withRowAnimation:rowAnimation];
    [self endUpdates];
}

@end
