//
//  MDTreeMenuTableViewCell.m
//  Comac
//
//  Created by Julian.Song on 16/7/15.
//  Copyright © 2016年 21epub. All rights reserved.
//

#import "JLDemoTableViewCell.h"
#import "JLDemoTreeItem.h"
@implementation JLDemoTableViewCell

- (void)setItem:(JLTreeItem *)item
{
    [super setItem:item];
    NSDictionary *jsonData = [item data];
    self.textLabel.text = [jsonData objectForKey:@"title"];
}

@end
