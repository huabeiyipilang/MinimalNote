//
//  NoteFilterCategoryCell.m
//  MinimalNote
//
//  Created by Carl Li on 6/10/15.
//  Copyright (c) 2015 Carl Li. All rights reserved.
//

#import "NoteFilterCategoryCell.h"
#import "UIColor+HexString.h"

@implementation NoteFilterCategoryCell{
    
    IBOutlet UIImageView *iconView;
    IBOutlet UIView *colorView;
    IBOutlet UILabel *titleView;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setTitle:(NSString*)title icon:(UIImage*)image{
    titleView.text = title;
    iconView.image = image;
    
    iconView.hidden = NO;
    colorView.hidden = YES;
}

- (void)setTag:(Tag*) tag{
    iconView.hidden = YES;
    colorView.hidden = NO;
    
    titleView.text = tag.name;
    colorView.backgroundColor = [tag getColor];
}

@end
