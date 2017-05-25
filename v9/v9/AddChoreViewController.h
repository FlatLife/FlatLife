//
//  AddChoreViewController.h
//  v9
//
//  Created by Gavin Trebilcock on 5/24/17.
//  Copyright © 2017 Max Newall. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddChoreViewController : UIViewController

@property (strong, nonatomic) IBOutlet UITextField *choreTextField;
@property (strong, nonatomic) IBOutlet UIDatePicker *datePicker;

- (IBAction)addChore;
- (IBAction)cancelAdd;

@end
