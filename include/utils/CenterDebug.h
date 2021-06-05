//
// Created by center on 2021/6/5.
//

#ifndef SMACK_CENTERDEBUG_H
#define SMACK_CENTERDEBUG_H

#endif //SMACK_CENTERDEBUG_H
#pragma once
#define CENTER_DEBUG 1
#define CDEBUG(X) do { \
    if (CENTER_DEBUG) {\
        X;                   \
    }\
} while(false);