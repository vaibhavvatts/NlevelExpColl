//
//  TreeCell.h
//  ExpCollTree
//
//  Created by Vaibhav Kumar on 8/25/15.

#import <UIKit/UIKit.h>
#import "VVMyButton.h"
#import "VVNodes.h"
@interface TreeCell : UITableViewCell

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *cntTitleLeading;
@property (weak, nonatomic) IBOutlet VVMyButton *btnExpColl;
@property (weak, nonatomic) IBOutlet UILabel *lblTitle;

-(void)setViewController:(UIViewController *)controller whetherExpendible:(BOOL)isExp atIndexPath:(NSIndexPath *)indexPath forNode:(VVNodes *)node forCell:(id)cellRef containedPath:(NSArray *)arrTreePath workingRow:(NSInteger)row;



@end
