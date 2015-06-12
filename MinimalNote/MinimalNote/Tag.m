//
//  Tag.m
//  MinimalNote
//
//  Created by Carl Li on 5/30/15.
//  Copyright (c) 2015 Carl Li. All rights reserved.
//

#import "Tag.h"
#import "UIColor+HexString.h"

@implementation Tag

- (UIColor*) getColor{
    return [UIColor colorWithHexString:_color];
}

@end
