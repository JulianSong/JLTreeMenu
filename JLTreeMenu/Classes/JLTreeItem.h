//
//  JLTreeItem.h
//  JLTreeMenu
//  Created by julian on 14-2-10.
//  Copyright (c) 2014年 julian  All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JLTreeItem : NSObject
@property(nonatomic,weak)JLTreeItem *parent;
@property(nonatomic,readonly)NSArray *children;
@property(nonatomic,strong)NSIndexPath *path;
@property(nonatomic)NSUInteger  level;
@property(nonatomic)id data;
@property(nonatomic,assign)BOOL isExpand;
@property(nonatomic,assign)BOOL isSelected;
@property(nonatomic,readonly)NSUInteger expandedChildrenCount;
@property(nonatomic,strong)NSArray *showingItems;
@end
