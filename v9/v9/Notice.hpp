//
//  Notice.hpp
//  TestApp1
//
//  Created by Max Newall on 5/23/17.
//  Copyright © 2017 Max Newall. All rights reserved.
//

#ifndef Notice_hpp
#define Notice_hpp

#include <stdio.h>
#include <string>


using namespace std;

class Notice {
    
public:
    string noticeMessage;
    Notice();
    Notice(string noticeMessage);
    string getNoticeMessage();
};

#endif /* Notice_hpp */



// H E A  D E R
