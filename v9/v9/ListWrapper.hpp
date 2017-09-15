//
//  ListWrapper.hpp
//  TestApp1
//
//  Created by Gavin Trebilcock, Josh Lieshout, Max Newall and Shaye Mckay on 5/23/17.
//  Copyright © 2017 Max Newall. All rights reserved.
//

#ifndef ListWrapper_hpp
#define ListWrapper_hpp

#include <stdio.h>
#include <vector>
#import "Notice.hpp"
#import "Chore.hpp"
#import "Bill.hpp"


using namespace std;

class ListWrapper {

public:
    static vector<Notice> noticeList;
    void setNoticeObjectValues(string noticeString, string noticeSubject);
    long returnNoticeListSize();
    string returnStringNoticeListSize();
    
    static vector<Chore> choreList;
    void setChoreObjectValues(string choreString, string timeString);
    long returnChoreListSize();
    string returnStringChoreListSize();

    static vector<Bill> billList;
    void setBillObjectValues(string billName, string billDate, string cost, string paid, string descript);
    long returnBillListSize();
    string returnStringBillListSize();
};

#endif /* ListWrapper_hpp */
