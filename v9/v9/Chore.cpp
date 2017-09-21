//
//  Chore.cpp
//  v9
//
//  Created by Gavin Trebilcock, Josh Lieshout, Max Newall and Shaye Mckay on 5/24/17.
//  Copyright © 2017 Max Newall. All rights reserved.
//

#include "Chore.hpp"

Chore::Chore() {
    isComplete = false;
    time = "";
    choreMessage = "";
    choreSubject = "";
}

Chore::Chore(string choreSubject, string time) {
    this->choreSubject = choreSubject;
    this->time = time;
}

string Chore::getChoreSubject() {
    return choreSubject;
}

string Chore::getChoreTime() {
    return time;
}

bool Chore::returnCompleted() {
    return isComplete;
}

void Chore::setCompleted() {
    this->isComplete = true;
}

void Chore::setMessage(string text){
    choreMessage = text;
}
