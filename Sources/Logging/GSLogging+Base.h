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

#import "DDLog.h"


//
// Undefine builtin CocoaLumberjack macros
//

#undef LOG_FLAG_ERROR
#undef LOG_FLAG_WARN
#undef LOG_FLAG_INFO
#undef LOG_FLAG_VERBOSE

#undef LOG_LEVEL_OFF
#undef LOG_LEVEL_ERROR
#undef LOG_LEVEL_WARN
#undef LOG_LEVEL_INFO
#undef LOG_LEVEL_VERBOSE

#undef LOG_ERROR
#undef LOG_WARN
#undef LOG_INFO
#undef LOG_VERBOSE

#undef DDLogError
#undef DDLogWarn
#undef DDLogInfo
#undef DDLogVerbose

#undef DDLogCError
#undef DDLogCWarn
#undef DDLogCInfo
#undef DDLogCVerbose


//
// Global logging level.
//

extern int GSLogLevel;


//
// Define new macros that use our logging scheme.
//

#define LOG_FLAG_ERROR      (1 << 0)  // 0...000001
#define LOG_FLAG_WARN       (1 << 1)  // 0...000010
#define LOG_FLAG_INFO       (1 << 2)  // 0...000100
#define LOG_FLAG_VERBOSE    (1 << 3)  // 0...001000
#define LOG_FLAG_DEBUG      (1 << 4)  // 0...010000

#define LOG_LEVEL_OFF       (0)                                     // 0...000000
#define LOG_LEVEL_ERROR     (LOG_FLAG_ERROR)                        // 0...000001
#define LOG_LEVEL_WARN      (LOG_FLAG_WARN    | LOG_LEVEL_ERROR)    // 0...000011
#define LOG_LEVEL_INFO      (LOG_FLAG_INFO    | LOG_LEVEL_WARN)     // 0...000111
#define LOG_LEVEL_VERBOSE   (LOG_FLAG_VERBOSE | LOG_LEVEL_INFO)     // 0...001111
#define LOG_LEVEL_DEBUG     (LOG_FLAG_DEBUG   | LOG_LEVEL_VERBOSE)  // 0...011111

#define LOG_ERROR           (GSLogLevel & LOG_FLAG_ERROR  )
#define LOG_WARN            (GSLogLevel & LOG_FLAG_WARN   )
#define LOG_INFO            (GSLogLevel & LOG_FLAG_INFO   )
#define LOG_VERBOSE         (GSLogLevel & LOG_FLAG_VERBOSE)
#define LOG_DEBUG           (GSLogLevel & LOG_FLAG_DEBUG  )

#define GSLogE(frmt, ...)    SYNC_LOG_OBJC_MAYBE(GSLogLevel, LOG_FLAG_ERROR,   0, @"" frmt, ##__VA_ARGS__)
#define GSLogW(frmt, ...)   ASYNC_LOG_OBJC_MAYBE(GSLogLevel, LOG_FLAG_WARN,    0, @"" frmt, ##__VA_ARGS__)
#define GSLogI(frmt, ...)   ASYNC_LOG_OBJC_MAYBE(GSLogLevel, LOG_FLAG_INFO,    0, @"" frmt, ##__VA_ARGS__)
#define GSLogV(frmt, ...)   ASYNC_LOG_OBJC_MAYBE(GSLogLevel, LOG_FLAG_VERBOSE, 0, @"" frmt, ##__VA_ARGS__)
#define GSLogD(frmt, ...)   ASYNC_LOG_OBJC_MAYBE(GSLogLevel, LOG_FLAG_DEBUG,   0, @"" frmt, ##__VA_ARGS__)


//
// Logging macros for use in plain C functions, where _cmd isn't defined.
//

#define GSCLogE(frmt, ...)      SYNC_LOG_C_MAYBE(GSLogLevel, LOG_FLAG_ERROR,   0, @"" frmt, ##__VA_ARGS__)
#define GSCLogW(frmt, ...)     ASYNC_LOG_C_MAYBE(GSLogLevel, LOG_FLAG_WARN,    0, @"" frmt, ##__VA_ARGS__)
#define GSCLogI(frmt, ...)     ASYNC_LOG_C_MAYBE(GSLogLevel, LOG_FLAG_INFO,    0, @"" frmt, ##__VA_ARGS__)
#define GSCLogV(frmt, ...)     ASYNC_LOG_C_MAYBE(GSLogLevel, LOG_FLAG_VERBOSE, 0, @"" frmt, ##__VA_ARGS__)
#define GSCLogD(frmt, ...)     ASYNC_LOG_C_MAYBE(GSLogLevel, LOG_FLAG_DEBUG,   0, @"" frmt, ##__VA_ARGS__)
