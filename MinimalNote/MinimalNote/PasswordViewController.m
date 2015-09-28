//
//  PasswordViewController.m
//  MinimalNote
//
//  Created by Carl Li on 7/2/15.
//  Copyright (c) 2015 Carl Li. All rights reserved.
//

#import "PasswordViewController.h"
#import "Logger.h"

@implementation PasswordViewController{
    
    IBOutlet UILabel *titleView;
    NSMutableString* inputPassword;
    State mState;
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    inputPassword = [NSMutableString new];
}

- (void)setState:(State)state{
    mState = state;
}

- (void)onNumberInput:(NSInteger)number{
    [inputPassword appendString:[NSString stringWithFormat:@"%ld", number]];
    if (inputPassword.length == 4) {
        switch (mState) {
            case InputState:
                
                break;
                
            default:
                break;
        }
        [self onInputFinished:inputPassword];
    }
}

- (IBAction)onNumberButtonClick:(id)sender {
    NSInteger number = ((UIButton*)sender).tag;
    if (number >= 0 && number <= 9) {
        [self onNumberInput:number];
    }
}

#pragma mark - 不同状态的处理
- (void)onInputFinished:(NSString*)psw{
    
}

@end