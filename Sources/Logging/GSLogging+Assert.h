//
// GSLogging+Assert.h
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

#import "GSLogging+Base.h"
#import "GSMacros+Varargs.h"


//
// Common assertion macros
//

#define GSAssert(expr, ...)                                         \
({                                                                  \
    typeof(expr) __e = (expr);                                      \
    if (!__e) {                                                     \
        __builtin_choose_expr(                                      \
            sizeof(#__VA_ARGS__) == sizeof(""),                     \
            _GSAssertFail(@"Assert failed: %s", #expr),             \
            _GSAssertFail(@"" __VA_ARGS__)                          \
        );                                                          \
    }                                                               \
    _Pragma("clang diagnostic push")                                \
    _Pragma("clang diagnostic ignored \"-Wunused-value\"")          \
    __e;                                                            \
    _Pragma("clang diagnostic pop")                                 \
})

#define GSAssertFailed(...)             GSAssert(0, ##__VA_ARGS__)

#define GSAssertMainThread()            GSAssert([NSThread isMainThread], @"Not on main thread")

#define GSAssertEqual(obj1, obj2)                                   \
({                                                                  \
    id __a = (obj1);                                                \
    id __b = (obj2);                                                \
    BOOL __eq = (BOOL) (__a == __b || [__a isEqual:__b]);           \
    GSAssert(__eq, @"'%s' and '%s' are not equal", #obj1, #obj2);   \
})


//
// Type safety assertion macros
//

#ifdef DEBUG

#define GSAssertKind(obj, cls)                                      \
({                                                                  \
    typeof(obj) __o = (obj);                                        \
    Class __c = [cls class];                                        \
    if (![__o isKindOfClass:__c]) {                                 \
        NSString *__actual = NSStringFromClass([__o class]) ?: @"nil";          \
        NSString *__expected = NSStringFromClass(__c);                          \
        _GSAssertFail(@"'%s' is %@, expected %@", #obj, __actual, __expected);  \
    }                                                               \
    _Pragma("clang diagnostic push")                                \
    _Pragma("clang diagnostic ignored \"-Wunused-value\"")          \
    __o;                                                            \
    _Pragma("clang diagnostic pop")                                 \
})

#else

#define GSAssertKind(obj, cls)          (obj)

#endif

#define GSAssertCast(cls, obj)                                      \
    _Pragma("clang diagnostic push")                                \
    _Pragma("clang diagnostic ignored \"-Wunused-value\"")          \
    ((cls *) GSAssertKind(obj, cls))                                \
    _Pragma("clang diagnostic pop")                                 \


//
// Low-level assertion macros that raise an exception in debug and print an error log in release.
//

#ifdef DEBUG

#define _GSAssertFail(frmt, ...)        \
({                                      \
    GSLogE(frmt, ##__VA_ARGS__);        \
    [DDLog flushLog];                   \
    [NSAssertionHandler.currentHandler handleFailureInFunction:[NSString stringWithUTF8String:FUNCTIONNAME()] file:[NSString stringWithUTF8String:__FILE__] lineNumber:__LINE__ description:frmt,##__VA_ARGS__]; \
})

#else

#define _GSAssertFail(frmt, ...)        \
({                                      \
    GSLogE(frmt, ##__VA_ARGS__);        \
    [DDLog flushLog];                   \
})

#endif
