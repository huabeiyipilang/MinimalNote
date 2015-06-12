//
//  NoteFilterView.h
//  MinimalNote
//
//  Created by Carl Li on 6/10/15.
//  Copyright (c) 2015 Carl Li. All rights reserved.
//

#import "SubView.h"
#import "NoteFilter.h"

@protocol FilterDelegate <NSObject>
- (void)onFilterChanged:(NoteFilter*)filter;
- (void)onFilterClose;
@end

@interface NoteFilterView : SubView<UITableViewDataSource, UITableViewDelegate, UIGestureRecognizerDelegate>
@property (nonatomic, assign) id<FilterDelegate> delegate;
@end
