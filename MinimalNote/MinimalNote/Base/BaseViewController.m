//
//  BaseViewController.m
//  MinimalNote
//
//  Created by Carl Li on 6/2/15.
//  Copyright (c) 2015 Carl Li. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

- (void)viewDidAppear:(BOOL)animated{
    [self viewDidAppear:animated gestureEnable:YES];
}

- (void)viewDidAppear:(BOOL)animated gestureEnable:(BOOL)gestureEnable{
    [super viewDidAppear:animated];
    self.navigationController.interactivePopGestureRecognizer.enabled = gestureEnable;
    if (gestureEnable) {
        self.navigationController.interactivePopGestureRecognizer.delegate = (id)self;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)presentController:(UIViewController*)controller{
    [self presentViewController:controller animated:YES completion:nil];
}

- (IBAction)dismissController{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)openController:(UIViewController*)controller{
    [self.navigationController pushViewController:controller animated:YES];
}

- (id)openWithStoryboardId:(NSString*)identifier{
    UIViewController* controller = [self.storyboard instantiateViewControllerWithIdentifier:identifier];
    [self openController:controller];
    return controller;
}

- (IBAction)closeController{
    [self.navigationController popViewControllerAnimated:YES];
}

- (BOOL)isVisible{
    return self.isViewLoaded && self.view.window;
}

@end
