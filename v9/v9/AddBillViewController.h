//
//  AddBillViewController.h
//  v9
//
//  Created by Gavin Trebilcock, Josh Lieshout, Max Newall and Shaye Mckay on 5/29/17.
//  Copyright © 2017 Max Newall. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <UserNotifications/UserNotifications.h>

@interface AddBillViewController : UIViewController<UITextFieldDelegate>

@property (strong, nonatomic) IBOutlet UIDatePicker *datePicker;
@property (strong, nonatomic) IBOutlet UITextField *nameField;
@property (strong, nonatomic) IBOutlet UITextField *amountField;
@property (strong, nonatomic) UNMutableNotificationContent *localNotification;


- (IBAction)createBill;
- (IBAction)cancelCreate;

@end
