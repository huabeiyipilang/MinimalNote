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
#import "DetailViewController.h"

@interface ViewController ()
@property (strong, nonatomic) IBOutlet UITableView *noteTable;
@property (strong, nonatomic) IBOutlet UIButton *editButton;
@property (strong, nonatomic) IBOutlet UIButton *addButton;
@property (strong, nonatomic) IBOutlet UIButton *delButton;

@end

@implementation ViewController{
    NoteManager* noteManager;
    NSMutableArray* notes;
    int itemHeight;
    BOOL editMode;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    noteManager = [NoteManager sharedInstance];
    _noteTable.dataSource = self;
    _noteTable.delegate = self;
}

- (void)viewWillAppear:(BOOL)animated{
    [self switchEditMode:NO];
    [self updateTable];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateTable) name:@"fresh_note_list" object:nil];
}

- (void)viewWillDisappear:(BOOL)animated{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)updateTable{
    notes = [noteManager getAllNotesWithDeleted:NO];
    [_noteTable reloadData];
}

- (IBAction)onEditButtonClick:(id)sender {
    [self switchEditMode:!editMode];
}

- (IBAction)onDeleteButtonClick:(id)sender {
    for (Note* note in notes) {
        if (note.checked) {
            note.deleted = YES;
            [noteManager updateNote:note];
        }
    }
    [self switchEditMode:NO];
    [self updateTable];
}

- (void)switchEditMode:(BOOL)editable{
    editMode = editable;
    
    _addButton.hidden = editMode;
    _delButton.hidden = !editMode;
    
    if (!editMode) {
        [self deselectAll];
    }
    [self updateEditButton];
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
    static NSString *reuseIdetify = @"note_cell";
    NoteCell* cell = [tableView dequeueReusableCellWithIdentifier:reuseIdetify];
    Note* note = [notes objectAtIndex:indexPath.row];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"NoteCell" owner:self options:nil] lastObject];
        if (itemHeight == 0) {
            itemHeight = cell.frame.size.height;
            _noteTable.rowHeight = itemHeight;
        }

    }
    [cell bindData:note];
    cell.accessoryType = note.checked ? UITableViewCellAccessoryCheckmark : UITableViewCellAccessoryNone;
    
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return notes.count;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    Note* note = [notes objectAtIndex:indexPath.row];
    if (editMode) {
        NoteCell* cell = (NoteCell*)[tableView cellForRowAtIndexPath:indexPath];
        if (note.checked) {
            cell.accessoryType = UITableViewCellAccessoryNone;
            [tableView deselectRowAtIndexPath:indexPath animated:YES];
        }
        else {
            cell.accessoryType=UITableViewCellAccessoryCheckmark;
        }
        note.checked = !note.checked;
    }else{
        DetailViewController* detailController = [self.storyboard instantiateViewControllerWithIdentifier:@"detail_controller"];
        [detailController showNote:note];
        [self presentViewController:detailController animated:YES completion:nil];
    }
}

@end
