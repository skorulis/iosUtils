//
//  FixedTableViewProxy.h
//  robin
//
//  Created by Alex Skorulis on 22/05/2013.
//  Copyright (c) 2013 Alex Skorulis. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FixedTableViewProxy : NSObject <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, weak) id<UITableViewDataSource> dataSource;
@property (nonatomic, weak) id<UITableViewDelegate> delegate;

@end
