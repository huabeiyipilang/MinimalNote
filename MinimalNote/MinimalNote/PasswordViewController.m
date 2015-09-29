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
    IBOutlet UILabel *numberView1;
    IBOutlet UILabel *numberView2;
    IBOutlet UILabel *numberView3;
    IBOutlet UILabel *numberView4;
    NSArray* numberViews;
    State mState;
    NSString* firstInputPassword;
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    numberViews = [[NSArray alloc] initWithObjects:numberView1, numberView2, numberView3, numberView4, nil];
}

- (void)setState:(State)state{
    mState = state;
    inputPassword = [NSMutableString new];
}

- (void)onNumberInput:(NSInteger)number{
    [inputPassword appendString:[NSString stringWithFormat:@"%ld", number]];
    [self updateNumberViews];
    if (inputPassword.length == 4) {
        switch (mState) {
            case InputState:
                firstInputPassword = inputPassword;
                [self setState:CheckState];
                break;
            case CheckState:
                if ([inputPassword isEqualToString:firstInputPassword]) {
                    [self dismissController];
                }else{
                    [self setState:InputState];
                }
                break;
            case VerifyState:
                break;
            case ClearState:
                break;
            default:
                break;
        }
        [self onInputFinished:inputPassword];
    }
}

- (void)updateNumberViews{
    NSInteger length = inputPassword.length;
    for (NSInteger i = 0; i < 4; i++) {
        ((UILabel*)[numberViews objectAtIndex:i]).text = i < length ? @"*" : @"_";
    }
}

- (IBAction)onNumberButtonClick:(id)sender {
    NSInteger number = ((UIButton*)sender).tag;
    if (number >= 0 && number <= 9) {
        [self onNumberInput:number];
    }
}

- (IBAction)clearNumbers:(id)sender {
    inputPassword = [NSMutableString new];
    [self updateNumberViews];
}

#pragma mark - 不同状态的处理
- (void)onInputFinished:(NSString*)psw{
    
}

@end