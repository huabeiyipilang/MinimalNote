//
//  Tag.h
//  MinimalNote
//
//  Created by Carl Li on 5/30/15.
//  Copyright (c) 2015 Carl Li. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@interface Tag : NSObject
@property NSInteger nid;
@property NSString* name;
@property NSString* color;
@property BOOL isDefault;

- (UIColor*) getColor;

@end
