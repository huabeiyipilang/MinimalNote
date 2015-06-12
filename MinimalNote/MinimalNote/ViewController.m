//
//  ViewController.m
//  MinimalNote
//
//  Created by Carl Li on 5/4/15.
//  Copyright (c) 2015 Carl Li. All rights reserved.
//

#import "ViewController.h"
#import "NoteManager.h"
#import "Note.h"
#import "NoteCell.h"
#import "AddNoteCell.h"
#import "DetailViewController.h"
#import "MobClick.h"
#import "DropDownTitleView.h"
#import "DXPopover.h"
#import "UIView+Ext.h"
#import "NoteFilter.h"
#import "UIColor+HexString.h"
#import "CommonHeader.h"

@interface ViewController ()
@property (strong, nonatomic) IBOutlet UITableView *noteTable;
@property (strong, nonatomic) IBOutlet UIButton *editButton;
@property (strong, nonatomic) IBOutlet UIButton *settingButton;
@property (strong, nonatomic) IBOutlet UIButton *delButton;
@property (strong, nonatomic) IBOutlet DropDownTitleView *dropTitleView;
@property (strong, nonatomic) IBOutlet UIView *navigatorView;

@end

@implementation ViewController{
    NoteManager* noteManager;
    NSMutableArray* notes;
    int itemHeight;
    BOOL editMode;
    NoteFilter* mFilter;
    NoteFilterView* filterView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    mFilter = [NoteFilter new];
    mFilter.type = TYPE_ALL;
    noteManager = [NoteManager sharedInstance];
    _noteTable.dataSource = self;
    _noteTable.delegate = self;
    
    self.navigationController.interactivePopGestureRecognizer.enabled = YES;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self switchEditMode:NO];
    [self updateTable];
    [MobClick beginLogPageView:@"列表页"];
    
    [_dropTitleView setTitle:@"工作"];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateTable) name:@"fresh_note_list" object:nil];
    
    UITapGestureRecognizer* tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onDropTitleViewClick)];
    [_dropTitleView addGestureRecognizer:tapGesture];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [MobClick endLogPageView:@"列表页"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)updateTable{
    NSString* title = @"ERROR";
    switch (mFilter.type) {
        case TYPE_ALL:
            notes = [noteManager getAllNotesWithDeleted:NO];
            title = @"全部";
            _navigatorView.backgroundColor = [UIColor colorWithHexString:DEFAULT_NAVIGATOR_COLOR];
            break;
        case TYPE_TRASH:
            notes = [noteManager getDeletedNotes];
            title = @"垃圾箱";
            _navigatorView.backgroundColor = [UIColor colorWithHexString:DEFAULT_NAVIGATOR_COLOR];
            break;
        case TYPE_TAG:
            if (mFilter.tag) {
                notes = [noteManager getNotesByTagId:mFilter.tag.nid];
                title = mFilter.tag.name;
                _navigatorView.backgroundColor = [UIColor colorWithHexString:mFilter.tag.color];
            }else{
                notes = [NSMutableArray new];
                _navigatorView.backgroundColor = [UIColor colorWithHexString:DEFAULT_NAVIGATOR_COLOR];
            }
            break;
            
        default:
            break;
    }
    [_noteTable reloadData];
    [_dropTitleView setTitle:title];
}

- (IBAction)onEditButtonClick:(id)sender {
    [self switchEditMode:!editMode];
}

- (IBAction)onDeleteButtonClick:(id)sender {
    if (mFilter.type == TYPE_TRASH) {
        for (Note* note in notes) {
            if (note.checked) {
                [noteManager deleteNote:note];
            }
        }
    }else{
        for (Note* note in notes) {
            if (note.checked) {
                note.deleted = YES;
                [noteManager updateNote:note];
            }
        }
    }
    [self switchEditMode:NO];
    [self updateTable];
}

- (void)onDropTitleViewClick{
//    if (!filterView) {
        filterView = [[NoteFilterView class] loadFromNibNoOwner];
        CGRect rect = self.view.frame;
        filterView.frame = rect;
        filterView.delegate = self;
//    }
    [self.view addSubview:filterView];
    [_dropTitleView setArrowDown:NO];
}

- (void)switchEditMode:(BOOL)editable{
    editMode = editable;
    
    _settingButton.hidden = editMode;
    _delButton.hidden = !editMode;
    
    if (!editMode) {
        [self deselectAll];
    }
    [self updateEditButton];
    [self updateTable];
}

- (void)updateEditButton{
    NSString* title = editMode ? @"完成" : @"编辑";
    [_editButton setTitle:title forState:UIControlStateNormal];
}

- (void)selectAll{
    for (Note* note in notes) {
        note.checked = YES;
    }
    [_noteTable reloadData];
}

- (void)deselectAll{
    for (Note* note in notes) {
        note.checked = NO;
    }
    [_noteTable reloadData];
}

#pragma mark - UITableViewDataSource
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        static NSString *reuseIdetify = @"add_note_cell";
        AddNoteCell* cell = [tableView dequeueReusableCellWithIdentifier:reuseIdetify];
        if (!cell) {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"AddNoteCell" owner:self options:nil] lastObject];
        }
        return cell;
    }else if(indexPath.section == 1){
        static NSString *reuseIdetify = @"note_cell";
        NoteCell* cell = [tableView dequeueReusableCellWithIdentifier:reuseIdetify];
        Note* note = [notes objectAtIndex:indexPath.row];
        if (!cell) {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"NoteCell" owner:self options:nil] lastObject];
        }
        [cell bindData:note];
        [cell setCheckMode:editMode];
        
        return cell;
    }
    return nil;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 1;
    }else if (section == 1){
        return notes.count;
    }
    return 0;
}

- (CGFloat)tableView:(UITableView *)atableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 56;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0){
        DetailViewController* detailController = [self.storyboard instantiateViewControllerWithIdentifier:@"detail_controller"];
        [self openController:detailController];
    }else if (indexPath.section == 1){
        Note* note = [notes objectAtIndex:indexPath.row];
        if (editMode) {
            NoteCell* cell = (NoteCell*)[tableView cellForRowAtIndexPath:indexPath];
            note.checked = !note.checked;
            [cell setChecked:note.checked];
        }else{
            DetailViewController* detailController = [self.storyboard instantiateViewControllerWithIdentifier:@"detail_controller"];
            [detailController showNote:note];
            [self openController:detailController];
        }
    }
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}

#pragma mark - FilterDelegate
- (void) onFilterChanged:(NoteFilter *)filter{
    mFilter = filter;
    [self updateTable];
}

- (void)onFilterClose{
    [_dropTitleView setArrowDown:YES];
}

@end
