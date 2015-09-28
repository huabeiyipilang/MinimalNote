//
//  SettingCell.h
//  MinimalNote
//
//  Created by Carl Li on 5/31/15.
//  Copyright (c) 2015 Carl Li. All rights reserved.
//

#import <UIKit/UIKit.h>

#define CELL_TYPE_NULL 0
#define CELL_TYPE_MORE 1
#define CELL_TYPE_SWITCH 2

@interface SettingCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *titleView;
@property (strong, nonatomic) IBOutlet UIImageView *moreView;
@property (strong, nonatomic) IBOutlet UISwitch *switchView;

- (void)setType:(NSInteger)type;
- (void)setTitle:(NSString*)title;

@end
