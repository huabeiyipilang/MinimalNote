//
//  NoteCell.h
//  MinimalNote
//
//  Created by Carl Li on 5/4/15.
//  Copyright (c) 2015 Carl Li. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Note.h"

@interface NoteCell : UITableViewCell
- (void)bindData:(Note*)note;
@end
