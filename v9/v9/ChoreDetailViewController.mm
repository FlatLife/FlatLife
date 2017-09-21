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
    list->choreList[choreNumber-1].setMessage([choreSubject cStringUsingEncoding:NSUTF8StringEncoding]);
    [[NSUserDefaults standardUserDefaults] setObject:choreSubject forKey:[[NSString stringWithFormat:@"%i", (int)choreNumber] stringByAppendingString:@"choreName"]];
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
