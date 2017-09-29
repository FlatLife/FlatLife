//
//  AddNoticeViewController.m
//  v9
//
//  Created by Gavin Trebilcock, Josh Lieshout, Max Newall and Shaye Mckay on 5/24/17.
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
@synthesize subjectText;

- (void)viewDidLoad {
    [super viewDidLoad];
    self.noticeText.layer.borderWidth = 1.0f;
    self.noticeText.layer.borderColor = [[UIColor colorWithRed:0 green:0 blue:0 alpha:0.1] CGColor];
    
    subjectText.delegate = self;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                          action:@selector(dismissKeyboard)];
    
    tap.cancelsTouchesInView = NO;
    [self.view addGestureRecognizer:tap];
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

-(void)dismissKeyboard {
    [self.view endEditing:true];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction) cancelPressed {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    if(range.length + range.location > textField.text.length)
    {
        return NO;
    }
    
    NSUInteger newLength = [textField.text length] + [string length] - range.length;
    return newLength <= 20;
}

- (IBAction)saveButton {
    NSString *subjectFieldText = subjectText.text;
    NSString *noticeFieldText = noticeText.text;
    
    if ([noticeFieldText length] > 0) {
        string objectString = [noticeFieldText cStringUsingEncoding:NSUTF8StringEncoding];
        string objectSubject = [subjectFieldText cStringUsingEncoding:NSUTF8StringEncoding];
        list->setNoticeObjectValues(objectString, objectSubject);
        
        //sets up the strings to be stored locally.
        NSString *keyName = [[NSString stringWithCString:list->returnStringNoticeListSize().c_str() encoding:[NSString defaultCStringEncoding]] stringByAppendingString:@"NoticeName"];
        NSString *keySubject = [[NSString stringWithCString:list->returnStringNoticeListSize().c_str() encoding:[NSString defaultCStringEncoding]] stringByAppendingString:@"NoticeSubject"];
        
        //stores the strings with the correct key.
        [[NSUserDefaults standardUserDefaults] setObject:noticeFieldText forKey:keyName];
        [[NSUserDefaults standardUserDefaults] setObject:subjectFieldText forKey:keySubject];
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
