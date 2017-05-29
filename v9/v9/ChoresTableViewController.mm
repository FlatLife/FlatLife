//
//  NoticesTableViewController.mm
//  TestApp1
//
//  Created by Gavin Trebilcock on 5/24/17.
//  Copyright © 2017 Max Newall. All rights reserved.
//

#import "ChoresTableViewController.h"
#import "Chore.hpp"
#import "ListWrapper.hpp"

@interface ChoresTableViewController () {
    ListWrapper *list;
}

@end


@implementation ChoresTableViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    list = new ListWrapper();
    
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
    list->choreList.erase(list->choreList.begin() +  indexPath.row);
    for(int i = (int)indexPath.row+1; i <= list->returnChoreListSize(); i++){
        printf("%d", i);
        NSString *name = [[NSUserDefaults standardUserDefaults] objectForKey:[[NSString stringWithFormat:@"%i", i+1] stringByAppendingString:@"choreName"]];
        NSString *time = [[NSUserDefaults standardUserDefaults] objectForKey:[[NSString stringWithFormat:@"%i", i+1] stringByAppendingString:@"choreTime"]];
        [[NSUserDefaults standardUserDefaults] setObject:name forKey:[[NSString stringWithFormat:@"%i", i] stringByAppendingString:@"choreName"]];
        [[NSUserDefaults standardUserDefaults] setObject:time forKey:[[NSString stringWithFormat:@"%i", i] stringByAppendingString:@"choreTime"]];
    }
    [[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithLongLong:list->returnChoreListSize()] forKey:@"choreSize"];
    
    [[NSUserDefaults standardUserDefaults] synchronize];
    [tableView reloadData];
    
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return list->returnChoreListSize();
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"ChoreViewCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell==nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
        
    }
    
    // Configure the cell...
    
    Chore chore = list->choreList[indexPath.row];
    cell.textLabel.text = [NSString stringWithCString:chore.getChoreName().c_str() encoding:[NSString defaultCStringEncoding]];
    cell.detailTextLabel.text = [NSString stringWithCString:chore.getChoreTime().c_str() encoding:[NSString defaultCStringEncoding]];
    
    return cell;
}


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
