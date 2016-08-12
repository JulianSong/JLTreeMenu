//
//  SEUnitIndexTreeItem.m
//  Epub360
//
//  Created by julian on 14-2-13.
//  Copyright (c) 2014年 com.epub360. All rights reserved.
//

#import "JLDemoTreeItem.h"

@implementation JLDemoTreeItem
@synthesize children = _children;
+(JLDemoTreeItem *)rootTreeItemWithData:(NSDictionary *)data
{
    JLDemoTreeItem *rootItem =  [[JLDemoTreeItem alloc] init];
    rootItem.data  = data;
    rootItem.level = 1;
    return rootItem;
}

-(NSArray *)children
{
    if (_children == nil) {
        NSMutableArray *items = [[NSMutableArray alloc] init];
        for (NSDictionary *data  in [self.data objectForKey:@"pages"]) {
            JLDemoTreeItem *item = [[JLDemoTreeItem alloc] init];
            item.data = data;
            [items addObject:item];
            item.level = self.level+1;
        }
        _children = [NSArray arrayWithArray:items];
    }
    return _children;
}

-(NSString *)description
{
    return [NSString stringWithFormat:@"<%@,data=%@>",[super description],self.data];
}
@end