//
//  AddTagController.m
//  MinimalNote
//
//  Created by Carl Li on 6/1/15.
//  Copyright (c) 2015 Carl Li. All rights reserved.
//

#import "AddTagController.h"
#import "UIColor+HexString.h"
#import "TagViewCell.h"
#import "NoteManager.h"

#define MODE_NEW 1
#define MODE_EDIT 2

@interface AddTagController (){
    Tag* mTag;
    TagViewCell* tagView;
    int mode;
}
@property (strong, nonatomic) IBOutlet UILabel *titleView;
@property (strong, nonatomic) IBOutlet UITextField *tagTitleView;
@property (strong, nonatomic) IBOutlet UIView *tagColorView;
@property (strong, nonatomic) IBOutlet UIView *displayTempView;
@property (strong, nonatomic) IBOutlet UILabel *notificationView;
@property (strong, nonatomic) IBOutlet UIButton *delButton;

@end

@implementation AddTagController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadTempView];
    mode = mTag ? MODE_EDIT : MODE_NEW;
    if (mode == MODE_NEW){
        _titleView.text = @"新建标签";
        mTag = [Tag new];
        mTag.name = @"示例标签";
        mTag.color = @"#007AFF";
    }else{
        _titleView.text = @"修改标签";
    }
    
    _tagTitleView.text = mTag.name;
    _tagColorView.backgroundColor = [UIColor colorWithHexString:mTag.color];
    [tagView bindData:mTag];
}

- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    [_titleView resignFirstResponder];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (IBAction)onBackClick:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}


- (void)setTag:(Tag*) tag{
    mTag = tag;
}

- (void)loadTempView{
    tagView = [[[NSBundle mainBundle] loadNibNamed:@"TagViewCell" owner:self options:nil] objectAtIndex:0];
    float x = _displayTempView.frame.size.width/2;
    float y = _displayTempView.frame.size.height/2;
    CGPoint point = CGPointMake(x, y);
    [tagView setCenter:point];
    [_displayTempView addSubview:tagView];
}

- (IBAction)tagTitleChanged:(id)sender {
    mTag.name = _tagTitleView.text;
    [tagView bindData:mTag];
}

- (IBAction)onSaveClick:(id)sender {
    NoteManager* manager = [NoteManager sharedInstance];
    mTag.name = _tagTitleView.text;
    
    //1、标签为空
    if (mTag.name == nil || mTag.name.length == 0) {
        _notificationView.text = @"请填写标签名称";
        return;
    }
    
    //2、标签重复
    NSMutableArray* tags = [manager getAllTags];
    for (Tag* tag in tags) {
        if([tag.name compare:mTag.name] == NSOrderedSame){
            _notificationView.text = @"已有相同名称的标签";
            return;
        }
    }
    
    if (mode == MODE_EDIT) {
        [manager updateTag:mTag];
    }else if(mode == MODE_NEW){
        [manager addTag:mTag];
    }
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)onDeleteClick:(id)sender {
    NoteManager* manager = [NoteManager sharedInstance];
    [manager deleteTag:mTag];
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
