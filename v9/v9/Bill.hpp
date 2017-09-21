//
//  Bill.hpp
//  v9
//
//  Created by Gavin Trebilcock, Josh Lieshout, Max Newall and Shaye Mckay on 5/29/17.
//  Copyright © 2017 Max Newall. All rights reserved.
//

#ifndef Bill_hpp
#define Bill_hpp

#include <stdio.h>
#include <string>

using namespace std;

class Bill {
    
public:
    string name;
    string date;
    string cost;
    string paid;
    string descript;
    Bill();
    Bill(string name, string date, string cost, string paid, string descript);
    string getBillName();
    string getBillDate();
    string getBillCost();
    string getAmountPaid();
    string getDescript();
    void addPayment(string amount);
    void setDescript(string descript);
    void setName(string name);
};

#endif /* Bill_hpp */
