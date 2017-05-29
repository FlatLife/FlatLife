//
//  CustomTwoTableViewController.m
//  v9
//
//  Created by Max Newall on 5/28/17.
//  Copyright © 2017 Max Newall. All rights reserved.
//

#import "CustomTwoTableViewController.h"
#import "Notice.hpp"
#import "Chore.hpp"
#import "ListWrapper.hpp"
#import <string>

@interface CustomTwoTableViewController () <UITableViewDataSource, UITabBarDelegate, UITableViewDelegate> {
    ListWrapper *list;
}

@property (weak, nonatomic) IBOutlet UITableView *firstTable;
@property (weak, nonatomic) IBOutlet UITableView *secondTable;

@end


@implementation CustomTwoTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.secondTable.dataSource = self;
    self.secondTable.delegate = self;
    
    self.firstTable.dataSource = self;
    self.firstTable.delegate = self;
    
    if(list->returnChoreListSize() <= 0){
        if([[NSUserDefaults standardUserDefaults] objectForKey:@"choreSize"] != nil){
            NSInteger savedSize = [[[NSUserDefaults standardUserDefaults] objectForKey:@"choreSize"] longLongValue];
            for(int i = 1; i <= savedSize; i++){
                NSString *keyName = [[NSString stringWithFormat:@"%i", i] stringByAppendingString:@"choreName"];
                NSString *keyTime = [[NSString stringWithFormat:@"%i", i] stringByAppendingString:@"choreTime"];
                
                
                const char *_keyName = [[[NSUserDefaults standardUserDefaults]
                                         stringForKey:keyName] cStringUsingEncoding:NSUTF8StringEncoding];
                const char *_keyTime = [[[NSUserDefaults standardUserDefaults]
                                         stringForKey:keyTime] cStringUsingEncoding:NSUTF8StringEncoding];
                list->setChoreObjectValues(_keyName, _keyTime);
                
            }
        }
    }
    
    if(list->returnNoticeListSize() <= 0){
        if([[NSUserDefaults standardUserDefaults] objectForKey:@"NoticeSize"] != nil){
            NSInteger savedSize = [[[NSUserDefaults standardUserDefaults] objectForKey:@"NoticeSize"] longLongValue];
            for(int i = 1; i <= savedSize; i++){
                NSString *keyName = [[NSString stringWithFormat:@"%i", i] stringByAppendingString:@"NoticeName"];
                
                
                const char *_keyName = [[[NSUserDefaults standardUserDefaults]
                                         stringForKey:keyName] cStringUsingEncoding:NSUTF8StringEncoding];
                list->setNoticeObjectValues(_keyName);
                
            }
        }
    }
    
}

-(void)viewDidAppear:(BOOL)animated{
    [self.firstTable reloadData];
    [self.secondTable reloadData];
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // chores table
    if (tableView == self.firstTable) {
        return list->returnChoreListSize();
    }
    // notices table
    if (tableView == self.secondTable){
        return list->returnNoticeListSize();
    }
    return 0;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"ChoreViewCell";
    static NSString *CellIdentifier2 = @"NotificationViewCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    UITableViewCell *cell2 = [tableView dequeueReusableCellWithIdentifier:CellIdentifier2];
    
    if (cell==nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    
    if (cell2==nil) {
        cell2 = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier2];
    }
    
    // Configure the cell...
    if (tableView == self.firstTable) {
        cell.textLabel.text = [NSString stringWithFormat:@"First Table"];
        cell.textLabel.font = [UIFont fontWithName:@"Avenir Next Demi Bold" size:16.0f];
        cell.textLabel.textColor =
        [UIColor colorWithRed:75.0/255.0 green:75.0/255.0 blue:75.0/255.0 alpha:1];
        
        // E R R O R V VV V V
        Chore chore = list->choreList[indexPath.row];
        cell.textLabel.text = [NSString stringWithCString:chore.getChoreName().c_str() encoding:[NSString defaultCStringEncoding]];
        cell.detailTextLabel.text = [NSString stringWithCString:chore.getChoreTime().c_str() encoding:[NSString defaultCStringEncoding]];
        return cell;
    }
    
    if (tableView == self.secondTable) {
        cell2.textLabel.text = [NSString stringWithFormat:@"Second Table"];
        cell2.textLabel.font = [UIFont fontWithName:@"Avenir Next Demi Bold" size:16.0f];
        cell2.textLabel.textColor =
        [UIColor colorWithRed:75.0/255.0 green:75.0/255.0 blue:75.0/255.0 alpha:1];
        // E R R O R V VV V V
        Notice notice = list->noticeList[indexPath.row];
        cell2.textLabel.text = [NSString stringWithCString:notice.getNoticeMessage().c_str() encoding:[NSString defaultCStringEncoding]];
        return cell2;
    }
   
    return cell;
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
