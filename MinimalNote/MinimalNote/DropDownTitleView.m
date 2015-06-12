//
//  DropDownTitleView.m
//  MinimalNote
//
//  Created by Carl Li on 6/10/15.
//  Copyright (c) 2015 Carl Li. All rights reserved.
//

#import "DropDownTitleView.h"

@implementation DropDownTitleView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.translatesAutoresizingMaskIntoConstraints = YES;
    }
    return self;
}

- (void) setTitle:(NSString*)title{
    _titleView.text = title;
    [self updateFrame];
}

- (void) setArrowDown:(BOOL)down{
    _arrowView.image = [UIImage imageNamed:down ? @"arrow_down" : @"arrow_up"];
}

- (void)updateFrame{
    
    //重置label尺寸
    NSStringDrawingOptions options =  NSStringDrawingUsesLineFragmentOrigin;
    CGRect labelRect = [_titleView.text boundingRectWithSize:CGSizeMake(MAXFLOAT, _titleView.frame.size.height) options:options attributes:@{NSFontAttributeName:_titleView.font} context:nil];
    
    CGFloat tagViewWidth = labelRect.size.width;// + _arrowView.frame.size.width; 整体居中改为文字居中
    labelRect.origin.x = ([UIScreen mainScreen].bounds.size.width - 160 - tagViewWidth)/2;
    labelRect.origin.y = 0;
    labelRect.size.height = _titleView.frame.size.height;
    _titleView.frame = labelRect;
    
    CGRect arrowRect = CGRectMake(labelRect.origin.x + labelRect.size.width, 0, _arrowView.frame.size.width, _arrowView.frame.size.height);
    _arrowView.frame = arrowRect;
}

- (void)dealloc {
    NSLog(@"Embedded View dealloc");
}

@end
