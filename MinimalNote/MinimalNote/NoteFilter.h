//
//  NoteFilter.h
//  MinimalNote
//
//  Created by Carl Li on 6/11/15.
//  Copyright (c) 2015 Carl Li. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Tag.h"

#define TYPE_ALL 1
#define TYPE_TRASH 2
#define TYPE_TAG 10

@interface NoteFilter : NSObject
@property NSInteger type;
@property Tag* tag;
@end
