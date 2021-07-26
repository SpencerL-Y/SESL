//
// Created by center on 2021/6/5.
//

#ifndef SMACK_CENTERDEBUG_H
#define SMACK_CENTERDEBUG_H

#endif //SMACK_CENTERDEBUG_H
#pragma once
#include <iostream>
#include <unordered_map>
#define CENTER_DEBUG 1
const bool hasColor = true;


#define OPEN_CDEBUG true

#define CDEBUG(X) do { \
    if (CENTER_DEBUG && OPEN_CDEBUG) {\
        if (hasColor)               \
            std::cout<<"\033[33m"; \
        X;             \
        if (hasColor)   \
            std::cout<<"\033[0m"; \
    }\
} while(false);

#define CFDEBUG(X) do {\
    if (CENTER_DEBUG) {\
        if (hasColor)   std::cout<<"\033[34m";\
        X;             \
        if (hasColor)   \
            std::cout<<"\033[0m";\
    }\
} while(false);

namespace color {
    const std::string red = "\033[31m";
    const std::string green = "\033[32m";
    const std::string yellow = "\033[33m";
    const std::string blue = "\033[34m";
    const std::string white = "";
}

static const std::unordered_map<std::string, bool> DISPLAY_TABLE{
        {color::red, true},
        {color::green, true},
        {color::yellow, true},
        {color::blue, true},
        {color::white, true}
};
#define DEBUG_WITH_COLOR(X, COLOR) do { \
    if (CENTER_DEBUG) {                 \
        if (!DISPLAY_TABLE.at(COLOR)) break; \
        if (hasColor)   std::cout<< COLOR; \
        X;                              \
        if (hasColor)   std::cout<<"\033[0m"; \
    }\
} while(false);