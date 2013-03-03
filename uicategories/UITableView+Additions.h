//
//  UITableView+Additions.h
//  robin
//
//  Created by Alex Skorulis on 02/03/2013.
//  Copyright (c) 2013 Alex Skorulis. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITableView (Additions)

- (void) registerDefaultNibForClass:(Class)c;
- (UITableViewCell*) dequeueDefaultCellForClass:(Class)c indexPath:(NSIndexPath*)indexPath;

@end
