//
//  AddBillViewController.mm
//  v9
//
//  Created by Gavin Trebilcock, Josh Lieshout, Max Newall and Shaye Mckay on 5/29/17.
//  Copyright © 2017 Max Newall. All rights reserved.
//

#import "AddBillViewController.h"
#import "ListWrapper.hpp"
#import "Bill.hpp"

@interface AddBillViewController ()
{
    IBOutlet UIBarButtonItem *createBill;
    IBOutlet UIBarButtonItem *cancelCreate;
}

@end

ListWrapper listObj = *new ListWrapper();

@implementation AddBillViewController

@synthesize datePicker;
@synthesize nameField;
@synthesize descriptField;
@synthesize amountField;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.descriptField.layer.borderWidth = 1.0f;
    self.descriptField.layer.borderColor = [[UIColor colorWithRed:0 green:0 blue:0 alpha:0.1] CGColor];
    nameField.delegate = self;
    amountField.delegate = self;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                          action:@selector(dismissKeyboard)];
    
    tap.cancelsTouchesInView = NO;
    [self.view addGestureRecognizer:tap];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    if(range.length + range.location > textField.text.length)
    {
        return NO;
    }
    
    NSUInteger newLength = [textField.text length] + [string length] - range.length;
    return newLength <= 12;
}

-(void)dismissKeyboard {
    [self.view endEditing:true];
}


- (IBAction)createBill {
    if(self.nameField.text.length > 0){
        NSString *nameText = self.nameField.text;
        NSString *amountText = self.amountField.text;
        NSString *descriptText = self.descriptField.text;
        
        NSDateFormatter *outputFormatter = [[NSDateFormatter alloc] init];
        [outputFormatter setDateFormat:@"EEE, d MMM yyyy"];
        [outputFormatter stringFromDate:self.datePicker.date];
        
        //setting the notification for the chore.
        _localNotification  = [[UNMutableNotificationContent alloc] init];
        _localNotification.title = [NSString localizedUserNotificationStringForKey:@"Reminder For Payment!" arguments:nil];
        _localNotification.body = [NSString localizedUserNotificationStringForKey:nameText arguments:nil];
        _localNotification.sound = [UNNotificationSound defaultSound];
        
        //setting the correct time for the notification
        NSDate *chosen = [datePicker date];
        NSCalendar *calender = [NSCalendar currentCalendar];
        NSDateComponents* triggerDate = [[NSDateComponents alloc] init];
        NSDateComponents *components = [calender components:(NSCalendarUnitHour | NSCalendarUnitMinute| NSCalendarUnitHour | NSCalendarUnitMinute) fromDate:chosen];
        [components setHour:10];
        [components setMinute:00];
        triggerDate.hour = [components hour];
        triggerDate.minute = [components minute];
        triggerDate.day = [components day];
        triggerDate.month = [components month];
        triggerDate.year = [components year];
        
        UNCalendarNotificationTrigger* trigger = [UNCalendarNotificationTrigger triggerWithDateMatchingComponents:triggerDate repeats:YES];
        
        _localNotification.badge =@([[UIApplication sharedApplication] applicationIconBadgeNumber] +1);
        //schedule:
        UNNotificationRequest * request = [UNNotificationRequest requestWithIdentifier:@"Time Down" content: _localNotification trigger:trigger];
        UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
        [center addNotificationRequest:request withCompletionHandler:^(NSError * _Nullable error) {
            if (!error){
                NSLog(@"Add NotificationRequest succeeded!");
            }
        }];
        
        listObj.setBillObjectValues([nameText cStringUsingEncoding:NSUTF8StringEncoding], [[outputFormatter stringFromDate:self.datePicker.date] cStringUsingEncoding:NSUTF8StringEncoding], [amountText cStringUsingEncoding:NSUTF8StringEncoding], [@"0" cStringUsingEncoding:NSUTF8StringEncoding], [nameText cStringUsingEncoding:NSUTF8StringEncoding]);
        
        //sets up the strings to be stored locally.
        NSString *keyName = [[NSString stringWithCString:listObj.returnStringBillListSize().c_str() encoding:[NSString defaultCStringEncoding]] stringByAppendingString:@"billName"];
        NSString *keyDate = [[NSString stringWithCString:listObj.returnStringBillListSize().c_str() encoding:[NSString defaultCStringEncoding]] stringByAppendingString:@"billDate"];
        NSString *keyAmount = [[NSString stringWithCString:listObj.returnStringBillListSize().c_str() encoding:[NSString defaultCStringEncoding]] stringByAppendingString:@"billAmount"];
        NSString *keyPaidAmount = [[NSString stringWithCString:listObj.returnStringBillListSize().c_str() encoding:[NSString defaultCStringEncoding]] stringByAppendingString:@"billPaidAmount"];
        NSString *keyDescript = [[NSString stringWithCString:listObj.returnStringBillListSize().c_str() encoding:[NSString defaultCStringEncoding]] stringByAppendingString:@"billDescript"];
        
        //stores the strings with the correct key.
        [[NSUserDefaults standardUserDefaults] setObject:nameText forKey:keyName];
        [[NSUserDefaults standardUserDefaults] setObject:[outputFormatter stringFromDate:self.datePicker.date] forKey:keyDate];
        [[NSUserDefaults standardUserDefaults] setObject:amountText forKey:keyAmount];
        [[NSUserDefaults standardUserDefaults] setObject:@"0" forKey:keyPaidAmount];
        [[NSUserDefaults standardUserDefaults] setObject:descriptText forKey:keyDescript];
        [[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithLongLong:listObj.returnBillListSize()] forKey:@"billSize"];
        
        //saves the data.
        [[NSUserDefaults standardUserDefaults] synchronize];
        
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}


- (IBAction)cancelCreate {
    [self dismissViewControllerAnimated:YES completion:nil];
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
