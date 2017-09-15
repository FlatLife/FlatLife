//
//  BillsTableViewController.m
//  v9
//
//  Created by Gavin Trebilcock, Josh Lieshout, Max Newall and Shaye Mckay on 5/29/17.
//  Copyright © 2017 Max Newall. All rights reserved.
//

#import "BillsTableViewController.h"
#import "BillDetailViewController.h"
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
                NSString *keyPaidAmount = [[NSString stringWithFormat:@"%i", i] stringByAppendingString:@"billPaidAmount"];
                NSString *keyDescript = [[NSString stringWithFormat:@"%i", i] stringByAppendingString:@"billDescript"];
                
                
                const char *_keyName = [[[NSUserDefaults standardUserDefaults]
                                         stringForKey:keyName] cStringUsingEncoding:NSUTF8StringEncoding];
                const char *_keyDate = [[[NSUserDefaults standardUserDefaults]
                                         stringForKey:keyDate] cStringUsingEncoding:NSUTF8StringEncoding];
                const char *_keyAmount = [[[NSUserDefaults standardUserDefaults]
                                         stringForKey:keyAmount] cStringUsingEncoding:NSUTF8StringEncoding];
                const char *_keyPaidAmount = [[[NSUserDefaults standardUserDefaults]
                                          stringForKey:keyPaidAmount] cStringUsingEncoding:NSUTF8StringEncoding];
                const char *_keyDescript = [[[NSUserDefaults standardUserDefaults]
                                               stringForKey:keyDescript] cStringUsingEncoding:NSUTF8StringEncoding];
                list->setBillObjectValues(_keyName, _keyDate, _keyAmount, _keyPaidAmount, _keyDescript);
                
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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self performSegueWithIdentifier:@"ShowDetail" sender:tableView];
}

//preparing for the transition to the BillsDetailViewController
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"ShowDetail"]) {
        //Pass the variables to the new controller.
        BillDetailViewController *vc = [segue destinationViewController];
        NSIndexPath *path = [self.tableView indexPathForSelectedRow];
        
        NSString *billName = [[NSString stringWithFormat:@"%i", (int)path.row+1] stringByAppendingString:@"billName"];
       // NSString *billDate = [[NSString stringWithFormat:@"%i", (int)path.row+1] stringByAppendingString:@"billDate"];
        NSString *billAmount = [[NSString stringWithFormat:@"%i", (int)path.row+1] stringByAppendingString:@"billAmount"];
        NSString *billPaidAmount = [[NSString stringWithFormat:@"%i", (int)path.row+1] stringByAppendingString:@"billPaidAmount"];
        NSString *billDescript = [[NSString stringWithFormat:@"%i", (int)path.row+1] stringByAppendingString:@"billDescipt"];
        
        NSString *billNameVal = [[NSUserDefaults standardUserDefaults] objectForKey: billName];
       // NSString *billDateVal = [[NSUserDefaults standardUserDefaults] objectForKey: billDate];
        NSString *billAmountVal = [[NSUserDefaults standardUserDefaults] objectForKey: billAmount];
        NSString *billPaidAmountVal = [[NSUserDefaults standardUserDefaults] objectForKey: billPaidAmount];
        NSString *billDescriptVal = [[NSUserDefaults standardUserDefaults] objectForKey: billDescript];
        NSInteger billNum = path.row+1;

        
        vc.billName = billNameVal;
        vc.paidAmount = billPaidAmountVal;
        vc.totalAmount = billAmountVal;
        vc.billDescipt = billDescriptVal;
        vc.billNumber = billNum;
     
    }
}

// method called when user presses the delete button on a specific cell. it then deletes all the data for that cell and then reloads the table data.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    list->billList.erase(list->billList.begin() +  indexPath.row);
    for(int i = (int)indexPath.row+1; i <= list->returnBillListSize(); i++){
        NSString *name = [[NSUserDefaults standardUserDefaults] objectForKey:[[NSString stringWithFormat:@"%i", i+1] stringByAppendingString:@"billName"]];
        NSString *date = [[NSUserDefaults standardUserDefaults] objectForKey:[[NSString stringWithFormat:@"%i", i+1] stringByAppendingString:@"billDate"]];
        NSString *amount = [[NSUserDefaults standardUserDefaults] objectForKey:[[NSString stringWithFormat:@"%i", i+1] stringByAppendingString:@"billAmount"]];
        NSString *paidAmount = [[NSUserDefaults standardUserDefaults] objectForKey:[[NSString stringWithFormat:@"%i", i+1] stringByAppendingString:@"billPaidAmount"]];
        NSString *descript = [[NSUserDefaults standardUserDefaults] objectForKey:[[NSString stringWithFormat:@"%i", i+1] stringByAppendingString:@"billDescript"]];
        
        [[NSUserDefaults standardUserDefaults] setObject:name forKey:[[NSString stringWithFormat:@"%i", i] stringByAppendingString:@"billName"]];
        [[NSUserDefaults standardUserDefaults] setObject:date forKey:[[NSString stringWithFormat:@"%i", i] stringByAppendingString:@"billDate"]];
        [[NSUserDefaults standardUserDefaults] setObject:amount forKey:[[NSString stringWithFormat:@"%i", i] stringByAppendingString:@"billAmount"]];
        [[NSUserDefaults standardUserDefaults] setObject:paidAmount forKey:[[NSString stringWithFormat:@"%i", i] stringByAppendingString:@"billPaidAmount"]];
        [[NSUserDefaults standardUserDefaults] setObject:descript forKey:[[NSString stringWithFormat:@"%i", i] stringByAppendingString:@"billDescript"]];
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
    Bill bill = list->billList[indexPath.row];
    cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    UILabel *amountlabel = [[UILabel alloc] init];
    UILabel *paidlabel = [[UILabel alloc] init];

    amountlabel.text =[[NSString stringWithFormat:@"$"] stringByAppendingString:[NSString stringWithCString:bill.getBillCost().c_str()      encoding:[NSString defaultCStringEncoding]]];
    amountlabel.textColor = [UIColor redColor];
    [amountlabel setFrame:cell.frame];
    amountlabel.textAlignment = NSTextAlignmentRight;
    [cell.contentView addSubview:amountlabel];
    
    paidlabel.text = [[NSString stringWithFormat:@"\t\t\t\t\t\t\t$"] stringByAppendingString:[NSString stringWithCString:bill.getAmountPaid().c_str()      encoding:[NSString defaultCStringEncoding]]];
    paidlabel.textColor = [UIColor greenColor];
    [paidlabel setFrame:cell.frame];
    paidlabel.textAlignment = NSTextAlignmentLeft;
    [cell.contentView addSubview:paidlabel];
    
    cell.textLabel.text = [NSString stringWithCString:bill.getBillName().c_str() encoding:[NSString defaultCStringEncoding]];
    cell.detailTextLabel.text = [NSString stringWithCString:bill.getBillDate().c_str() encoding:[NSString defaultCStringEncoding]];
    return cell;
}


@end
