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
}

Notice::Notice(string noticeMessage) {
    this->noticeMessage = noticeMessage;
}
    
string Notice::getNoticeMessage() {
    return noticeMessage;
}





// C P P
