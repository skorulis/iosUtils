//
//  PanningTableViewCell.h
//  robin
//
//  Created by Alex Skorulis on 26/04/2013.
//  Copyright (c) 2013 Alex Skorulis. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PanningTableViewCell;

@protocol PanningTableViewCellDelegate <NSObject>

- (void) cellDidPanRight:(PanningTableViewCell*)cell;
- (void) cellDidPanLeft:(PanningTableViewCell*)cell;

@end

@interface PanningTableViewCell : UITableViewCell

@property (nonatomic, assign) CGFloat maxTranslation;
@property (nonatomic, assign) CGFloat triggerPadding;
@property (nonatomic, weak) id<PanningTableViewCellDelegate> panDelegate;


@end
