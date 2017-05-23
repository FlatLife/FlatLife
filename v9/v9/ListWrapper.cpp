//
//  ListWrapper.cpp
//  TestApp1
//
//  Created by Max Newall on 5/23/17.
//  Copyright © 2017 Max Newall. All rights reserved.
//

#include "ListWrapper.hpp"
#include <string>
#include "Notice.hpp"

using namespace std;

void ListWrapper::setObjectValues(string objectString, bool objectState) {
    noticeList.push_back(*new Notice(objectState, objectString));
}

long ListWrapper::returnListSize() {
    return noticeList.size();
}

