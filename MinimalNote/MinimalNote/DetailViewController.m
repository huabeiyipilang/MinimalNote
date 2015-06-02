//
//  DetailViewController.m
//  MinimalNote
//
//  Created by Carl Li on 5/5/15.
//  Copyright (c) 2015 Carl Li. All rights reserved.
//

#import "DetailViewController.h"
#import "Note.h"
#import "NoteManager.h"
#import "MobClick.h"

@interface DetailViewController ()
@property (strong, nonatomic) IBOutlet UITextView *textContentView;
@property (strong, nonatomic) IBOutlet UIButton *okButton;
@property (strong, nonatomic) IBOutlet UIButton *editButton;
@property (strong, nonatomic) IBOutlet UILabel *titleView;

@end

@implementation DetailViewController{
    Note* mNote;
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [MobClick beginLogPageView:@"详情页"];
    if ([self isNewMode]) {
        //新建模式
        _okButton.hidden = NO;
        _editButton.hidden = YES;
        [_textContentView becomeFirstResponder];
    }else{
        //详情模式
        _okButton.hidden = YES;
        _editButton.hidden = NO;
        _textContentView.text = mNote.content;
        _textContentView.editable = NO;
        _titleView.hidden = YES;
    }
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [_textContentView resignFirstResponder];
    [MobClick endLogPageView:@"详情页"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)showNote:(Note*)note{
    mNote = note;
}

- (BOOL)isNewMode{
    return mNote == nil;
}

- (IBAction)okClicked:(id)sender {
    if([self isNewMode]){
        Note* note = [Note new];
        note.content = _textContentView.text;
        if (note.content != nil && note.content.length > 0) {
            [[NoteManager sharedInstance] addNote:note];
        }
    }else{
        mNote.content = _textContentView.text;
        [[NoteManager sharedInstance] updateNote:mNote];
    }
    [[NSNotificationCenter defaultCenter] postNotificationName:@"fresh_note_list" object:nil];
    [self closeController];
}

- (IBAction)editClick:(id)sender {
    _textContentView.editable = YES;
    _okButton.hidden = NO;
    _editButton.hidden = YES;
    [_textContentView becomeFirstResponder];
}
@end
