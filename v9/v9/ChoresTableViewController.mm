//
//  NoticesTableViewController.mm
//  TestApp1
//
//  Created by Gavin Trebilcock, Josh Lieshout, Max Newall and Shaye Mckay on 5/24/17.
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

// method called when user presses the delte button on a specific cell. it then deletes all the data for that cell and then reloads the table data.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *notif = [[NSUserDefaults standardUserDefaults] objectForKey:[[NSString stringWithFormat:@"%ld", indexPath.row+1] stringByAppendingString:@"choreNotif"]];
    NSLog(@"hello %@", notif);
    UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
    NSArray *array = [NSArray arrayWithObjects:notif,nil];
    [center removePendingNotificationRequestsWithIdentifiers:array];
    
    list->choreList.erase(list->choreList.begin() +  indexPath.row);
    for(int i = (int)indexPath.row+1; i <= list->returnChoreListSize(); i++){
        NSString *name = [[NSUserDefaults standardUserDefaults] objectForKey:[[NSString stringWithFormat:@"%i", i+1] stringByAppendingString:@"choreName"]];
        NSString *time = [[NSUserDefaults standardUserDefaults] objectForKey:[[NSString stringWithFormat:@"%i", i+1] stringByAppendingString:@"choreTime"]];
        NSString *notif = [[NSUserDefaults standardUserDefaults] objectForKey:[[NSString stringWithFormat:@"%i", i+1] stringByAppendingString:@"choreNotif"]];
        [[NSUserDefaults standardUserDefaults] setObject:name forKey:[[NSString stringWithFormat:@"%i", i] stringByAppendingString:@"choreName"]];
        [[NSUserDefaults standardUserDefaults] setObject:time forKey:[[NSString stringWithFormat:@"%i", i] stringByAppendingString:@"choreTime"]];
        [[NSUserDefaults standardUserDefaults] setObject:notif forKey:[[NSString stringWithFormat:@"%i", i] stringByAppendingString:@"choreNotif"]];
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

@end
