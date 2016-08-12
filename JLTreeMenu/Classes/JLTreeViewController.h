//
//  JLTreeViewController.h
//  JLTreeMenu
//  Created by julian on 14-2-10.
//  Copyright (c) 2014年 julian  All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JLTreeTableViewCell.h"
#import "JLTreeItem.h"
typedef void (^JLTreeMenuDidSelecBlock)(JLTreeItem *treeItem,NSIndexPath *indexPath);
@interface JLTreeViewController : UITableViewController
@property (nonatomic,strong)JLTreeItem             *rootItem;
@property (nonatomic,unsafe_unretained)Class       tableCellClass;
@property (nonatomic,strong)JLTreeTableViewCell    *prototypeCell;
@property (nonatomic,assign)CGFloat                cellInset;
@property (nonatomic,copy)JLTreeMenuDidSelecBlock  menuDidSelecBlock;
-(void)reload;
@end
