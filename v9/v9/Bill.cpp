//  Bill.cpp
//  v9
//
//  Created by Gavin Trebilcock, Josh Lieshout, Max Newall and Shaye Mckay on 5/29/17.
//  Copyright © 2017 Max Newall. All rights reserved.
//

#include "Bill.hpp"

Bill::Bill() {
    name = "";
    date = "";
    cost = "";
    paid = "";
    descript = "";
}

Bill::Bill(string name, string date, string cost, string paid, string descript) {
    this->name = name;
    this->date = date;
    this->cost = cost;
    this->paid = paid;
    this->descript = descript;
}

string Bill::getBillName() {
    return name;
}

string Bill::getBillDate() {
    return date;
}

string Bill::getBillCost() {
    return cost;
}

string Bill::getAmountPaid() {
    return paid;
}

string Bill::getDescript() {
    return descript;
}

void Bill::addPayment(string amount) {
    this->paid = amount;
}

void Bill::setDescript(string descript){
    this->descript = descript;
}

void Bill::setName(string name){
    this->name = name;
}
