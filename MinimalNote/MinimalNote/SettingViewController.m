//
//  SettingViewController.m
//  MinimalNote
//
//  Created by Carl Li on 5/31/15.
//  Copyright (c) 2015 Carl Li. All rights reserved.
//

#import "SettingViewController.h"
#import "SettingCell.h"
#import "TagListController.h"
#import "PasswordManager.h"
#import "PasswordViewController.h"

@interface SettingViewController (){
    PasswordManager* pswManager;
}
@property (strong, nonatomic) IBOutlet UIButton *backButton;
@property (strong, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation SettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _tableView.dataSource = self;
    _tableView.delegate = self;
    
    pswManager = [PasswordManager sharedInstance];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [_tableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDataSource
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *) indexPath{
    static NSString* identify = @"setting_cell";
    SettingCell* cell = [tableView dequeueReusableCellWithIdentifier:identify];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"SettingCell" owner:self options:nil] lastObject];
    }
    [cell setTitle:[self settingTitle:indexPath]];
    [self settingInitCell:cell index:indexPath];
    return cell;
}

- (NSString*)settingTitle:(NSIndexPath*)indexPath{
    switch (indexPath.section) {
        case 0:
            switch (indexPath.row) {
                case 0:
                    return @"标签管理";
                case 1:
                    return @"密码锁";
            }
            break;
        case 1:
            switch (indexPath.row) {
                case 0:
                    return @"关于";
            }
    }
    return @"";
}

- (void)settingInitCell:(SettingCell*)cell index:(NSIndexPath*)indexPath{
    switch (indexPath.section) {
        case 0:
            switch (indexPath.row) {
                case 0:
                    [cell setType:CELL_TYPE_MORE];
                    return;
                case 1:
                    [cell setType:CELL_TYPE_SWITCH];
                    cell.switchView.on = [pswManager hasPassword];
                    return;
            }
            break;
        case 1:
            switch (indexPath.row) {
                case 0:
                    [cell setType:CELL_TYPE_NULL];
                    return;
            }
    }
    return;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    switch (section) {
        case 0:
            return 2;
        case 1:
            return 1;
    }
    return 0;
}

- (CGFloat)tableView:(UITableView *)atableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 43;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.section) {
        case 0:
            switch (indexPath.row) {
                case 0:
                    [self openWithStoryboardId:@"tag_controller"];
                    return;
                case 1:{
                    PasswordViewController* controller = [self openWithStoryboardId:@"password_controller"];
                    [controller setState:InputState];
                    return;
                }
            }
            break;
        case 1:
            switch (indexPath.row) {
                case 0:
                    [self openWithStoryboardId:@"about_controller"];
                    return;
            }
    }
}

- (void)onPasswordSettingChanged{
    
}

@end
