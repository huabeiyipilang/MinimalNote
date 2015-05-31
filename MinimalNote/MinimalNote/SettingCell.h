//
//  SettingCell.h
//  MinimalNote
//
//  Created by Carl Li on 5/31/15.
//  Copyright (c) 2015 Carl Li. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SettingCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *titleView;
@property (strong, nonatomic) IBOutlet UIImageView *moreView;

- (void)showMoreView:(BOOL)show;
- (void)setTitle:(NSString*)title;

@end
