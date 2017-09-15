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
    billDesciptView.text = billDescipt;
    
    self.billDesciptView.layer.borderWidth = 1.0f;
    self.billDesciptView.layer.borderColor = [[UIColor colorWithRed:0 green:0 blue:0 alpha:0.1] CGColor];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    
    list->billList[billNumber-1].addPayment([paidAmount cStringUsingEncoding:NSUTF8StringEncoding]);
    [[NSUserDefaults standardUserDefaults] setObject:paidAmount forKey:[[NSString stringWithFormat:@"%i", (int)billNumber] stringByAppendingString:@"billPaidAmount"]];
    [[NSUserDefaults standardUserDefaults] synchronize];
    [self viewDidLoad];
    [self viewWillAppear:YES];
    
}

- (IBAction)saveBill {
    billDescipt = billDesciptView.text;
    list->billList[billNumber-1].setDescript([billDescipt cStringUsingEncoding:NSUTF8StringEncoding]);
    [[NSUserDefaults standardUserDefaults] setObject:billDescipt forKey:[[NSString stringWithFormat:@"%i", (int)billNumber] stringByAppendingString:@"billDescript"]];
    [[NSUserDefaults standardUserDefaults] synchronize];
    [self dismissViewControllerAnimated:YES completion:nil];

    
}

- (IBAction)dimissBill {
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
