//
//  SettingCell.m
//  MinimalNote
//
//  Created by Carl Li on 5/31/15.
//  Copyright (c) 2015 Carl Li. All rights reserved.
//

#import "SettingCell.h"

@implementation SettingCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

- (void)setType:(NSInteger)type{
    switch (type) {
        case CELL_TYPE_NULL:
            _moreView.hidden = YES;
            _switchView.hidden = YES;
            break;
        case CELL_TYPE_MORE:
            _moreView.hidden = NO;
            _switchView.hidden = YES;
            break;
        case CELL_TYPE_SWITCH:
            _moreView.hidden = YES;
            _switchView.hidden = NO;
            break;
            
        default:
            break;
    }
}

- (void)setTitle:(NSString*)title{
    _titleView.text = title;
}

@end
