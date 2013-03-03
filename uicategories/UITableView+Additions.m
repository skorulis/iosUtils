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

@end
