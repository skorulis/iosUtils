//
//  FixedTableViewProxy.h
//  robin
//
//  Created by Alex Skorulis on 22/05/2013.
//  Copyright (c) 2013 Alex Skorulis. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol TableProxyDelegate <UITableViewDataSource,UITableViewDelegate>

- (UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath realIndex:(NSIndexPath*)realPath;

@end

@interface FixedTableViewProxy : NSObject <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, weak) id<TableProxyDelegate> delegate;
@property (nonatomic, weak) UITableView* mainTableView;


- (id) initWithTableView:(UITableView*)tableView;
- (NSIndexPath*)deconvertIndexPath:(NSIndexPath*)indexPath;
- (void) buildCache;

//Table view methods

- (void) reloadData;
- (NSIndexPath*)indexPathForCell:(UITableViewCell*)cell;
- (void)insertRowsAtIndexPaths:(NSArray *)indexPaths withRowAnimation:(UITableViewRowAnimation)animation;
- (void)deleteRowsAtIndexPaths:(NSArray *)indexPaths withRowAnimation:(UITableViewRowAnimation)animation;
- (void)reloadRowsAtIndexPaths:(NSArray *)indexPaths withRowAnimation:(UITableViewRowAnimation)animation;

@end
