//
//  Notice.hpp
//  TestApp1
//
//  Created by Gavin Trebilcock, Josh Lieshout, Max Newall and Shaye Mckay on 5/23/17.
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
    string noticeSubject;
    Notice();
    Notice(string noticeMessage, string noticeSubject);
    string getNoticeMessage();
    string getNoticeSubject();
    void setMessage(string text);
    void setSubject(string text);
};

#endif /* Notice_hpp */



// H E A  D E R
