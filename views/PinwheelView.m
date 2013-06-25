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
#import "Rotateable.h"

@interface PinwheelView ()

@property (nonatomic, strong) UIImageView* rotatingView;
@property (nonatomic, strong) UIPanGestureRecognizer* panGesture;
@property (nonatomic, strong) Rotateable* rotateInfo;

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
    self.edgeDistance = 30;
    self.startAngle = -M_PI/2;
    self.ringWidth = -1;
}

- (void) setupViews {
    self.rotateInfo = [Rotateable new];
    self.rotatingView = [[UIImageView alloc] initWithFrame:self.bounds];
    self.panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panned:)];
    [self addGestureRecognizer:self.panGesture];
    [self addSubview:self.rotatingView];
}

- (void) panned:(UIPanGestureRecognizer*)pan {
    CGPoint loc = [pan locationInView:self];
    //CGPoint vel = [pan velocityInView:self];
    if(pan.state == UIGestureRecognizerStateChanged) {
        CGPoint dir = [CGPointMath point:loc minus:self.center];
        CGFloat rot = [CGPointMath rotation:dir];
        self.rotatingView.transform = CGAffineTransformMakeRotation(rot);
        
        [self.rotateInfo update:rot];
        self.rotatingView.transform = CGAffineTransformMakeRotation(self.rotateInfo.rotation);
    } else if(pan.state == UIGestureRecognizerStateEnded || pan.state == UIGestureRecognizerStateCancelled) {
        [self.rotateInfo end];
    }
}

- (void) setFrame:(CGRect)frame {
    NSAssert(frame.size.width == frame.size.height, @"Pinwheel width and height must match");
    [super setFrame:frame];
}

- (void) setBackgroundImage:(UIImage*)image {
    self.rotatingView.image = image;
}

- (UIImage*) backgroundImage {
    return self.rotatingView.image;
}

- (void) rotateToPin:(int)pin {
    
}

- (void) reload {
    int pins = [self.delegate numberOfPins:self];
    float angleDelta = 2*M_PI / pins;
    float len = self.width/2 - self.edgeDistance;
    CGPoint c = CGPointMake(self.width/2, self.height/2);
    for(int i=0; i < pins; ++i) {
        float angle = angleDelta*i + self.startAngle;
        UIView* v = [self.delegate pinwheel:self viewForPin:i];
        UIView* holder = [[UIView alloc] initWithFrame:v.bounds];
        CGPoint p = [CGPointMath pointFromAngle:angle];
        p = [CGPointMath mult:p scalar:len];
        p = [CGPointMath add:c p2:p];
        holder.center = [CGPointMath round:p];
        [holder addSubview:v];
        NSLog(@"P %@",NSStringFromCGPoint(holder.center));
        v.transform = CGAffineTransformMakeRotation(angle + M_PI/2);
        
        [self.rotatingView addSubview:holder];
    }
}

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    CGPoint cp = CGPointMake(self.width/2, self.width/2);
    float dist = [CGPointMath dist:cp p2:point];
    NSLog(@"DIST %f %@",dist,NSStringFromCGRect(self.frame));
    if(dist > self.width/2) {
        return nil;
    } else if(self.ringWidth > 0 &&  dist < self.width/2 - self.ringWidth) {
        return nil;
    }
    return self;
}

@end