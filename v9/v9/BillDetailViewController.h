//
//  BillDetailViewController.h
//  v9
//
//  Created by Gavin Trebilcock on 8/3/17.
//  Copyright © 2017 Max Newall. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BillDetailViewController : UIViewController<UITextFieldDelegate>

@property (strong, nonatomic) IBOutlet UITextField *nameLabel;
@property (nonatomic, strong) NSString *billName;
@property (strong, nonatomic) IBOutlet UILabel *paidLabel;
@property (nonatomic, strong) NSString *paidAmount;
@property (strong, nonatomic) IBOutlet UILabel *totalLabel;
@property (nonatomic, strong) NSString *totalAmount;
@property (strong, nonatomic) IBOutlet UITextView *billDesciptView;
@property (nonatomic, strong) NSString *billDescipt;
@property (strong, nonatomic) IBOutlet UITextField *paymentField;
@property (nonatomic) NSInteger billNumber;

- (IBAction)saveBill;
- (IBAction)updateBill;

@end
