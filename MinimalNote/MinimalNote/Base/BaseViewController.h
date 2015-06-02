//
//  BaseViewController.h
//  MinimalNote
//
//  Created by Carl Li on 6/2/15.
//  Copyright (c) 2015 Carl Li. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseViewController : UIViewController
- (void)openController:(UIViewController*)controller;
- (void)openWithStoryboardId:(NSString*)identifier;
- (IBAction)closeController;
@end
