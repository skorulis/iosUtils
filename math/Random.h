//
//  Random.h
//  albatross
//
//  Created by Alex Skorulis on 13/11/12.
//
//

#import <Foundation/Foundation.h>
#define ARC4RANDOM_MAX      0x100000000

double randD();
double randDM(double max);

@interface Random : NSObject

+ (double)randD;


@end
