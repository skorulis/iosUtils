//
//  FixedTableViewProxy.m
//  robin
//
//  Created by Alex Skorulis on 22/05/2013.
//  Copyright (c) 2013 Alex Skorulis. All rights reserved.
//

#import "FixedTableViewProxy.h"

@interface FixedTableViewProxy () {
    int sections;
    NSMutableArray* counts;
}

@end

@implementation FixedTableViewProxy

- (id) initWithTableView:(UITableView*)tableView {
    self = [super init];
    self.mainTableView = tableView;
    self.mainTableView.delegate = self;
    self.mainTableView.dataSource = self;
    return self;
}

- (void) buildCache {
    sections = [self.delegate numberOfSectionsInTableView:self.mainTableView];
    counts = [NSMutableArray new];
    for(int i=0; i < sections; ++i) {
        int rows = [self.delegate tableView:self.mainTableView numberOfRowsInSection:i];
        [counts addObject:@(rows)];
    }
}

- (int) numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSIndexPath* converted = [self convertIndexPath:indexPath];
    if(converted.length == 1) {
        int section = [converted indexAtPosition:0];
        return [self.delegate tableView:tableView heightForHeaderInSection:section];
    } else {
        return self.mainTableView.rowHeight;
    }
}

- (int) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    int total = 0;
    for(int i=0; i < sections; ++i) {
        NSNumber* n = counts[i];
        total+=n.intValue + 1;
    }
    
    return total;
}

- (NSString*) tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return nil;
}

- (CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0;
}

- (UIView*) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return nil;
}

- (UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSIndexPath* converted = [self convertIndexPath:indexPath];
    if(converted.length == 1) {
        return [self cellForHeaderInSection:[converted indexAtPosition:0]];
    } else {
        return [self.delegate tableView:tableView cellForRowAtIndexPath:converted realIndex:indexPath];
    }
    
    NSAssert(FALSE,@"Nothing to see for %@", indexPath);
    return nil;
}

- (void) tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

- (void) tableView:(UITableView *)tableView willDisplayFooterView:(UIView *)view forSection:(NSInteger)section {
    
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    indexPath = [self convertIndexPath:indexPath];
    if(indexPath.length == 2) {
        [self.delegate tableView:tableView didSelectRowAtIndexPath:indexPath];
    }
}

#pragma mark UITableView overrides

- (void) reloadData {
    [self buildCache];
    [self.mainTableView reloadData];
}

- (NSIndexPath*)indexPathForCell:(UITableViewCell*)cell {
    NSIndexPath* indexPath = [self.mainTableView indexPathForCell:cell];
    return [self convertIndexPath:indexPath];
}

- (void)insertRowsAtIndexPaths:(NSArray *)indexPaths withRowAnimation:(UITableViewRowAnimation)animation {
    NSMutableArray* paths = [NSMutableArray new];
    for(NSIndexPath* p in indexPaths) {
        [paths addObject:[self deconvertIndexPath:p]];
    }
    [self buildCache];
    [self.mainTableView insertRowsAtIndexPaths:paths withRowAnimation:animation];
    
}

- (void)deleteRowsAtIndexPaths:(NSArray *)indexPaths withRowAnimation:(UITableViewRowAnimation)animation {
    NSMutableArray* paths = [NSMutableArray new];
    for(NSIndexPath* p in indexPaths) {
        [paths addObject:[self deconvertIndexPath:p]];
    }
    [self buildCache];
    [self.mainTableView deleteRowsAtIndexPaths:paths withRowAnimation:animation];
}

- (void)reloadRowsAtIndexPaths:(NSArray *)indexPaths withRowAnimation:(UITableViewRowAnimation)animation {
    NSMutableArray* paths = [NSMutableArray new];
    for(NSIndexPath* p in indexPaths) {
        [paths addObject:[self deconvertIndexPath:p]];
        NSLog(@"Reload %@ for %@",p,[self deconvertIndexPath:p]);
    }
    [self buildCache];
    [self.mainTableView reloadRowsAtIndexPaths:paths withRowAnimation:animation];
}

#pragma mark helper methods

- (NSIndexPath*) convertIndexPath:(NSIndexPath*)indexPath {
    int remaining = indexPath.row;
    for(int i=0; i < sections; ++i) {
        if(remaining == 0) {
            return [NSIndexPath indexPathWithIndex:i];
        }
        remaining--;
        NSNumber* n = counts[i];
        if(remaining < n.intValue) {
            NSIndexPath* path = [NSIndexPath indexPathForRow:remaining inSection:i];
            return path;
        }
        remaining-=n.intValue;
    }
    return nil;
}

- (NSIndexPath*)deconvertIndexPath:(NSIndexPath*)indexPath {
    int row = 0;
    for(int i=0; i < indexPath.section; ++i) {
        NSNumber* n = counts[i];
        row+=(n.intValue + 1);
    }
    row+=(indexPath.row + 1);
    return [NSIndexPath indexPathForRow:row inSection:0];
}

- (UITableViewCell*)cellForHeaderInSection:(int)section {
    UIView* v = [self.delegate tableView:self.mainTableView viewForHeaderInSection:section];
    UITableViewCell* cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    [cell addSubview:v];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

@end
