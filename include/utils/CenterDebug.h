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

#define CFDEBUG(X) do {\
    if (CENTER_DEBUG) {\
        std::cout<<"\033[34m";\
        X;                    \
        std::cout<<"\033[0m";\
    }\
} while(false);

namespace color {
    const std::string red = "\033[31m";
    const std::string green = "\033[32m";
    const std::string yellow = "\033[33m";
    const std::string blue = "\033[34m";
}

#define DEBUG_WITH_COLOR(X, COLOR) do { \
    if (CENTER_DEBUG) {\
        std::cout<< COLOR; \
        X;                   \
        std::cout<<"\033[0m"; \
    }\
} while(false);