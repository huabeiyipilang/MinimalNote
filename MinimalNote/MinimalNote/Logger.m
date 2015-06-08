//
//  Logger.m
//  MinimalNote
//
//  Created by Carl Li on 6/8/15.
//  Copyright (c) 2015 Carl Li. All rights reserved.
//

#import "Logger.h"

#define DEBUG_ENABLE YES

@implementation Logger

+ (void)log:(NSString*) log{
    if (DEBUG_ENABLE) {
        NSLog(log, nil);
    }
}

@end
