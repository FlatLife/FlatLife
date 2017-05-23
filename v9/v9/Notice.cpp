//
//  Notice.cpp
//  TestApp1
//
//  Created by Max Newall on 5/23/17.
//  Copyright © 2017 Max Newall. All rights reserved.
//

#include "Notice.hpp"

Notice::Notice() {
    isComplete = false;
    noticeMessage = "";
}

Notice::Notice(bool isComplete, string noticeMessage) {
    this->isComplete = isComplete;
    this->noticeMessage = noticeMessage;
}
    
string Notice::getNoticeMessage() {
    return noticeMessage;
}
    
bool Notice::getNoticeState() {
    return isComplete;
}






// C P P
