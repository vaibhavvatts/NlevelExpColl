//
//  ViewController.m
//  ExpCollTree
//
//  Created by Vaibhav Kumar on 8/25/15.

#import "ViewController.h"
#import "VVTreeFeeding.h"
#import "VVNodes.h"
#import "TreeCell.h"
#import "VVMyButton.h"

@interface ViewController ()<UITableViewDataSource, UITableViewDelegate>
{
    __weak IBOutlet UITableView *tblTree;
    VVNodes *root;
    NSMutableArray *arrContainer;
    NSInteger numberOfRows;
    VVNodes *reachedNode;
    VVTreeFeeding *feedTree;
    NSMutableArray *arrTreePath;
}

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    arrContainer = [[NSMutableArray alloc]init];
    arrTreePath = [[NSMutableArray alloc]init];
    [self createFakeData];
    [tblTree setSeparatorStyle:UITableViewCellSeparatorStyleNone];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)createFakeData
{
    
    
    NSMutableArray *arrLevels = [[NSMutableArray alloc]initWithObjects:
                               @"1",
                                @"2",
                                @"2",
                                 @"3",
                                  @"4",
                                  @"4",
                                   @"5",
                               @"1",
                               @"1",
                                @"2",
                                 @"3",
                                  @"4",
                                   @"5",
                                    @"6",
                                     @"7",
                                      @"8",
                                       @"9",
                                        @"10",
                                         @"11",
                               nil];
    
    NSMutableArray *arrData = [[NSMutableArray alloc]init];
    for (NSString *strLvl in arrLevels) {
        [arrData addObject:[NSString stringWithFormat:@"Level %@",strLvl]];
    }
    
    feedTree = [[VVTreeFeeding alloc]init];
    root = [feedTree FeedData:arrData withLevel:arrLevels];
    reachedNode = root;
    numberOfRows = 0;
    
    for (int i =0; i< root.arrNodes.count; i++) {
        [arrTreePath addObject:[NSString stringWithFormat:@"%d",i]];
        numberOfRows++;
    }
}

-(void)ActionExpColl:(VVMyButton *)btn
{
    NSInteger row = [tblTree indexPathForCell:btn.cellRef].row;

    NSInteger rowsToOperate = 0;
    VVNodes *node = [feedTree reachNodePositionToLevel:[arrTreePath objectAtIndex:row] startNode:root];
    NSString *key = [arrTreePath objectAtIndex:row];
    
    if ([arrContainer containsObject:key]) {
        NSMutableArray *removeableObj = [[NSMutableArray alloc]init];
        [arrContainer removeObject:key];
        for (NSString *tmp  in arrTreePath) {
            if ([tmp hasPrefix:key] && ![tmp isEqualToString:key]) {
                [removeableObj addObject:tmp];
                rowsToOperate++;
            }else{
                if ((rowsToOperate != 0) ) {
                    break;
                }
            }
        }
        for (NSString *tmp in removeableObj) {
            [arrContainer removeObject:tmp];
        }
        for (int i=0;i<rowsToOperate;i++) {
            numberOfRows--;
            NSIndexPath *indexSectionsToInsert = [NSIndexPath indexPathForRow:row+1 inSection:0];
            [arrTreePath removeObjectAtIndex:row+1];
            [tblTree beginUpdates];
            [tblTree deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexSectionsToInsert] withRowAnimation:UITableViewRowAnimationNone];
            [tblTree endUpdates];
        }
        
    }else{
        for (NSInteger i =0; i< node.arrNodes.count; i++) {
            NSString *pathToInsert = [NSString stringWithFormat:@"%@_%ld",[arrTreePath objectAtIndex:row],(long)i];
            [arrTreePath insertObject:pathToInsert atIndex:row+i+1];
            rowsToOperate++;
        }
        [arrContainer addObject:key];
        for (int i=0;i<rowsToOperate;i++) {
            numberOfRows++;
            NSIndexPath *indexSectionsToInsert = [NSIndexPath indexPathForRow:i+row+1 inSection:0];
            [tblTree beginUpdates];
            [tblTree insertRowsAtIndexPaths:[NSArray arrayWithObject:indexSectionsToInsert] withRowAnimation:UITableViewRowAnimationNone];
            [tblTree endUpdates];
        }
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return numberOfRows;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TreeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Mycell"];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"TreeCell" owner:self options:nil] objectAtIndex:0];
    }
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    VVNodes *node = [feedTree reachNodePositionToLevel:[arrTreePath objectAtIndex:indexPath.row] startNode:root];
    NSString *key = [arrTreePath objectAtIndex:indexPath.row];
    [cell setViewController:self whetherExpendible:[arrContainer containsObject:key] atIndexPath:indexPath forNode:node forCell:cell containedPath:arrTreePath workingRow:indexPath.row];
    
    return cell;
}

@end
