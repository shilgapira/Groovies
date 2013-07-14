//
// GSLogging+Base.h
//
// Copyright (c) 2012 Gil Shapira
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.
//

#import "GSLogging+Lumberjack.h"
#import "GSMacros+Language.h"


//
// The current log level.
//

extern int GSLogLevel;


//
// Logging macros for each log level.
//

#define GSLogE(frmt, ...)   _GSLogSync(LOG_FLAG_ERROR, frmt, ##__VA_ARGS__)
#define GSLogW(frmt, ...)   _GSLogAsync(LOG_FLAG_WARN, frmt, ##__VA_ARGS__)
#define GSLogI(frmt, ...)   _GSLogAsync(LOG_FLAG_INFO, frmt, ##__VA_ARGS__)
#define GSLogV(frmt, ...)   _GSLogAsync(LOG_FLAG_VERBOSE, frmt, ##__VA_ARGS__)
#define GSLogD(frmt, ...)   _GSLogAsync(LOG_FLAG_DEBUG, frmt, ##__VA_ARGS__)


//
// Define new CocoaLumberjack macros for own logging scheme.
//

#define LOG_FLAG_ERROR      (1 << 0)
#define LOG_FLAG_WARN       (1 << 1)
#define LOG_FLAG_INFO       (1 << 2)
#define LOG_FLAG_VERBOSE    (1 << 3)
#define LOG_FLAG_DEBUG      (1 << 4)

#define LOG_LEVEL_OFF       (0)
#define LOG_LEVEL_ERROR     (LOG_FLAG_ERROR)
#define LOG_LEVEL_WARN      (LOG_FLAG_ERROR | LOG_FLAG_WARN)
#define LOG_LEVEL_INFO      (LOG_FLAG_ERROR | LOG_FLAG_WARN | LOG_FLAG_INFO)
#define LOG_LEVEL_VERBOSE   (LOG_FLAG_ERROR | LOG_FLAG_WARN | LOG_FLAG_INFO | LOG_FLAG_VERBOSE)
#define LOG_LEVEL_DEBUG     (LOG_FLAG_ERROR | LOG_FLAG_WARN | LOG_FLAG_INFO | LOG_FLAG_VERBOSE | LOG_FLAG_DEBUG)

#define LOG_ERROR           (GSLogLevel & LOG_FLAG_ERROR)
#define LOG_WARN            (GSLogLevel & LOG_FLAG_WARN)
#define LOG_INFO            (GSLogLevel & LOG_FLAG_INFO)
#define LOG_VERBOSE         (GSLogLevel & LOG_FLAG_VERBOSE)
#define LOG_DEBUG           (GSLogLevel & LOG_FLAG_DEBUG)


//
// Implementation details, do not use directly
//

#define _GSLogSync(flag, frmt, ...)             _GSLog(0, flag, frmt, ##__VA_ARGS__)

#define _GSLogAsync(flag, frmt, ...)            _GSLog(1, flag, frmt, ##__VA_ARGS__)

#define _GSLog(async, flag, frmt, ...)                              \
do {                                                                \
    if (GSLogLevel & (flag)) {                                      \
        LOG_MACRO((async), GSLogLevel, (flag), 0, nil, FUNCTIONNAME(), @"" frmt, ##__VA_ARGS__);    \
    }                                                               \
} while(0)
