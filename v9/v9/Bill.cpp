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
}

Bill::Bill(string name, string date, string cost, string paid) {
    this->name = name;
    this->date = date;
    this->cost = cost;
    this->paid = paid;
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

void Bill::addPayment(string amount) {
    this->paid = amount;
}
