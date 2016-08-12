//
//  JLTreeTableViewCell.h
//  JLTreeMenu
//  Created by julian on 14-2-10.
//  Copyright (c) 2014年 julian  All rights reserved.
//

#import "JLTreeTableViewCell.h"

@implementation JLTreeTableViewCell
@synthesize isExpand = _isExpand;
@synthesize item=_item;
@synthesize expandActionHandleBlock = _expandActionHandleBlock;
@synthesize prototypeCell;
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0,50,self.bounds.size.height)];
        [button setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(expandActionHandle) forControlEvents:UIControlEventTouchUpInside];
        self.accessoryView =button;
    }
    return self;
}

-(void)setItem:(JLTreeItem *)item
{
    if (_item !=item) {
        self.accessoryView.hidden = !(item.children.count > 0);
        self.isExpand = item.isExpand;
        _item = item;
    }
}

-(void)setIsExpand:(BOOL)isExpand
{
    _isExpand = isExpand;
    if (isExpand) {
        [(UIButton *)self.accessoryView setTitle:@"－" forState:UIControlStateNormal];
    }else{
        [(UIButton *)self.accessoryView setTitle:@"＋" forState:UIControlStateNormal];
    }
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    self.textLabel.frame = CGRectMake((self.item.level-1) * 15 , self.textLabel.frame.origin.y, self.textLabel.frame.size.width-5*self.item.level, self.textLabel.frame.size.height);
    self.accessoryView.center = CGPointMake(self.accessoryView.center.x + 15, self.accessoryView.center.y);
}

-(void)expandActionHandle
{
    if (self.expandActionHandleBlock) {
        _expandActionHandleBlock(self);
    }
}

@end
