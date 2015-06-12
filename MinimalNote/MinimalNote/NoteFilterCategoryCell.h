//
//  NoteFilterCategoryCell.h
//  MinimalNote
//
//  Created by Carl Li on 6/10/15.
//  Copyright (c) 2015 Carl Li. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Tag.h"

@interface NoteFilterCategoryCell : UITableViewCell

- (void)setTitle:(NSString*)title icon:(UIImage*)image;
- (void)setTag:(Tag*) tag;
@end
