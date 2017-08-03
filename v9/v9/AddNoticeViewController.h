//
//  AddNoticeViewController.h
//  v9
//
//  Created by Gavin Trebilcock, Josh Lieshout, Max Newall and Shaye Mckay on 5/25/17.
//  Copyright © 2017 Max Newall. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddNoticeViewController : UIViewController<UITextFieldDelegate>

@property (strong, nonatomic) IBOutlet UITextField *noticeText;

@end
