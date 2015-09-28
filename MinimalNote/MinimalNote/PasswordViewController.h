//
//  PasswordViewController.h
//  MinimalNote
//
//  Created by Carl Li on 7/2/15.
//  Copyright (c) 2015 Carl Li. All rights reserved.
//

#import "BaseViewController.h"

typedef enum{
    InputState,
    CheckState,
    VerifyState,
    ClearState
}State;

@interface PasswordViewController : BaseViewController

- (void)setState:(State)state;

@end