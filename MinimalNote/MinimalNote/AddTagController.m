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
#import "ColorCell.h"

#define MODE_NEW 1
#define MODE_EDIT 2

@interface AddTagController (){
    Tag* mTag;
    TagViewCell* tagView;
    int mode;
    NSArray* colors;
}
@property (strong, nonatomic) IBOutlet UILabel *titleView;
@property (strong, nonatomic) IBOutlet UITextField *tagTitleView;
@property (strong, nonatomic) IBOutlet UIView *tagColorView;
@property (strong, nonatomic) IBOutlet UIView *displayTempView;
@property (strong, nonatomic) IBOutlet UILabel *notificationView;
@property (strong, nonatomic) IBOutlet UIButton *delButton;
@property (strong, nonatomic) IBOutlet UITableView *colorsTableView;

@end

@implementation AddTagController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadTempView];
    [self loadColors];
    mode = mTag ? MODE_EDIT : MODE_NEW;
    if (mode == MODE_NEW){
        _titleView.text = @"新建标签";
        mTag = [Tag new];
        mTag.name = @"示例标签";
        mTag.color = [colors objectAtIndex:0];
    }else{
        _titleView.text = @"修改标签";
    }
    
    _tagTitleView.text = mTag.name;
    _tagColorView.backgroundColor = [UIColor colorWithHexString:mTag.color];
    [tagView bindData:mTag];
    _colorsTableView.dataSource = self;
    _colorsTableView.delegate = self;
    [_tagColorView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onColorViewClick:)]];
}

- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    [_titleView resignFirstResponder];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (IBAction)onBackClick:(id)sender {
    [self onClose];
}


- (void)setTag:(Tag*) tag{
    mTag = tag;
}

- (void)loadColors{
    NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"TagColors" ofType:@"plist"];
    colors = [[NSArray alloc] initWithContentsOfFile:plistPath];
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

- (void)tagColorChanged:(NSString*)color{
    mTag.color = color;
    [tagView bindData:mTag];
    _tagColorView.backgroundColor = [UIColor colorWithHexString:mTag.color];
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
        if([tag.name compare:mTag.name] == NSOrderedSame && tag.nid != mTag.nid){
            _notificationView.text = @"已有相同名称的标签";
            return;
        }
    }
    
    if (mode == MODE_EDIT) {
        [manager updateTag:mTag];
    }else if(mode == MODE_NEW){
        [manager addTag:mTag];
    }
    [self onClose];
}

- (IBAction)onDeleteClick:(id)sender {
    NoteManager* manager = [NoteManager sharedInstance];
    [manager deleteTag:mTag];
    [self onClose];
}

- (void)onClose{
    [_tagTitleView resignFirstResponder];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)onColorViewClick:(id)sender{
    [_tagTitleView resignFirstResponder];
    if (_colorsTableView.hidden) {
        [_colorsTableView reloadData];
        _colorsTableView.hidden = NO;
    }else{
        _colorsTableView.hidden = YES;
    }
}

#pragma mark - UITableViewDataSource
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ColorCell* cell = [tableView dequeueReusableCellWithIdentifier:@"color_cell"];
    cell.colorView.backgroundColor = [UIColor colorWithHexString:[colors objectAtIndex:indexPath.row]];
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return colors.count;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString* color = [colors objectAtIndex:indexPath.row];
    [self tagColorChanged:color];
    [self onColorViewClick:nil];
}


@end
