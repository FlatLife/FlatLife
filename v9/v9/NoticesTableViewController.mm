//
//  NoticesTableViewController.m
//  TestApp1
//
//  Created by Max Newall on 5/18/17.
//  Copyright © 2017 Max Newall. All rights reserved.
//

#import "NoticesTableViewController.h"
#import "Notice.hpp"
#import "ListWrapper.hpp"

@interface NoticesTableViewController () {
    ListWrapper *list;
    IBOutlet UITableView *tableRef;
}

@end


@implementation NoticesTableViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    list = new ListWrapper();
}

-(void)viewDidAppear:(BOOL)animated{
    [self.tableView reloadData];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return list->returnNoticeListSize();
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"NotificationViewCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell==nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
        
    }
    
    // Configure the cell...
    
    Notice notice = list->noticeList[indexPath.row];
    cell.textLabel.text = [NSString stringWithCString:notice.getNoticeMessage().c_str() encoding:[NSString defaultCStringEncoding]];
    //[self.tableView reloadData];
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    list->noticeList.erase(list->noticeList.begin() +  indexPath.row);
    
    for(int i = (int)indexPath.row+1; i <= list->returnNoticeListSize(); i++){
        printf("%d", i);
        NSString *name = [[NSUserDefaults standardUserDefaults] objectForKey:[[NSString stringWithFormat:@"%i", i+1] stringByAppendingString:@"NoticeName"]];
        [[NSUserDefaults standardUserDefaults] setObject:name forKey:[[NSString stringWithFormat:@"%i", i] stringByAppendingString:@"NoticeName"]];
    }
    [[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithLongLong:list->returnNoticeListSize()] forKey:@"NoticeSize"];
    
     [[NSUserDefaults standardUserDefaults] synchronize];
    [tableView reloadData];
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
