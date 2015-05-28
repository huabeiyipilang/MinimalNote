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
    IBOutlet UIView *checkedView;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setEditing:(BOOL)editing animated:(BOOL)animated{
    [super setEditing:editing animated:animated];
    checkedView.hidden = !editing;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    checkedView.backgroundColor = selected ? [UIColor colorWithHexString:@"#218bee"] : [UIColor colorWithHexString:@"#cad0d5"];
}

- (void)bindData:(Note*)note{
    titleView.text = note.content;
    NSDateFormatter* formater = [[NSDateFormatter alloc]init];
    [formater setDateFormat:@"yyyy//MM/dd hh:mm"];
    createTimeView.text = [formater stringFromDate:note.modify_time];
}

@end
