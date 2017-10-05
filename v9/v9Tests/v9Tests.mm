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
    list->choreList.clear();
    list->billList.clear();
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
    list->noticeList.clear();
    list->choreList.clear();
    list->billList.clear();
}

- (void)testEmpty {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
    XCTAssertEqual(0, list->returnNoticeListSize());
    XCTAssertEqual(0, list->returnChoreListSize());
}

- (void)testAddNotice {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
    list->setNoticeObjectValues("notice", "Subject");
    XCTAssertEqual(1, list->returnNoticeListSize());
    XCTAssertEqual("notice", list->noticeList[0].getNoticeMessage());
    XCTAssertEqual("Subject", list->noticeList[0].getNoticeSubject());
}

- (void)testAddChore{
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
    list->setChoreObjectValues("Test", "12:57am");
    XCTAssertEqual(1, list->returnChoreListSize());
    XCTAssertEqual("Test", list->choreList[0].getChoreSubject());
    XCTAssertEqual("12:57am", list->choreList[0].getChoreTime());
}

- (void)testAddBill{
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
    list->setBillObjectValues("TestBill", "11-11-2017", "100", "50", "test");
    XCTAssertEqual(1, list->returnBillListSize());
    XCTAssertEqual("TestBill", list->billList[0].getBillName());
    XCTAssertEqual("11-11-2017", list->billList[0].getBillDate());
    XCTAssertEqual("100", list->billList[0].getBillCost());
    XCTAssertEqual("50", list->billList[0].getAmountPaid());
    XCTAssertEqual("test", list->billList[0].getDescript());
}

- (void)testEditBill{
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
    list->setBillObjectValues("TestBill", "11-11-2017", "100", "0", "test");
    XCTAssertEqual(1, list->returnBillListSize());
    XCTAssertEqual("TestBill", list->billList[0].getBillName());
    
    list->billList[0].setName("testEdit");
    XCTAssertEqual("testEdit", list->billList[0].getBillName());
    
    list->billList[0].setDescript("testEditDesc");
    XCTAssertEqual("testEditDesc", list->billList[0].getDescript());
    
    list->billList[0].addPayment("50");
    XCTAssertEqual("50", list->billList[0].getAmountPaid());

}


- (void)testEditChore{
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
    list->setChoreObjectValues("Test", "12:57am");
    XCTAssertEqual(1, list->returnChoreListSize());
    XCTAssertEqual("Test", list->choreList[0].getChoreSubject());
    
    list->choreList[0].setMessage("testEdit");
    XCTAssertEqual("testEdit", list->choreList[0].getChoreSubject());
    
    list->choreList[0].setTime("01:57am");
    XCTAssertEqual("01:57am", list->choreList[0].getChoreTime());
}


- (void)testEditNotice {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
    list->setNoticeObjectValues("notice", "Subject");
    XCTAssertEqual(1, list->returnNoticeListSize());
    XCTAssertEqual("notice", list->noticeList[0].getNoticeMessage());
    
    list->noticeList[0].setSubject("testEdit");
    XCTAssertEqual("testEdit", list->noticeList[0].getNoticeSubject());
    
    list->noticeList[0].setMessage("testEdit");
    XCTAssertEqual("testEdit", list->noticeList[0].getNoticeMessage());
}



@end
