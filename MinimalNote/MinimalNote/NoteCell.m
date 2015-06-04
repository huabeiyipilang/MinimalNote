//
//  NoteCell.m
//  MinimalNote
//
//  Created by Carl Li on 5/4/15.
//  Copyright (c) 2015 Carl Li. All rights reserved.
//

#import "NoteCell.h"
#import "UIColor+HexString.h"

@implementation NoteCell{
    
    IBOutlet UILabel *titleView;
    IBOutlet UILabel *createTimeView;
    IBOutlet UIView *tagColorView;
    IBOutlet UIImageView *checkView;
    BOOL mCheckMode;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setCheckMode:(BOOL)checkMode{
    mCheckMode = checkMode;
    checkView.hidden = !mCheckMode;
}

- (void)setChecked:(BOOL)checked{
    [checkView setImage:[UIImage imageNamed:checked ? @"icon_checked" : @"icon_unchecked"]];
}

- (void)bindData:(Note*)note{
    titleView.text = note.content;
    NSDateFormatter* formater = [[NSDateFormatter alloc]init];
    [formater setDateFormat:@"yyyy/MM/dd hh:mm"];
    createTimeView.text = [formater stringFromDate:note.modify_time];
    tagColorView.backgroundColor = [UIColor colorWithHexString:[note getTag].color];
    [checkView setImage:[UIImage imageNamed:note.checked ? @"icon_checked" : @"icon_unchecked"]];
}

@end
