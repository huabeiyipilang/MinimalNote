//
//  NoteFilterView.m
//  MinimalNote
//
//  Created by Carl Li on 6/10/15.
//  Copyright (c) 2015 Carl Li. All rights reserved.
//

#import "NoteFilterView.h"
#import "NoteManager.h"
#import "NoteFilterCategoryCell.h"
#import "UIView+Shadow.h"

@implementation NoteFilterView{
    NSMutableArray* tags;
    IBOutlet UITableView *tagTableView;
}

- (void)initViews{
    [super initViews];
    tags = [[NoteManager sharedInstance] getAllTags];
    UITapGestureRecognizer* blackTapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onBlackTap:)];
    blackTapGesture.delegate = self;
    blackTapGesture.numberOfTapsRequired = 1;
    [self addGestureRecognizer:blackTapGesture];
    [tagTableView enablePopoverShadow];
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return tags.count + 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString* identify = @"filter_item";
    NoteFilterCategoryCell* cell = [tagTableView dequeueReusableCellWithIdentifier:identify];
    if (!cell) {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"NoteFilterCategoryCell" owner:self options:nil] lastObject];
    }
    
    if (indexPath.row == 0) {
        [cell setTitle:@"全部" icon:[UIImage imageNamed:@"icon_all"]];
    }else if(indexPath.row == 1){
        [cell setTitle:@"垃圾箱" icon:[UIImage imageNamed:@"icon_trash"]];
    }else if(indexPath.row > 1){
        [cell setTag:[tags objectAtIndex:indexPath.row - 2]];
    }
    
    return cell;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (_delegate) {
        NoteFilter* filter = [NoteFilter new];
        if (indexPath.row == 0) {
            filter.type = TYPE_ALL;
        }else if(indexPath.row == 1){
            filter.type = TYPE_TRASH;
        }else if(indexPath.row > 1){
            filter.type = TYPE_TAG;
            filter.tag = [tags objectAtIndex:indexPath.row - 2];
        }
        [_delegate onFilterChanged:filter];
    }
    [self close];
}

#pragma mark - UIGestureRecognizerDelegate
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
    if ([touch.view isDescendantOfView:tagTableView]) {
        return NO;
    }
    return  YES;
}

- (void)onBlackTap:(UITapGestureRecognizer *)gestureRecognizer{
    [self close];
}

- (void)close{
    if (_delegate) {
        [_delegate onFilterClose];
    }
    [self removeFromSuperview];
}

@end
