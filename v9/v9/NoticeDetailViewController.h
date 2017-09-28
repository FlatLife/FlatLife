//
//  NoticeDetailViewController.h
//  v9
//
//  Created by Gavin Trebilcock on 18/09/17.
//  Copyright © 2017 Max Newall. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NoticeDetailViewController : UIViewController<UITextFieldDelegate>


@property (strong, nonatomic) IBOutlet UITextField *noticeSubjectText;
@property (nonatomic, strong) NSString *noticeSubject;
@property (strong, nonatomic) IBOutlet UITextView *noticeTextView;
@property (nonatomic, strong) NSString *noticeText;
@property (nonatomic) NSInteger noticeNumber;

- (IBAction)saveNotice;

@end
