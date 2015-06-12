//
//  DropDownTitleView.h
//  MinimalNote
//
//  Created by Carl Li on 6/10/15.
//  Copyright (c) 2015 Carl Li. All rights reserved.
//

#import "SubView.h"

@protocol DropDownTitleViewDelegate <NSObject>
- (void) onTitleClick;
@end

@interface DropDownTitleView : SubView
@property (nonatomic, assign) id<DropDownTitleViewDelegate> delegate;
@property (strong, nonatomic) IBOutlet UIImageView *arrowView;
@property (strong, nonatomic) IBOutlet UILabel *titleView;
- (void) setTitle:(NSString*)title;
- (void) setArrowDown:(BOOL)down;
@end