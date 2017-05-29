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
@synthesize amountField;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)createBill {
    if(self.nameField.text.length > 0){
        NSString *nameText = self.nameField.text;
        NSString *amountText = self.amountField.text;
        
        NSDateFormatter *outputFormatter = [[NSDateFormatter alloc] init];
        [outputFormatter setDateFormat:@"EEE, d MMM yyyy"];
        [outputFormatter stringFromDate:self.datePicker.date];
        
        listObj.setBillObjectValues([nameText cStringUsingEncoding:NSUTF8StringEncoding], [[outputFormatter stringFromDate:self.datePicker.date] cStringUsingEncoding:NSUTF8StringEncoding], [amountText cStringUsingEncoding:NSUTF8StringEncoding]);
        
        //sets up the strings to be stored locally.
        NSString *keyName = [[NSString stringWithCString:listObj.returnStringBillListSize().c_str() encoding:[NSString defaultCStringEncoding]] stringByAppendingString:@"billName"];
        NSString *keyDate = [[NSString stringWithCString:listObj.returnStringBillListSize().c_str() encoding:[NSString defaultCStringEncoding]] stringByAppendingString:@"billDate"];
        NSString *keyAmount = [[NSString stringWithCString:listObj.returnStringBillListSize().c_str() encoding:[NSString defaultCStringEncoding]] stringByAppendingString:@"billAmount"];
        
        //stores the strings with the correct key.
        [[NSUserDefaults standardUserDefaults] setObject:nameText forKey:keyName];
        [[NSUserDefaults standardUserDefaults] setObject:[outputFormatter stringFromDate:self.datePicker.date] forKey:keyDate];
        [[NSUserDefaults standardUserDefaults] setObject:amountText forKey:keyAmount];
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
