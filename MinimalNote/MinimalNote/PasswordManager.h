//
//  PasswordManager.h
//  MinimalNote
//
//  Created by Carl Li on 7/2/15.
//  Copyright (c) 2015 Carl Li. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PasswordManager : NSObject
@property BOOL hasAuthority;
+ (instancetype)sharedInstance;
- (void) setPassword:(NSString*)password;
- (BOOL) verifyPassword:(NSString*)password;
- (BOOL) hasPassword;
- (void) clearPassword;

@end
