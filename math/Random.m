//
//  Random.m
//  albatross
//
//  Created by Alex Skorulis on 13/11/12.
//
//

#import "Random.h"

double randD() {
    return ((double)arc4random() / ARC4RANDOM_MAX);
}

double randDM(double max) {
    return (max*arc4random() / ARC4RANDOM_MAX);
}

@implementation Random

+ (double) randD {
    return ((double)arc4random() / ARC4RANDOM_MAX);
}

@end
