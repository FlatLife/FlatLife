//
//  ListWrapper.hpp
//  TestApp1
//
//  Created by Max Newall on 5/23/17.
//  Copyright © 2017 Max Newall. All rights reserved.
//

#ifndef ListWrapper_hpp
#define ListWrapper_hpp

#include <stdio.h>
#include <vector>
#import "Notice.hpp"
#import "Chore.hpp"


using namespace std;

class ListWrapper {

public:
    static vector<Notice> noticeList;
    void setNoticeObjectValues(string noticeString);
    long returnNoticeListSize();
    string returnStringNoticeListSize();
    
    static vector<Chore> choreList;
    void setChoreObjectValues(string choreString, string timeString);
    long returnChoreListSize();
    string returnStringChoreListSize();
};

#endif /* ListWrapper_hpp */
