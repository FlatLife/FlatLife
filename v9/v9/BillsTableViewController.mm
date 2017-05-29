//
//  BillsTableViewController.m
//  v9
//
//  Created by Gavin Trebilcock on 5/29/17.
//  Copyright © 2017 Max Newall. All rights reserved.
//

#import "BillsTableViewController.h"
#import "ListWrapper.hpp"
#import "Bill.hpp"

@interface BillsTableViewController () {
    ListWrapper *list;
}

@end

@implementation BillsTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    list = new ListWrapper();
    if(list->returnBillListSize() <= 0){
        if([[NSUserDefaults standardUserDefaults] objectForKey:@"billSize"] != nil){
            NSInteger savedSize = [[[NSUserDefaults standardUserDefaults] objectForKey:@"billSize"] longLongValue];
            for(int i = 1; i <= savedSize; i++){
                NSString *keyName = [[NSString stringWithFormat:@"%i", i] stringByAppendingString:@"billName"];
                NSString *keyDate = [[NSString stringWithFormat:@"%i", i] stringByAppendingString:@"billDate"];
                NSString *keyAmount = [[NSString stringWithFormat:@"%i", i] stringByAppendingString:@"billAmount"];
                
                
                const char *_keyName = [[[NSUserDefaults standardUserDefaults]
                                         stringForKey:keyName] cStringUsingEncoding:NSUTF8StringEncoding];
                const char *_keyDate = [[[NSUserDefaults standardUserDefaults]
                                         stringForKey:keyDate] cStringUsingEncoding:NSUTF8StringEncoding];
                const char *_keyAmount = [[[NSUserDefaults standardUserDefaults]
                                         stringForKey:keyAmount] cStringUsingEncoding:NSUTF8StringEncoding];
                list->setBillObjectValues(_keyName, _keyDate, _keyAmount);
                
            }
        }
    }
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewDidAppear:(BOOL)animated {
    [self.tableView reloadData];
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    list->billList.erase(list->billList.begin() +  indexPath.row);
    for(int i = (int)indexPath.row+1; i <= list->returnBillListSize(); i++){
        printf("%d", i);
        NSString *name = [[NSUserDefaults standardUserDefaults] objectForKey:[[NSString stringWithFormat:@"%i", i+1] stringByAppendingString:@"billName"]];
        NSString *date = [[NSUserDefaults standardUserDefaults] objectForKey:[[NSString stringWithFormat:@"%i", i+1] stringByAppendingString:@"billDate"]];
        NSString *amount = [[NSUserDefaults standardUserDefaults] objectForKey:[[NSString stringWithFormat:@"%i", i+1] stringByAppendingString:@"billAmount"]];
        
        [[NSUserDefaults standardUserDefaults] setObject:name forKey:[[NSString stringWithFormat:@"%i", i] stringByAppendingString:@"billName"]];
        [[NSUserDefaults standardUserDefaults] setObject:date forKey:[[NSString stringWithFormat:@"%i", i] stringByAppendingString:@"billDate"]];
        [[NSUserDefaults standardUserDefaults] setObject:amount forKey:[[NSString stringWithFormat:@"%i", i] stringByAppendingString:@"billAmount"]];
    }
    [[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithLongLong:list->returnBillListSize()] forKey:@"billSize"];
    
    [[NSUserDefaults standardUserDefaults] synchronize];
    [tableView reloadData];
    
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return list->returnBillListSize();
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"BillViewCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell==nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
        
    }
    
    // Configure the cell...
    
    Bill bill = list->billList[indexPath.row];
    cell.textLabel.text = [NSString stringWithCString:bill.getBillName().c_str() encoding:[NSString defaultCStringEncoding]];
    cell.detailTextLabel.text = [NSString stringWithCString:bill.getBillDate().c_str() encoding:[NSString defaultCStringEncoding]];
    
    UILabel *dollarlabel = [[UILabel alloc] init];
    dollarlabel.text = [[NSString stringWithFormat:@"%@", @"$"] stringByAppendingString:[NSString stringWithCString:bill.getBillCost().c_str() encoding:[NSString defaultCStringEncoding]]];
    dollarlabel.textColor = [UIColor redColor];
    [dollarlabel setFrame:cell.frame];
    dollarlabel.textAlignment = NSTextAlignmentRight;
    [cell.contentView addSubview:dollarlabel];
    
    return cell;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
