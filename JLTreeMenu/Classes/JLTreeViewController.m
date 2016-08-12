//
//  JLTreeViewController.m
//  JLTreeMenu
//  Created by julian on 14-2-10.
//  Copyright (c) 2014年 julian  All rights reserved.
//

#import "JLTreeViewController.h"
static NSString *CellIdentifier = @"Cell";
@interface JLTreeViewController ()
@property(nonatomic,strong)NSMutableArray *treeItems;
@end

@implementation JLTreeViewController
@synthesize rootItem                      = _rootItem;
@synthesize tableCellClass                = _tableCellClass;
@synthesize menuDidSelecBlock             = _menuDidSelecBlock;
@synthesize cellInset                     = _cellInset;
- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        _tableCellClass = [JLTreeTableViewCell class];
        _treeItems      = [[NSMutableArray alloc] init];
             _cellInset = 15;
        self.tableView.tableFooterView = [[UIView alloc]init];
    }
    return self;
}

-(void)awakeFromNib
{
    [super awakeFromNib];
    _tableCellClass = [JLTreeTableViewCell class];
    _treeItems      = [[NSMutableArray alloc] init];
    _cellInset      = 15;
    self.tableView.tableFooterView = [[UIView alloc]init];
}

- (instancetype)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        _tableCellClass = [JLTreeTableViewCell class];
        _treeItems      = [[NSMutableArray alloc] init];
        _cellInset      = 15;
        self.tableView.tableFooterView = [[UIView alloc]init];
    }
    return self;
}


-(void)setRootItem:(JLTreeItem *)rootItem
{
    if (_rootItem != rootItem) {
        _rootItem = rootItem;
    }
}

- (void)reload
{
    [self.treeItems removeAllObjects];
    
    if (self.rootItem.showingItems.count > 0 ) {
        for (JLTreeItem *item  in self.rootItem.showingItems) {
            [self.treeItems addObject:item];
        }
    }else{
        for (JLTreeItem *item  in self.rootItem.children) {
            [self.treeItems addObject:item];
        }
    }
    [self.tableView reloadData];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.treeItems count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row > self.treeItems.count) {
        return nil;
    }

    JLTreeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell) {
        cell = [[self.tableCellClass alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    [cell setExpandActionHandleBlock:^(JLTreeTableViewCell *cell) {
        [self tableView:tableView didExpandRowAtIndexPath:[tableView indexPathForCell:cell]];
    }];
    [cell setPrototypeCell:self.prototypeCell];
    JLTreeItem *item = [self.treeItems objectAtIndex:indexPath.row];
    cell.item = item;
    return cell;
}

-(void)tableView:(UITableView *)tableView didExpandRowAtIndexPath:(NSIndexPath *)indexPath
{
    JLTreeTableViewCell *seletedeCell = (JLTreeTableViewCell *)[tableView cellForRowAtIndexPath:indexPath];
    JLTreeItem *selectedItem = seletedeCell.item;
    
    if (selectedItem.children.count) {
        if (!selectedItem.isExpand ) {
            NSMutableArray *indexPaths = [[NSMutableArray alloc] init];
            for (int i =1 ; i<=selectedItem.children.count; i++) {
                [indexPaths addObject:[NSIndexPath indexPathForRow:indexPath.row +i inSection:indexPath.section]];
            }
            NSIndexSet *indexs = [NSIndexSet indexSetWithIndexesInRange:NSMakeRange(indexPath.row+1,selectedItem.children.count)];
            [self.treeItems insertObjects:selectedItem.children atIndexes:indexs];
            [tableView insertRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationFade];
            selectedItem.isExpand = YES;
        }else{
            
            NSUInteger expandedChildrenCount = selectedItem.expandedChildrenCount;
            
            NSIndexSet *indexs = [NSIndexSet indexSetWithIndexesInRange:NSMakeRange(indexPath.row+1,expandedChildrenCount)];
            
            NSIndexPath * selectedIndexPath = [tableView indexPathForSelectedRow];
            
            if (selectedIndexPath.row > indexPath.row && selectedIndexPath.row <= indexPath.row+expandedChildrenCount) {
                [tableView deselectRowAtIndexPath:selectedIndexPath animated:NO];
            }   
            [self.treeItems enumerateObjectsAtIndexes:indexs options:NSEnumerationConcurrent usingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
                [(JLTreeItem *)obj setIsExpand:NO];
                
            }];
            [self.treeItems removeObjectsAtIndexes:indexs];
            
            NSMutableArray *indexPaths = [[NSMutableArray alloc] init];
            for (int i =1 ; i<=expandedChildrenCount; i++) {
                [indexPaths addObject:[NSIndexPath indexPathForRow:indexPath.row +i inSection:indexPath.section]];
            }
            [tableView deleteRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationFade];
            selectedItem.isExpand = NO;
        }
        seletedeCell.isExpand = selectedItem.isExpand;
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    JLTreeTableViewCell *seletedeCell = (JLTreeTableViewCell *)[tableView cellForRowAtIndexPath:indexPath];
    JLTreeItem *selectedItem = seletedeCell.item;
    selectedItem.isSelected = YES;
    if (self.menuDidSelecBlock) {
        self.menuDidSelecBlock(selectedItem,indexPath);
    }
}

-(void) tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    JLTreeItem *item = [self.treeItems objectAtIndex:indexPath.row];
    CGFloat leftPadding = (item.level- 1)* self.cellInset;
    [cell setSeparatorInset:UIEdgeInsetsMake(0,leftPadding,0,0)];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    self.rootItem.showingItems = self.treeItems;
}

- (void)dealloc
{
    self.rootItem.showingItems = self.treeItems;
}

@end
