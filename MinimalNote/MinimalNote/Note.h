//
//  Note.h
//  MinimalNote
//
//  Created by Carl Li on 5/4/15.
//  Copyright (c) 2015 Carl Li. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Tag.h"

@interface Note : NSObject
@property NSInteger nid;
@property NSString* title;
@property NSString* content;
@property NSDate* create_time;
@property NSDate* modify_time;
@property BOOL deleted;
@property NSInteger tag;

@property BOOL checked;

- (Tag*)getTag;
@end
