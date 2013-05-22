//
//  FixedTableViewProxy.m
//  robin
//
//  Created by Alex Skorulis on 22/05/2013.
//  Copyright (c) 2013 Alex Skorulis. All rights reserved.
//

#import "FixedTableViewProxy.h"

@implementation FixedTableViewProxy

- (int) numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (int) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.dataSource tableView:tableView numberOfRowsInSection:section];
}

- (NSString*) tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return [self.dataSource tableView:tableView titleForHeaderInSection:section];
}

- (CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return [self.delegate tableView:tableView heightForHeaderInSection:section];
}

- (UIView*) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return [self.delegate tableView:tableView viewForHeaderInSection:section];
}

- (UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [self.dataSource tableView:tableView cellForRowAtIndexPath:indexPath];
}

- (void) tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

- (void) tableView:(UITableView *)tableView willDisplayFooterView:(UIView *)view forSection:(NSInteger)section {
    
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.delegate tableView:tableView didSelectRowAtIndexPath:indexPath];
}

@end
