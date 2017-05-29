//
//  v9Tests.m
//  v9Tests
//
//  Created by Gavin Trebilcock, Josh Lieshout, Max Newall and Shaye Mckay on 5/23/17.
//  Copyright © 2017 Max Newall. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "ListWrapper.hpp"
#import "Notice.hpp"

@interface v9Tests : XCTestCase

@end

@implementation v9Tests
    ListWrapper *list;


- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
    list->noticeList.clear();
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
    list->noticeList.clear();
}

- (void)testEmpty {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
    XCTAssertEqual(0, list->returnNoticeListSize());
}

- (void)testAddNotice {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
    list->setNoticeObjectValues("Test");
    XCTAssertEqual(1, list->returnNoticeListSize());
    XCTAssertEqual("Test", list->noticeList[0].getNoticeMessage());
}

- (void)testAddChore{
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
    list->setChoreObjectValues("Test", "12:57am");
    XCTAssertEqual(1, list->returnChoreListSize());
    XCTAssertEqual("Test", list->choreList[0].getChoreName());
    XCTAssertEqual("12:57am", list->choreList[0].getChoreTime());
}

//- (void)testPerformanceExample {
//    // This is an example of a performance test case.
//    [self measureBlock:^{
//        // Put the code you want to measure the time of here.
//    }];
//}

@end
