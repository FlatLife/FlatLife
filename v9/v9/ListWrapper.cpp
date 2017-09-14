//
//  ListWrapper.cpp
//  TestApp1
//
//  Created by Gavin Trebilcock, Josh Lieshout, Max Newall and Shaye Mckay on 5/23/17.
//  Copyright © 2017 Max Newall. All rights reserved.
//

#include <string>
#include <sstream>
#include "ListWrapper.hpp"
#include "Notice.hpp"
#include "Chore.hpp"
#include "Bill.hpp"

using namespace std;

vector<Chore> ListWrapper::choreList;
vector<Notice> ListWrapper::noticeList;
vector<Bill> ListWrapper::billList;


//NOTICES
void ListWrapper::setNoticeObjectValues(string objectString) {
    noticeList.resize(returnNoticeListSize());
    noticeList.push_back(*new Notice(objectString));
}

long ListWrapper::returnNoticeListSize() {
    return noticeList.size();
}

string ListWrapper::returnStringNoticeListSize() {
    stringstream stream;
    string size;
    stream << noticeList.size();
    stream >> size;
    return size;
}


//CHORES
void ListWrapper::setChoreObjectValues(string choreString, string timeString) {
    choreList.resize(returnChoreListSize());
    choreList.push_back(*new Chore(choreString, timeString));
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


//BILLS
void ListWrapper::setBillObjectValues(string billName, string billDate, string cost, string paid) {
    billList.resize(returnBillListSize());
    billList.push_back(*new Bill(billName, billDate, cost, paid));
}

long ListWrapper::returnBillListSize() {
    return billList.size();
}

string ListWrapper::returnStringBillListSize() {
    stringstream stream;
    string size;
    stream << billList.size();
    stream >> size;
    return size;
}












