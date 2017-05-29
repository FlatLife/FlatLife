//
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
    paid ="";
}

Bill::Bill(string name, string date, string cost) {
    this->name = name;
    this->date = date;
    this->cost = cost;
    paid = "0";
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
//    if(paid >= cost){
//        if((paid + amount) >= cost){
//            paid = cost;
//        } else {
//            paid += amount;
//        }
//    }
}
