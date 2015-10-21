//
//  TreeCell.m
//  ExpCollTree
//
//  Created by Vaibhav Kumar on 8/25/15.
//

#import "TreeCell.h"

@implementation TreeCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setViewController:(UIViewController *)controller whetherExpendible:(BOOL)isExp atIndexPath:(NSIndexPath *)indexPath forNode:(VVNodes *)node forCell:(id)cellRef containedPath:(NSArray *)arrTreePath workingRow:(NSInteger)row
{
    if (node.arrNodes.count == 0) {
        [_btnExpColl setHidden:YES];
    }
    if (!isExp) {
        [_btnExpColl setImage:[UIImage imageNamed:@"up"] forState:UIControlStateNormal];
        _btnExpColl.isSelect = NO;
    }else{
        [_btnExpColl setImage:[UIImage imageNamed:@"down"] forState:UIControlStateNormal];
        _btnExpColl.isSelect = YES;
    }
    
    _cntTitleLeading.constant += (node.level * 10);
    
    _lblTitle.text = node.data;
    [_btnExpColl setArrTreePath:arrTreePath];
    [_btnExpColl setIndexPath:indexPath];
    [_btnExpColl setCellRef:cellRef];
    
    [_btnExpColl addTarget:controller action:@selector(ActionExpColl:) forControlEvents:UIControlEventTouchUpInside];
}

- (IBAction)ActionBtn:(VVMyButton *)sender {
    if (sender.isSelect) {
        [_btnExpColl setImage:[UIImage imageNamed:@"up"] forState:UIControlStateNormal];
    }else{
        [_btnExpColl setImage:[UIImage imageNamed:@"down"] forState:UIControlStateNormal];
    }
    sender.isSelect = !sender.isSelect;
}


@end
