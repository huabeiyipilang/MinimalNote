//
//  NoteManager.h
//  MinimalNote
//
//  Created by Carl Li on 5/4/15.
//  Copyright (c) 2015 Carl Li. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Note.h"

@interface NoteManager : NSObject
+ (instancetype)sharedInstance;
- (BOOL)addNote:(Note*) note;
- (BOOL)updateNote:(Note*) note;
- (BOOL)deleteNote:(Note*) note;
- (NSMutableArray*)getAllNotesWithDeleted:(BOOL)all;
@end
