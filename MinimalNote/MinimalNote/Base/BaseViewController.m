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

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.interactivePopGestureRecognizer.delegate = (id)self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)openController:(UIViewController*)controller{
    [self.navigationController pushViewController:controller animated:YES];
}

- (void)openWithStoryboardId:(NSString*)identifier{
    UIViewController* controller = [self.storyboard instantiateViewControllerWithIdentifier:identifier];
    [self openController:controller];
}

- (IBAction)closeController{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
