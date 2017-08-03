//
//  v9UITests.m
//  v9UITests
//
//  Created by Max Newall on 5/23/17.
//  Copyright © 2017 Max Newall. All rights reserved.
//

#import <XCTest/XCTest.h>

@interface v9UITests : XCTestCase

@end

@implementation v9UITests
    XCUIApplication *app;


- (void)setUp {
    [super setUp];
    
    // Put setup code here. This method is called before the invocation of each test method in the class.
    
    // In UI tests it is usually best to stop immediately when a failure occurs.
    self.continueAfterFailure = NO;
    // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
    
    app = [[XCUIApplication alloc] init];
    [app launch];
    
    
    // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}


- (void)testUIAddNotice {
    //[app.alerts[@"\U201cv9\U201d Would Like to Send You Notifications"].buttons[@"Allow"] tap];
    [app.tabBars.buttons[@"Notices"] tap];
    
    NSUInteger oldCount = app.tables.cells.count;
    
    XCUIElement *addButton = app.navigationBars[@"Notices"].buttons[@"Add"];
    [addButton tap];
    
    XCUIElement *element = [[[app childrenMatchingType:XCUIElementTypeWindow] elementBoundByIndex:0] childrenMatchingType:XCUIElementTypeOther].element;
    XCUIElement *element2 = [[[[element childrenMatchingType:XCUIElementTypeOther].element childrenMatchingType:XCUIElementTypeOther].element childrenMatchingType:XCUIElementTypeOther].element childrenMatchingType:XCUIElementTypeOther].element;
    XCUIElement *textField = [element2 childrenMatchingType:XCUIElementTypeTextField].element;
    [textField tap];
    
    [app.keys[@"t"] tap];
    [app.keys[@"e"] tap];
    [app.keys[@"s"] tap];
    [app.keys[@"t"] tap];
    
    XCUIElement *saveButton = app.navigationBars[@"Add Notice"].buttons[@"Save"];
    [saveButton tap];
    
    XCTAssertEqual(app.tables.cells.count, oldCount+1);
    // Use recording to get started writing UI tests.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
}

- (void)testUIAddChore {
    //[app.alerts[@"\U201cv9\U201d Would Like to Send You Notifications"].buttons[@"Allow"] tap];
    [app.tabBars.buttons[@"Chores"] tap];
    
    NSUInteger oldCount = app.tables.cells.count;
    
    XCUIElement *addButton = app.navigationBars[@"Chores List"].buttons[@"Add"];
    [addButton tap];
    
    XCUIElement *element = [[[app childrenMatchingType:XCUIElementTypeWindow] elementBoundByIndex:0] childrenMatchingType:XCUIElementTypeOther].element;
    XCUIElement *element2 = [[[[element childrenMatchingType:XCUIElementTypeOther].element childrenMatchingType:XCUIElementTypeOther].element childrenMatchingType:XCUIElementTypeOther].element childrenMatchingType:XCUIElementTypeOther].element;
    XCUIElement *textField = [element2 childrenMatchingType:XCUIElementTypeTextField].element;
    [textField tap];
    
    [app.keys[@"t"] tap];
    [app.keys[@"e"] tap];
    [app.keys[@"s"] tap];
    [app.keys[@"t"] tap];
    
    XCUIElement *saveButton = app.navigationBars[@"New Chore"].buttons[@"Save"];
    [saveButton tap];
    
    XCTAssertEqual(app.tables.cells.count, oldCount+1);
    // Use recording to get started writing UI tests.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
}

@end
