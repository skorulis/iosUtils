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

@interface PinwheelView () {
    int pins;
    int currentPin;
    float angleDelta;
    float _minimumTapRads;
}

@property (nonatomic, strong) UIImageView* rotatingView;
@property (nonatomic, strong) UIPanGestureRecognizer* panGesture;
@property (nonatomic, strong) UITapGestureRecognizer* tapGesture;
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
    self.minimumTapMult = 0.2;
    self.fadeSpeed = 1.5f;
    self.animationSpeed = 0.5;
}

- (void) setupViews {
    self.rotateInfo = [Rotateable new];
    self.rotatingView = [[UIImageView alloc] initWithFrame:self.bounds];
    self.panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panned:)];
    [self addGestureRecognizer:self.panGesture];
    self.tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapped:)];
    [self addGestureRecognizer:self.tapGesture];
    
    [self addSubview:self.rotatingView];
}

- (void) tapped:(UITapGestureRecognizer*)tap {
    if(tap.state == UIGestureRecognizerStateRecognized) {
        CGPoint loc = [tap locationInView:self];
        CGPoint dir = [CGPointMath point:loc minus:self.center];
        CGFloat rot = [CGPointMath rotation:dir];
        CGFloat diff = (rot - self.startAngle);
        NSLog(@"Diff %f",diff);
        if(diff > _minimumTapRads) {
            [self rotateRight:TRUE];
        } else if(diff < -_minimumTapRads) {
            [self rotateLeft:TRUE];
        }
        //int pin = [self closestPin:self.rotateInfo.rotation+diff];
        //[self rotateToPin:pin animated:TRUE];
    }
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
        if([self.delegate respondsToSelector:@selector(pinwheel:didRotate:)]) {
            [self.delegate pinwheel:self didRotate:self.rotateInfo.rotation];
        }
    } else if(pan.state == UIGestureRecognizerStateEnded || pan.state == UIGestureRecognizerStateCancelled) {
        [self.rotateInfo end];
        int closest = [self closestPin:-self.rotateInfo.rotation];
        [self rotateToPin:closest animated:TRUE];
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

- (void) rotateToPin:(int)pin animated:(BOOL)animated {
    float duration = self.animationSpeed;
    if([self.delegate respondsToSelector:@selector(pinwheel:willRotateToPin:)]) {
        [self.delegate pinwheel:self willRotateToPin:pin];
    }
    [UIView animateWithDuration:duration animations:^{
        self.rotateInfo.rotation = -angleDelta*pin;
        self.rotatingView.transform = CGAffineTransformMakeRotation(self.rotateInfo.rotation);
    } completion:^(BOOL completion) {
        currentPin = pin;
        if([self.delegate respondsToSelector:@selector(pinwheel:didRotateToPin:)]) {
            [self.delegate pinwheel:self didRotateToPin:pin];
        }
    }];
    
}

- (void) rotateLeft:(BOOL)animated {
    int pin = currentPin - 1;
    if(pin < 0) {
        pin = pins - 1;
    }
    [self rotateToPin:pin animated:animated];
}

- (void) rotateRight:(BOOL)animated {
    int pin = currentPin + 1;
    if(pin >= pins) {
        pin = 0;
    }
    [self rotateToPin:pin animated:animated];
}

- (int) closestPin:(CGFloat)rot {
    CGFloat minDiff = INFINITY;
    CGFloat diff,angle;
    int ret = 0;
    for(int i=0; i < pins; ++i) {
        angle = angleDelta*i;
        diff = [PinwheelView normaliseRotation:(rot - angle)];
        NSLog(@"%f %f %f",diff,angle,rot);
        if(diff < minDiff) {
            ret = i;
            minDiff = diff;
        }
    }
    return ret;
}

+ (CGFloat) normaliseRotation:(CGFloat)rot {
    while(rot > M_PI*2) {
        rot -= M_PI*2;
    }
    while(rot < 0) {
        rot += M_PI*2;
    }
    
    return rot;
}

- (void) reload {
    pins = [self.delegate numberOfPins:self];
    angleDelta = 2*M_PI / pins;
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
        v.transform = CGAffineTransformMakeRotation(angle + M_PI/2);
        
        [self.rotatingView addSubview:holder];
    }
    _minimumTapRads = 2 * self.minimumTapMult * M_PI / pins;
}

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    CGPoint cp = CGPointMake(self.width/2, self.width/2);
    float dist = [CGPointMath dist:cp p2:point];
    if(dist > self.width/2) {
        return nil;
    } else if(self.ringWidth > 0 &&  dist < self.width/2 - self.ringWidth) {
        return nil;
    }
    return self;
}

- (float) pctActive {
    //int closest = [self closestPin:self.rotateInfo.rotation];
    float angle = angleDelta*currentPin;
    NSLog(@"Angle %f %f",angle,self.rotateInfo.rotation);
    float diff = [PinwheelView normaliseRotation:(-self.rotateInfo.rotation - angle)];
    diff = MIN(diff,M_PI*2 - diff);
    diff = (angleDelta - diff*self.fadeSpeed)/angleDelta;
    return MAX(diff,0);
}

@end
