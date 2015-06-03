//
//  UIView+FrameMethods.h
//  MinimalNote
//
//  Created by Carl Li on 6/2/15.
//  Copyright (c) 2015 Carl Li. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (FrameMethods)
//Move methods

- (void)moveHorizontal:(CGFloat)horizontal vertical:(CGFloat)vertical;

- (void)moveHorizontal:(CGFloat)horizontal vertical:(CGFloat)vertical addWidth:(CGFloat)widthAdded addHeight:(CGFloat)heightAdded;

- (void)moveToHorizontal:(CGFloat)horizontal toVertical:(CGFloat)vertical;

- (void)moveToHorizontal:(CGFloat)horizontal toVertical:(CGFloat)vertical setWidth:(CGFloat)width setHeight:(CGFloat)height;

//Set x/y
- (void)setX:(CGFloat)x;
- (void)setY:(CGFloat)y;
- (void)setX:(CGFloat)x Y:(CGFloat)y;

//Set width/height

- (void)setWidth:(CGFloat)width height:(CGFloat)height;

- (void)setWidth:(CGFloat)width;

- (void)setHeight:(CGFloat)height;

//Add width/height

- (void)addWidth:(CGFloat)widthAdded addHeight:(CGFloat)heightAdded;

- (void)addWidth:(CGFloat)widthAdded;

- (void)addHeight:(CGFloat)heightAdded;

//Set corner radius

- (void)setCornerRadius:(CGFloat)radius;

- (void)setCornerRadius:(CGFloat)radius borderColor:(UIColor *)borderColor;

- (CGRect)frameInWindow;
@end
