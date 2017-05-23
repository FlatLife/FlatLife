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

using namespace std;

class ListWrapper {

public:
    vector<Notice> noticeList;
    //string getListMessage();
    bool getListMessageState();
    void setObjectValues(string objectString, bool objectState);
    long returnListSize();
};

#endif /* ListWrapper_hpp */
