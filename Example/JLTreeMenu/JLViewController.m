//
//  JLViewController.m
//  JLTreeMenu
//
//  Created by julian.song on 08/12/2016.
//  Copyright (c) 2016 julian.song. All rights reserved.
//

#import "JLViewController.h"
#import "JLDemoTreeItem.h"
#import "JLDemoTableViewCell.h"
@interface JLViewController ()

@end

@implementation JLViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title                 = @"JLTreeMenu";
    self.navigationItem.prompt = @"Seleced:";
    
    NSString *jsonFile         = [[NSBundle mainBundle] pathForResource:@"category" ofType:@"json"];
    NSData *data               = [NSData dataWithContentsOfFile:jsonFile];
    NSDictionary *jsonObj      = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
    self.tableCellClass        = [JLDemoTableViewCell class];
    self.rootItem              = [JLDemoTreeItem rootTreeItemWithData:jsonObj];
    
    __weak id weak_self = self;
    [self setMenuDidSelecBlock:^(JLTreeItem *item ,NSIndexPath *indexPath){
        __strong JLViewController *strong_self = weak_self;
        strong_self.navigationItem.prompt =[NSString stringWithFormat:@"Seleced:%@",[[item data] objectForKey:@"title"]];
    }];
    
    [self reload];
    
}

@end
