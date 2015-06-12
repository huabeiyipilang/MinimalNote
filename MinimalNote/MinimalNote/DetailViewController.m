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
#import "UIColor+HexString.h"
#import "UIView+FrameMethods.h"
#import "DetailTagViewCell.h"
#import "CommonHeader.h"
#import "DropDownTitleView.h"

@interface DetailViewController ()
@property (strong, nonatomic) IBOutlet UITextView *textContentView;
@property (strong, nonatomic) IBOutlet UIButton *okButton;
@property (strong, nonatomic) IBOutlet UIButton *editButton;
@property (strong, nonatomic) IBOutlet UIView *navigatorView;
@property (strong, nonatomic) IBOutlet UITableView *tagTableView;
@property (strong, nonatomic) IBOutlet DropDownTitleView *dropTitleView;

@end

@implementation DetailViewController{
    Note* mNote;
    UILabel* tagLabelView;
    UIImageView* tagArrowView;
    BOOL showTags;
    NSMutableArray* tagsArray;
    Tag* mTag;
    CGFloat contentTextHeight;
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [MobClick beginLogPageView:@"详情页"];
    
    _textContentView.translatesAutoresizingMaskIntoConstraints = YES;
    
    tagsArray = [[NoteManager sharedInstance] getAllTags];
    _tagTableView.dataSource = self;
    _tagTableView.delegate = self;
    
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
        mTag = [mNote getTag];
    }
    if (!mTag || mTag.nid == 0) {
        mTag = [Tag new];
        mTag.name = @"未分类";
        mTag.color = DEFAULT_NAVIGATOR_COLOR;
    }
    
    [self updateTagView];
    
    CGRect rect = _textContentView.frame;
    contentTextHeight = self.view.frame.size.height - _navigatorView.frame.size.height;
    rect.size.height = contentTextHeight;
    rect.size.width = self.view.frame.size.width;
    _textContentView.frame = rect;
    
    UITapGestureRecognizer* tagTapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(onTagClick)];
    [_dropTitleView addGestureRecognizer:tagTapGesture];
    
    UITapGestureRecognizer* blackTapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onBlackTap:)];
//    blackTapGesture.delegate = self;
    blackTapGesture.numberOfTapsRequired = 1;
    [_textContentView addGestureRecognizer:blackTapGesture];
//    [self.view addGestureRecognizer:blackTapGesture];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [_textContentView resignFirstResponder];
    [MobClick endLogPageView:@"详情页"];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
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
        note.tag = mTag.nid;
        if (note.content != nil && note.content.length > 0) {
            [[NoteManager sharedInstance] addNote:note];
        }
    }else{
        mNote.content = _textContentView.text;
        mNote.tag = mTag.nid;
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

- (void)updateTagView{
    
    if (tagArrowView) {
        [tagArrowView removeFromSuperview];
    }
    if (tagLabelView) {
        [tagLabelView removeFromSuperview];
    }
    //导航栏颜色
    _navigatorView.backgroundColor = [UIColor colorWithHexString:mTag.color];
    
    [_dropTitleView setTitle:mTag.name];
}

- (void)onTagClick{
    [self showTags:!showTags];
}

- (void)showTags:(BOOL)show{
    showTags = show;
    if (showTags) {
        tagArrowView.image = [UIImage imageNamed:@"arrow_up"];
        [_tagTableView reloadData];
        [_tagTableView setHeight:tagsArray.count <= 5 ? tagsArray.count * 30 : 5 * 30];
        _tagTableView.hidden = NO;
    }else{
        tagArrowView.image = [UIImage imageNamed:@"arrow_down"];
        _tagTableView.hidden = YES;
    }
    [_dropTitleView setArrowDown:!show];
}

- (void)onBlackTap:(UITapGestureRecognizer *)gestureRecognizer{
    if (!_tagTableView.hidden) {
        [self showTags:NO];
    }
}

- (void)keyboardWillShow:(NSNotification *)aNotification
{
    CGRect keyboardRect = [[[aNotification userInfo] objectForKey:@"UIKeyboardBoundsUserInfoKey"] CGRectValue];
    NSTimeInterval animationDuration = [[[aNotification userInfo] objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    CGRect frame = _textContentView.frame;
    frame.size.height = contentTextHeight - keyboardRect.size.height;
    [UIView beginAnimations:@"ResizeForKeyboard" context:nil];
    [UIView setAnimationDuration:animationDuration];
    _textContentView.frame = frame;
    [UIView commitAnimations];
}

- (void)keyboardWillHide:(NSNotification *)aNotification
{
    NSTimeInterval animationDuration = [[[aNotification userInfo] objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    CGRect frame = _textContentView.frame;
    frame.size.height = contentTextHeight;
    [UIView beginAnimations:@"ResizeForKeyboard" context:nil];
    [UIView setAnimationDuration:animationDuration];
    _textContentView.frame = frame;
    [UIView commitAnimations];
}

#pragma mark - UITableViewDataSource
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    DetailTagViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"tag_cell"];
    Tag* tag = [tagsArray objectAtIndex:indexPath.row];
    cell.colorView.backgroundColor = [UIColor colorWithHexString:tag.color];
    cell.titleView.text = tag.name;
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return tagsArray.count;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    Tag* tag = [tagsArray objectAtIndex:indexPath.row];
    mTag = tag;
    mNote.tag = mTag.nid;
    [[NoteManager sharedInstance] updateNote:mNote];
    [self showTags:NO];
    [self updateTagView];
}

//#pragma mark - UIGestureRecognizerDelegate
//- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
//{
//    NSLog(@"touch view: %@", NSStringFromClass([touch.view class]));
//    if ([touch.view isDescendantOfView:_tagTableView]) {
//        return NO;
//    }
//    return  YES;
//}

@end
