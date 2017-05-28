//
//  AddNoticeViewController.m
//  v9
//
//  Created by Max Newall on 5/24/17.
//  Copyright © 2017 Max Newall. All rights reserved.
//

#import "AddNoticeViewController.h"
#import "ListWrapper.hpp"
#import "Notice.hpp"
#import "NoticesTableViewController.h"

@interface AddNoticeViewController ()
{
    ListWrapper *list;
}

@end


@implementation AddNoticeViewController

@synthesize noticeText;

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction) cancelPressed {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)saveButton {
    NSString *fieldText = noticeText.text;
    if ([fieldText length] > 0) {
        string objectString = [fieldText cStringUsingEncoding:NSUTF8StringEncoding];
        list->setNoticeObjectValues(objectString);
        
        //sets up the strings to be stored locally.
        NSString *keyName = [[NSString stringWithCString:list->returnStringChoreListSize().c_str() encoding:[NSString defaultCStringEncoding]] stringByAppendingString:@"NoticeName"];
        
        //stores the strings with the correct key.
        [[NSUserDefaults standardUserDefaults] setObject:fieldText forKey:keyName];
        [[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithLongLong:list->returnNoticeListSize()] forKey:@"NoticeSize"];
        //saves the data.
        [[NSUserDefaults standardUserDefaults] synchronize];
        
        [self dismissViewControllerAnimated:YES completion:nil];
    } else {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
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
