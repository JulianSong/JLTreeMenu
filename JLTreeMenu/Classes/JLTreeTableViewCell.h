//
//  JLTreeTableViewCell.h
//  JLTreeMenu
//  Created by julian on 14-2-10.
//  Copyright (c) 2014年 julian  All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JLTreeItem.h"
@interface JLTreeTableViewCell : UITableViewCell
@property(nonatomic,assign)BOOL isExpand;
@property(nonatomic,strong)JLTreeItem *item;
@property(nonatomic,copy) void(^expandActionHandleBlock)(JLTreeTableViewCell *cell);
@property(nonatomic,strong)JLTreeTableViewCell *prototypeCell;
@end
