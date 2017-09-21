//
//  BillDetailViewController.m
//  v9
//
//  Created by Gavin Trebilcock on 8/3/17.
//  Copyright © 2017 Max Newall. All rights reserved.
//

#import "BillDetailViewController.h"
#import "ListWrapper.hpp"
#import "Bill.hpp"

@interface BillDetailViewController () {
    ListWrapper *list;
}


@end

@implementation BillDetailViewController

@synthesize nameLabel;
@synthesize billName;
@synthesize paidLabel;
@synthesize paidAmount;
@synthesize totalLabel;
@synthesize totalAmount;
@synthesize paymentField;
@synthesize billDesciptView;
@synthesize billDescipt;
@synthesize billNumber;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    nameLabel.text = billName;
    paidLabel.text = [@"$" stringByAppendingString:paidAmount];
    totalLabel.text = [@"$" stringByAppendingString:totalAmount];
    paymentField.delegate = self;
    nameLabel.delegate = self;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                          action:@selector(dismissKeyboard)];
    
    tap.cancelsTouchesInView = NO;
    [self.view addGestureRecognizer:tap];
    billDesciptView.text = billDescipt;
    
    self.billDesciptView.layer.borderWidth = 1.0f;
    self.billDesciptView.layer.borderColor = [[UIColor colorWithRed:0 green:0 blue:0 alpha:0.1] CGColor];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)dismissKeyboard {
    [self.view endEditing:true];
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

- (IBAction)updateBill {
    NSInteger paymentNum = [self.paymentField.text intValue];
    NSInteger paidAmountNum = [paidAmount intValue];
    NSInteger totalAmountNum = [totalAmount intValue];
    if((paidAmountNum + paymentNum) >= totalAmountNum){
        paidAmount = [NSString stringWithFormat:@"%i", (int)totalAmountNum];
        paidLabel.text = [@"$" stringByAppendingString:paidAmount];
    } else {
        paidAmount = [NSString stringWithFormat:@"%i", (int)(paidAmountNum + paymentNum)];
        paidLabel.text = [@"$" stringByAppendingString:paidAmount];
    }
    
    NSString *tempDescript = billDesciptView.text;
    
    list->billList[billNumber-1].addPayment([paidAmount cStringUsingEncoding:NSUTF8StringEncoding]);
    [[NSUserDefaults standardUserDefaults] setObject:paidAmount forKey:[[NSString stringWithFormat:@"%i", (int)billNumber] stringByAppendingString:@"billPaidAmount"]];
    [[NSUserDefaults standardUserDefaults] synchronize];
    [self viewDidLoad];
    [self viewWillAppear:YES];
    
    billDesciptView.text = tempDescript;
}

- (IBAction)saveBill {
    billDescipt = billDesciptView.text;
    billName = nameLabel.text;
    list->billList[billNumber-1].setDescript([billDescipt cStringUsingEncoding:NSUTF8StringEncoding]);
    list->billList[billNumber-1].setName([billName cStringUsingEncoding:NSUTF8StringEncoding]);
    [[NSUserDefaults standardUserDefaults] setObject:billDescipt forKey:[[NSString stringWithFormat:@"%i", (int)billNumber] stringByAppendingString:@"billDescript"]];
    [[NSUserDefaults standardUserDefaults] setObject:billName forKey:[[NSString stringWithFormat:@"%i", (int)billNumber] stringByAppendingString:@"billName"]];
    [[NSUserDefaults standardUserDefaults] synchronize];
    [self dismissViewControllerAnimated:YES completion:nil];

    
}

- (IBAction)dimissBill {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    if(range.length + range.location > textField.text.length)
    {
        return NO;
    }
    
    NSUInteger newLength = [textField.text length] + [string length] - range.length;
    return newLength <= 12;
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
