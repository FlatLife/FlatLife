//
//  AddChoreViewController.h
//  v9
//
//  Created by Gavin Trebilcock, Josh Lieshout, Max Newall and Shaye Mckay on 5/24/17.
//  Copyright © 2017 Max Newall. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <UserNotifications/UserNotifications.h>

@interface AddChoreViewController : UIViewController

@property (strong, nonatomic) IBOutlet UITextField *choreTextField;
@property (strong, nonatomic) IBOutlet UIDatePicker *timePicker;
@property (strong, nonatomic) UNMutableNotificationContent *localNotification;

- (IBAction)addChore;
- (IBAction)cancelAdd;

@end
