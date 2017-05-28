//
//  AddChoreViewController.mm
//  v9
//
//  Created by Gavin Trebilcock on 5/24/17.
//  Copyright © 2017 Max Newall. All rights reserved.
//

#import "AddChoreViewController.h"
#import "ListWrapper.hpp"
#import "Chore.hpp"

@interface AddChoreViewController ()
{
    IBOutlet UIButton *addChore;
    IBOutlet UIBarButtonItem *cancelAdd;
    
    
}

@end

ListWrapper list = *new ListWrapper();

@implementation AddChoreViewController

@synthesize choreTextField;
@synthesize datePicker;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)addChore {
    //converts the text field string to a cString and passes it to the C++ code
    if(self.choreTextField.text.length > 0){
        NSString *fieldText = self.choreTextField.text;
        
        NSDateFormatter *outputFormatter = [[NSDateFormatter alloc] init];
        [outputFormatter setDateFormat:@"h:mm a"];
        [outputFormatter stringFromDate:self.datePicker.date];
        
        list.setChoreObjectValues([fieldText cStringUsingEncoding:NSUTF8StringEncoding], [[outputFormatter stringFromDate:self.datePicker.date] cStringUsingEncoding:NSUTF8StringEncoding]);
        
        //sets up the strings to be stored locally.
        NSString *keyName = [[NSString stringWithCString:list.returnStringChoreListSize().c_str() encoding:[NSString defaultCStringEncoding]] stringByAppendingString:@"choreName"];
        NSString *keyTime = [[NSString stringWithCString:list.returnStringChoreListSize().c_str() encoding:[NSString defaultCStringEncoding]] stringByAppendingString:@"choreTime"];
        
        //stores the strings with the correct key.
        [[NSUserDefaults standardUserDefaults] setObject:fieldText forKey:keyName];
        [[NSUserDefaults standardUserDefaults] setObject:[outputFormatter stringFromDate:self.datePicker.date] forKey:keyTime];
        [[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithLongLong:list.returnChoreListSize()] forKey:@"choreSize"];
        //saves the data.
        [[NSUserDefaults standardUserDefaults] synchronize];
        
        [self dismissViewControllerAnimated:YES completion:nil];
    }
    //grabs the name of the chore from C++ and sets it to the choreText label
    //self.choreText.text = [NSString stringWithCString:chore.returnChoreName().c_str() encoding:[NSString defaultCStringEncoding]];
    
}

- (IBAction)cancelAdd {
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
