//
//  TreeFeeding.h
//  ExpCollTree
//
//  Created by Vaibhav Kumar on 8/25/15.
//  Copyright (c) 2015 OSSCube. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "VVNodes.h"

@interface VVTreeFeeding : NSObject

-(VVNodes *)FeedData:(NSArray *)arrData withLevel:(NSArray *)arrLevel;
-(VVNodes *)reachNodePositionToLevel:(NSString *)level startNode:(VVNodes *)root;
@end
