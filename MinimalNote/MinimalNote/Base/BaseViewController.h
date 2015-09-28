//
//  BaseViewController.h
//  MinimalNote
//
//  Created by Carl Li on 6/2/15.
//  Copyright (c) 2015 Carl Li. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseViewController : UIViewController

- (void)viewDidAppear:(BOOL)animated gestureEnable:(BOOL)gestureEnable;
- (void)presentController:(UIViewController*)controller;
- (IBAction)dismissController;
- (void)openController:(UIViewController*)controller;
- (id)openWithStoryboardId:(NSString*)identifier;
- (IBAction)closeController;
- (BOOL)isVisible;
@end
