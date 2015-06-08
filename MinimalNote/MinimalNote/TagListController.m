//
//  TagListController.m
//  MinimalNote
//
//  Created by Carl Li on 5/31/15.
//  Copyright (c) 2015 Carl Li. All rights reserved.
//

#import "TagListController.h"
#import "NoteManager.h"
#import "TagViewCell.h"
#import "GroupTitleView.h"
#import "AddTagController.h"

@interface TagListController (){
    int defaultCount;
    NSMutableArray* tags;
    NoteManager* noteManager;
    BOOL isSmallScreen;
}
@property (strong, nonatomic) IBOutlet UICollectionView *collectionView;

@end

@implementation TagListController

- (void)viewDidLoad {
    [super viewDidLoad];
    [_collectionView registerClass:[TagViewCell class] forCellWithReuseIdentifier:@"tag_cell"];
    noteManager = [NoteManager sharedInstance];
    _collectionView.dataSource = self;
    _collectionView.delegate = self;
    isSmallScreen = [UIScreen mainScreen].bounds.size.width <= 320 ? YES : NO;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self updateData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)updateData{
    tags = [noteManager getAllTags];
    defaultCount = 0;
    for (Tag* tag in tags) {
        if (tag.isDefault) {
            defaultCount++;
        }else{
            break;
        }
    }
    [_collectionView reloadData];
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if (section == 0) {
        return defaultCount;
    }else{
        return tags.count - defaultCount + 1;
    }
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString* identify = @"tag_cell";
    TagViewCell* cell = [collectionView dequeueReusableCellWithReuseIdentifier:identify forIndexPath:indexPath];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"TagViewCell" owner:self options:nil] lastObject];
    }
    NSInteger index = 0;
    if (indexPath.section == 0) {
        index = indexPath.row;
    }else{
        index = defaultCount + indexPath.row;
    }
    if (tags.count <= index) {
        cell.addView.hidden = NO;
    }else{
        cell.addView.hidden = YES;
        [cell bindData:[tags objectAtIndex:index]];
    }
    return cell;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 2;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    UICollectionReusableView *reusableview = nil;
    
    if (kind == UICollectionElementKindSectionHeader){
        GroupTitleView *titleView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"GroupTitleView" forIndexPath:indexPath];
        
        titleView.titleView.text = indexPath.section == 0 ? @"默认" : @"自定义";
        reusableview = titleView;
    }
    
    return reusableview;
}

#pragma mark --UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return isSmallScreen ? CGSizeMake(135, 30) : CGSizeMake(150, 30);
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        
    }else{
        NSInteger index = defaultCount + indexPath.row;
        AddTagController* controller = [self.storyboard instantiateViewControllerWithIdentifier:@"add_tag_controller"];
        if (index >= tags.count) {
            //新建标签
        }else{
            //编辑标签
            [controller setTag:[tags objectAtIndex:index]];
        }
        [self openController:controller];
//        [self presentController:controller];
    }
}

- (UIEdgeInsets)sectionInset
{
    return UIEdgeInsetsMake(0, 0, 0, 0);
}

@end
