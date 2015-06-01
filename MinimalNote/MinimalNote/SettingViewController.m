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

@interface SettingViewController ()
@property (strong, nonatomic) IBOutlet UIButton *backButton;
@property (strong, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation SettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _tableView.dataSource = self;
    _tableView.delegate = self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)onBackButtonClick:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - UITableViewDataSource
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *) indexPath{
    static NSString* identify = @"setting_cell";
    SettingCell* cell = [tableView dequeueReusableCellWithIdentifier:identify];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"SettingCell" owner:self options:nil] lastObject];
    }
    [cell setTitle:[self settingTitle:indexPath]];
    [cell showMoreView:[self settingShowMore:indexPath]];
    return cell;
}

- (NSString*)settingTitle:(NSIndexPath*)indexPath{
    switch (indexPath.section) {
        case 0:
            switch (indexPath.row) {
                case 0:
                    return @"标签管理";
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

- (BOOL)settingShowMore:(NSIndexPath*)indexPath{
    switch (indexPath.section) {
        case 0:
            switch (indexPath.row) {
                case 0:
                    return YES;
            }
            break;
        case 1:
            switch (indexPath.row) {
                case 0:
                    return NO;
            }
    }
    return NO;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    switch (section) {
        case 0:
            return 1;
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
                    [self openController:@"tag_controller"];
                    return;
            }
            break;
        case 1:
            switch (indexPath.row) {
                case 0:
                    return;
            }
    }
}

- (void)openController:(NSString*)controllerId{
    UIViewController* controller = [self.storyboard instantiateViewControllerWithIdentifier:controllerId];
    [self presentViewController:controller animated:YES completion:nil];
}

@end
