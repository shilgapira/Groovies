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

#define GSAssertEqual(obj1, obj2)       GSAssert(GSEqualObjects((obj1), (obj2)), @"'%s' and '%s' are not equal", #obj1, #obj2)

#define GSAssertMainThread()            GSAssert([NSThread isMainThread], @"Not on main thread")


//
// Type safety assertion macros
//

#ifdef DEBUG

#define GSAssertCast(cls, obj)                              \
({                                                          \
    id __o = (obj);                                         \
    if (__o != nil) {                                       \
        Class __c = [cls class];                            \
        GSAssert([__o isKindOfClass:__c],                   \
            @"'%s' isn't kind of %s", #obj, #cls);          \
    }                                                       \
    (cls *)__o;                                             \
})

#define GSAssertKind(obj, cls)          ((void)GSAssertCast(cls, obj))

#else

#define GSAssertCast(cls, obj)          ((cls *)(obj))

#define GSAssertKind(obj, cls)          ((void)0)

#endif


//
// Low-level assertion macros that raise an exception in debug and print an error log in release.
//

#ifdef DEBUG

#define _GSAssertFail(frmt, ...)        \
({                                      \
    GSCLogE(frmt, ##__VA_ARGS__);       \
    [DDLog flushLog];                   \
    [NSAssertionHandler.currentHandler handleFailureInFunction:[NSString stringWithUTF8String:__PRETTY_FUNCTION__] file:[NSString stringWithUTF8String:__FILE__] lineNumber:__LINE__ description:frmt,##__VA_ARGS__]; \
})

#else

#define _GSAssertFail(frmt, ...)        \
({                                      \
    GSCLogE(frmt, ##__VA_ARGS__);       \
    [DDLog flushLog];                   \
})

#endif
