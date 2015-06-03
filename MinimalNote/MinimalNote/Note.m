//
//  Note.m
//  MinimalNote
//
//  Created by Carl Li on 5/4/15.
//  Copyright (c) 2015 Carl Li. All rights reserved.
//

#import "Note.h"
#import "NoteManager.h"

@implementation Note{
    Tag* mTag;
}

- (Tag*)getTag{
    if (!mTag || mTag.nid != _tag) {
        mTag = [[NoteManager sharedInstance] getTagById:_tag];
    }
    return mTag;
}

@end
