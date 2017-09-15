//
//  Notice.cpp
//  TestApp1
//
//  Created by Gavin Trebilcock, Josh Lieshout, Max Newall and Shaye Mckay on 5/23/17.
//  Copyright © 2017 Max Newall. All rights reserved.
//

#include "Notice.hpp"

Notice::Notice() {
    noticeMessage = "";
    noticeSubject = "";
}

Notice::Notice(string noticeMessage, string noticeSubject) {
    this->noticeMessage = noticeMessage;
    this->noticeSubject = noticeSubject;
}
    
string Notice::getNoticeMessage() {
    return noticeMessage;
}

string Notice::getNoticeSubject() {
    return noticeSubject;
}





// C P P
