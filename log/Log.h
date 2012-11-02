//
//  Log.h
//  albatross
//
//  Created by Alex Skorulis on 01/11/2012.
//
//

#import <Foundation/Foundation.h>

#ifdef DEBUG
#	define DLog(fmt, ...) NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);
#else
#	define DLog(...)
#endif

@interface Log : NSObject

@end
