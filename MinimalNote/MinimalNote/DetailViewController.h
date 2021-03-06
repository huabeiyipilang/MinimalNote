//
//  DetailViewController.h
//  MinimalNote
//
//  Created by Carl Li on 5/5/15.
//  Copyright (c) 2015 Carl Li. All rights reserved.
//

#import "ViewController.h"
#import "Note.h"
#import "BaseHeader.h"

@interface DetailViewController : BaseViewController<UITableViewDataSource, UITableViewDelegate, UIGestureRecognizerDelegate>
- (void)showNote:(Note*)note;
@end
