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

- (void) reload;

- (id) initWithTableView:(UITableView*)tableView;

@end
