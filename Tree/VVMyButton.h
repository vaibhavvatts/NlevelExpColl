//
//  MyButton.h
//  ExpCollTree
//
//  Created by Vaibhav Kumar on 8/25/15.
//  Copyright (c) 2015 OSSCube. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VVMyButton : UIButton

@property NSIndexPath *indexPath;
@property NSArray *arrTreePath;
@property (weak) id cellRef;
@property BOOL isSelect;
@end
