//
//  CHOREDetailViewController.m
//  v9
//
//  Created by Gavin Trebilcock AND COPIED by maxlol good on ya gav on 18/09/17.
//  Copyright © 2017 Max Newall. All rights reserved.
//


#import "ChoreDetailViewController.h"
#import "ListWrapper.hpp"
#import "Chore.hpp"

@interface ChoreDetailViewController () {
    ListWrapper *list;
}

@end

@implementation ChoreDetailViewController

@synthesize choreSubjectText;
@synthesize choreSubject;
@synthesize choreTime;
@synthesize choreDate;
@synthesize choreNumber;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //NSLog(@"%@", choreSubject);
    choreSubjectText.text = choreSubject;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                          action:@selector(dismissKeyboard)];
    tap.cancelsTouchesInView = NO;
    [self.view addGestureRecognizer:tap];
    
    
    //self.choreTextView.layer.borderWidth = 1.0f;
    //self.choreTextView.layer.borderColor = [[UIColor colorWithRed:0 green:0 blue:0 alpha:0.1] CGColor];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)saveChore {
    choreSubject = choreSubjectText.text;
    
    NSString *notif = [[NSUserDefaults standardUserDefaults] objectForKey:[[NSString stringWithFormat:@"%ld", choreNumber] stringByAppendingString:@"choreNotif"]];
    UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
    NSArray *array = [NSArray arrayWithObjects:notif,nil];
    [center removePendingNotificationRequestsWithIdentifiers:array];
    
    
    NSDateFormatter *outputFormatter = [[NSDateFormatter alloc] init];
    [outputFormatter setDateFormat:@"h:mm a"];
    
    //setting the notification for the chore.
    _localNotification  = [[UNMutableNotificationContent alloc] init];
    _localNotification.title = [NSString localizedUserNotificationStringForKey:@"Reminder For Chore!" arguments:nil];
    _localNotification.body = [NSString localizedUserNotificationStringForKey:choreSubject arguments:nil];
    _localNotification.sound = [UNNotificationSound defaultSound];
    
    //setting the correct time for the notification
    NSDate *chosen = [choreDate date];
    NSDateComponents* triggerTime = [[NSDateComponents alloc] init];
    NSCalendar *calender = [NSCalendar currentCalendar];
    NSDateComponents *components = [calender components:(NSCalendarUnitHour | NSCalendarUnitMinute) fromDate:chosen];
    triggerTime.hour = [components hour];
    triggerTime.minute = [components minute];
    
    UNCalendarNotificationTrigger* trigger = [UNCalendarNotificationTrigger triggerWithDateMatchingComponents:triggerTime repeats:YES];
    
    _localNotification.badge =@([[UIApplication sharedApplication] applicationIconBadgeNumber] +1);
    //schedule:
    NSNumber *uidNum = [NSNumber numberWithInteger:[NSDate timeIntervalSinceReferenceDate] * 10000];
    NSString *uid = [uidNum stringValue];
    UNNotificationRequest * request = [UNNotificationRequest requestWithIdentifier:uid content: _localNotification trigger:trigger];
    [center addNotificationRequest:request withCompletionHandler:^(NSError * _Nullable error) {
        if (!error){
            NSLog(@"Add NotificationRequest succeeded!");
        }
    }];
    
    
    list->choreList[choreNumber-1].setTime([[outputFormatter stringFromDate:self.choreDate.date] cStringUsingEncoding:NSUTF8StringEncoding]);
    list->choreList[choreNumber-1].setMessage([choreSubject cStringUsingEncoding:NSUTF8StringEncoding]);
    [[NSUserDefaults standardUserDefaults] setObject:choreSubject forKey:[[NSString stringWithFormat:@"%i", (int)choreNumber] stringByAppendingString:@"choreName"]];
    [[NSUserDefaults standardUserDefaults] setObject:[outputFormatter stringFromDate:self.choreDate.date] forKey:[[NSString stringWithFormat:@"%i", (int)choreNumber] stringByAppendingString:@"choreTime"]];
    [[NSUserDefaults standardUserDefaults] setObject:uid forKey:[[NSString stringWithFormat:@"%i", (int)choreNumber] stringByAppendingString:@"choreNotif"]];
    
    [[NSUserDefaults standardUserDefaults] synchronize];
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

- (IBAction)dimissChore {
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)dismissKeyboard {
    [self.view endEditing:true];
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
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
