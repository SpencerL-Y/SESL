//
// Created by center on 2021/6/5.
//

#ifndef SMACK_CENTERDEBUG_H
#define SMACK_CENTERDEBUG_H

#endif //SMACK_CENTERDEBUG_H
#pragma once
#include <iostream>
#define CENTER_DEBUG 1
#define CDEBUG(X) do { \
    if (CENTER_DEBUG) {\
        std::cout<<"\033[33m"; \
        X;                   \
        std::cout<<"\033[0m"; \
    }\
} while(false);