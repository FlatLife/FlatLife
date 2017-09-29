//
//  NoticeDetailViewController.m
//  v9
//
//  Created by Gavin Trebilcock on 18/09/17.
//  Copyright © 2017 Max Newall. All rights reserved.
//

#import "NoticeDetailViewController.h"
#import "ListWrapper.hpp"
#import "Notice.hpp"

@interface NoticeDetailViewController () {
    ListWrapper *list;
}

@end

@implementation NoticeDetailViewController

@synthesize noticeSubjectText;
@synthesize noticeSubject;
@synthesize noticeTextView;
@synthesize noticeText;
@synthesize noticeNumber;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    noticeSubjectText.text = noticeSubject;
    noticeTextView.text = noticeText;
    noticeSubjectText.delegate = self;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                          action:@selector(dismissKeyboard)];    
    tap.cancelsTouchesInView = NO;
    [self.view addGestureRecognizer:tap];
    
    
    self.noticeTextView.layer.borderWidth = 1.0f;
    self.noticeTextView.layer.borderColor = [[UIColor colorWithRed:0 green:0 blue:0 alpha:0.1] CGColor];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    if(range.length + range.location > textField.text.length)
    {
        return NO;
    }
    
    NSUInteger newLength = [textField.text length] + [string length] - range.length;
    return newLength <= 20;
}

- (IBAction)saveNotice {
    noticeText = noticeTextView.text;
    noticeSubject = noticeSubjectText.text;
    
    list->noticeList[noticeNumber-1].setMessage([noticeText cStringUsingEncoding:NSUTF8StringEncoding]);
    list->noticeList[noticeNumber-1].setSubject([noticeSubject cStringUsingEncoding:NSUTF8StringEncoding]);
    [[NSUserDefaults standardUserDefaults] setObject:noticeText forKey:[[NSString stringWithFormat:@"%i", (int)noticeNumber] stringByAppendingString:@"NoticeName"]];
    [[NSUserDefaults standardUserDefaults] setObject:noticeSubject forKey:[[NSString stringWithFormat:@"%i", (int)noticeNumber] stringByAppendingString:@"NoticeSubject"]];
    [[NSUserDefaults standardUserDefaults] synchronize];
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

- (IBAction)dimissNotice {
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
