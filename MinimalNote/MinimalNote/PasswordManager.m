//
//  PasswordManager.m
//  MinimalNote
//
//  Created by Carl Li on 7/2/15.
//  Copyright (c) 2015 Carl Li. All rights reserved.
//

#import "PasswordManager.h"

#define PASSWORD_KEY @"password"

@implementation PasswordManager

+ (instancetype)sharedInstance {
    static id _sharedInstance = nil;
    static dispatch_once_t oncePredicate;
    dispatch_once(&oncePredicate, ^{
        _sharedInstance = [[self alloc] init];
    });
    return _sharedInstance;
}

- (void) setPassword:(NSString*)password{
    NSUserDefaults *defaults =[NSUserDefaults standardUserDefaults];
    [defaults setObject:password forKey:PASSWORD_KEY];
}

- (BOOL) verifyPassword:(NSString*)password{
    if (!password || password.length == 0) {
        return NO;
    }
    NSUserDefaults *defaults =[NSUserDefaults standardUserDefaults];
    NSString* current = [defaults objectForKey:PASSWORD_KEY];
    return [password isEqualToString:current];
}

- (BOOL) hasPassword{
    NSUserDefaults *defaults =[NSUserDefaults standardUserDefaults];
    NSString* current = [defaults objectForKey:PASSWORD_KEY];
    return current != nil && current.length > 0;
}

- (void) clearPassword{
    NSUserDefaults *defaults =[NSUserDefaults standardUserDefaults];
    [defaults removeObjectForKey:PASSWORD_KEY];
}

@end
