//
//  Chore.hpp
//  v9
//
//  Created by Gavin Trebilcock, Josh Lieshout, Max Newall and Shaye Mckay on 5/24/17.
//  Copyright © 2017 Max Newall. All rights reserved.
//

#ifndef Chore_hpp
#define Chore_hpp

#include <stdio.h>
#include <string>

using namespace std;

class Chore {

public:
    bool isComplete;
    string time;
    string choreMessage;
    string choreSubject;
    Chore();
    Chore(string name, string time);
    string getChoreSubject();
    string getChoreTime();
    bool returnCompleted();
    void setCompleted();
    void setMessage(string text);
};

#endif /* Chore_hpp */
