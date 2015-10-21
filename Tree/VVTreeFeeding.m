//
//  TreeFeeding.m
//  ExpCollTree
//
//  Created by Vaibhav Kumar on 8/25/15.
//  Copyright (c) 2015 OSSCube. All rights reserved.
//

#import "VVTreeFeeding.h"

@interface VVTreeFeeding()
{
    VVNodes *rootNode;
}

@end

@implementation VVTreeFeeding

-(VVNodes *)FeedData:(NSArray *)arrData withLevel:(NSArray *)arrLevel
{
    rootNode = [[VVNodes alloc]init];
    [rootNode setLevel:0];
    [rootNode setArrNodes:[[NSMutableArray alloc] initWithObjects:nil]];
    [rootNode setData:nil];
    
    for (int i=0; i< arrLevel.count; i++) {
        [self createTree:rootNode level:[[arrLevel objectAtIndex:i] integerValue] withData:[arrData objectAtIndex:i]];
    }
    return rootNode;
}

-(void)createTree:(VVNodes *)parentNode level:(NSInteger)level withData:(NSString *)data
{
    if (parentNode.arrNodes.count == 0) {
        [parentNode.arrNodes addObject:[self createNodeWithLevel:level forData:data]];
    }else{
        VVNodes *node = (VVNodes *)[parentNode.arrNodes lastObject];
        if (level <= node.level) {
            [parentNode.arrNodes addObject:[self createNodeWithLevel:level forData:data]];
        }else{
            [self createTree:node level:level withData:data];
        }
    }
}

-(VVNodes *)createNodeWithLevel:(NSInteger)level forData:(NSString *)data
{
    VVNodes *node = [[VVNodes alloc]init];
    node.level = level;
    [node setArrNodes:[[NSMutableArray alloc] initWithObjects:nil]];
    [node setData:data];
    return node;
}

-(VVNodes *)reachNodePositionToLevel:(NSString *)level startNode:(VVNodes *)root
{
    NSArray *arrPath = [level componentsSeparatedByString:@"_"];
    
    VVNodes *node1;
    VVNodes *node2 = root;
    for (int i=0; i< arrPath.count; i++) {
        node1 = node2;
        int treeIndex = [[arrPath objectAtIndex:i] intValue];
        node2 = [node1.arrNodes objectAtIndex:treeIndex];
    }
    return node2;
}



@end
