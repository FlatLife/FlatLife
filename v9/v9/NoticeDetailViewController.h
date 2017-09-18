//
//  NoticeDetailViewController.h
//  v9
//
//  Created by Gavin Trebilcock on 18/09/17.
//  Copyright © 2017 Max Newall. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NoticeDetailViewController : UIViewController

@property (strong, nonatomic) IBOutlet UILabel *noticeSubjectLabel;
@property (nonatomic, strong) NSString *noticeSubject;
@property (strong, nonatomic) IBOutlet UITextView *noticeTextView;
@property (nonatomic, strong) NSString *noticeText;
@property (nonatomic) NSInteger noticeNumber;

- (IBAction)saveNotice;

@end
