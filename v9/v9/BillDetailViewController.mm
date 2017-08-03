//
//  BillDetailViewController.m
//  v9
//
//  Created by Gavin Trebilcock on 8/3/17.
//  Copyright © 2017 Max Newall. All rights reserved.
//

#import "BillDetailViewController.h"

@interface BillDetailViewController ()

@end

@implementation BillDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)updatePayment {
    //implement
    //add paid amount to the current bill object
}

- (IBAction)saveBill {
    //implement
    //check if any payments have been made
    //overwrite the bill object with the new values
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
