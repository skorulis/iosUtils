//
//  PinwheelView.m
//  phringly
//
//  Created by Alex Skorulis on 25/06/2013.
//  Copyright (c) 2013 Skorulis.com. All rights reserved.
//

#import "PinwheelView.h"
#import "CGPointMath.h"
#import "UIView+Additions.h"

@interface PinwheelView ()

@property (nonatomic, strong) UIImageView* rotatingView;

@end

@implementation PinwheelView

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    [self setDefaultValues];
    [self setupViews];
    return self;
}

- (void) awakeFromNib {
    [super awakeFromNib];
    [self setDefaultValues];
    [self setupViews];
}

- (void) setDefaultValues {
    self.edgeDistance = 10;
}

- (void) setupViews {
    self.rotatingView = [[UIImageView alloc] initWithFrame:self.bounds];
    [self addSubview:self.rotatingView];
}

- (void) setFrame:(CGRect)frame {
    NSAssert(frame.size.width == frame.size.height, @"Pinwheel width and height must match");
    [super setFrame:frame];
}

- (void) setBackgroundImage:(UIImage*)image {
    self.rotatingView.image = image;
}

- (void) rotateToPin:(int)pin {
    
}

- (void) reload {
    int pins = [self.delegate numberOfPins:self];
    float angleDelta = 2*M_PI / pins;
    float len = self.width/2 - self.edgeDistance;
    CGPoint c = CGPointMake(self.width/2, self.height/2);
    for(int i=0; i < pins; ++i) {
        UIView* v = [self.delegate pinwheel:self viewForPin:i];
        CGPoint p = [CGPointMath pointFromAngle:angleDelta];
        p = [CGPointMath mult:p scalar:len];
        p = [CGPointMath add:c p2:p];
        v.center = p;
        [self.rotatingView addSubview:v];
    }
}

@end
