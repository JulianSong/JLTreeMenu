//
//  JLTreeItem.m
//  JLTreeMenu
//  Created by julian on 14-2-10.
//  Copyright (c) 2014年 julian  All rights reserved.
//

#import "JLTreeItem.h"

@implementation JLTreeItem
-(NSUInteger)expandedChildrenCount
{
    NSUInteger count =0;
    for (JLTreeItem *item in self.children) {
        if (item.isExpand) {
            count += item.expandedChildrenCount;
        }
        count++;
    }
    return count;
}
@end
