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
    name = "";
    time = "";
}

Chore::Chore(string name, string time) {
    this->name = name;
    this->time = time;
}

string Chore::getChoreName() {
    return name;
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
