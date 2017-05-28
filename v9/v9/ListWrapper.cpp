//
//  ListWrapper.cpp
//  TestApp1
//
//  Created by Max Newall on 5/23/17.
//  Copyright © 2017 Max Newall. All rights reserved.
//

#include <string>
#include <sstream>
#include "ListWrapper.hpp"
#include "Notice.hpp"
#include "Chore.hpp"

using namespace std;

vector<Chore> ListWrapper::choreList;
vector<Notice> ListWrapper::noticeList;

void ListWrapper::setNoticeObjectValues(string objectString) {
    noticeList.resize(returnNoticeListSize());
    noticeList.push_back(*new Notice(objectString));
    printf("number of objects in list : %ld \n", returnNoticeListSize());
}

long ListWrapper::returnNoticeListSize() {
    return noticeList.size();
}

void ListWrapper::setChoreObjectValues(string choreString, string timeString) {
    choreList.resize(returnChoreListSize());
    choreList.push_back(*new Chore(choreString, timeString));
    printf("list size is: %ld \n", returnChoreListSize());
}


long ListWrapper::returnChoreListSize() {
    return choreList.size();
    
}

string ListWrapper::returnStringChoreListSize() {
    stringstream stream;
    string size;
    stream << choreList.size();
    stream >> size;
    return size;
}
