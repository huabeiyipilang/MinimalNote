//
//  UIView+Shadow.m
//  MinimalNote
//
//  Created by Carl Li on 6/11/15.
//  Copyright (c) 2015 Carl Li. All rights reserved.
//

#import "UIView+Shadow.h"

@implementation UIView (Shadow)

- (void) enablePopoverShadow{
    self.layer.shadowOffset = CGSizeMake(-5, 3);
    self.layer.shadowOpacity = 0.4;
    self.layer.shadowColor = [UIColor blackColor].CGColor;
}

@end
