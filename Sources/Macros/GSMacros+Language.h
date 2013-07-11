//
// GSMacros+Language.h
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

#import "GSMacros+Varargs.h"


/**
 * Singleton creation.
 *
 * A convenience macro that generates a singleton class method, using dispatch_once 
 * and the default init method internally.
 *
 * In most cases you should only need to pass the name of the singleton accessor as
 * defined in the class interface section. For example,
 *
 *     @interface GSPreferences
 *
 *     + (instancetype)sharedPreferences;
 *
 *     ...
 *
 *
 *     @implementation GSPreferences
 *
 *     SINGLETON(sharedPreferences)
 *
 *     ...
 *
 * The macro call in the example is equivalent to the following code:
 *
 *     + (instancetype)sharedPreferences {
 *         static id instance;
 *         static dispatch_once_t predicate;
 *         dispatch_once(&predicate, ^{
 *             instance = ([self new]);
 *         });
 *         return instance;
 *     }
 * 
 * You can optionally pass a second argument with a custom initializer call if
 * [self new] isn't appropriate. For example,
 *
 *     SINGLETON(sharedPreferences, [self initWithFile:kPrefsFile])
 */
#define SINGLETON(accessor, ...)        _SINGLETON(accessor, ##__VA_ARGS__)


/**
 * Keypath generation with compile-time check and code completion.
 *
 * For example, to observe changes to the 'email' property of an AppUser object we 
 * call observeValue with the keypath as an argument:
 *
 *     AppUser *user = self.user;
 *     [user observeValueForKeyPath:@"email" ...];
 *
 * To use the KEYPATH macro we replace the second line as follows:
 *
 *     [user observeValueForKeyPath:KEYPATH(user, email) ...];
 *
 * In both cases the compiler will generate the exact same code, but the KEYPATH
 * call will cause a compilation error if there's a typo or if at some point the
 * 'email' property is renamed or removed from the AppUser class.
 */
#define KEYPATH(object, path)           ((void)(NO && ((void)object.path, NO)), @#path)


/**
 * Variant of KEYPATH that can be used when there's no concrete instance of the
 * relevant class to verify the keypath against.
 *
 * For example, to get all the emails from the AppUser objects in an array we can 
 * use the valueForKey method:
 *
 *     NSArray *users = self.users;
 *     NSArray *emails = [users valueForKey:@"email"];
 *
 * We'll replace the second line with a safer version using CLSPATH:
 *
 *     NSArray *emails = [users valueForKey:CLSPATH(AppUser, email)];
 */
#define CLSPATH(class, path)            KEYPATH(((class *) nil), path)


/**
 * A replacement macro for @selector(...) that asserts at runtime that the object
 * actually implements the method.
 *
 * For example, an object might want to be notified about low memory situations by
 * registering with the default notification center:
 *
 *     [NSNotificationCenter.defaultCenter addObserver:self
 *                                            selector:@selector(didReceiveMemoryWarning:)
 *                                                name:UIApplicationDidReceiveMemoryWarningNotification
 *                                              object:nil];
 *
 * The registration will happen even if the didReceiveMemoryWarning method isn't 
 * implemented correctly or if it's removed at some point by mistake. The application
 * might crash at some unexpected time later when the notification is actually fired.
 *
 * Replacing the second line as follows will cause an assertion to be raised at runtime
 * in such a scenario:
 *
 *     [NSNotificationCenter.defaultCenter addObserver:self
 *                                            selector:SELECTOR(self, didReceiveMemoryWarning:)
 *                                                 ...
 */
#define SELECTOR(object, sel)                               \
({                                                          \
    SEL __s = @selector(sel);                               \
    GSAssert([(object) respondsToSelector:__s],             \
        @"'%s' doesn't respond to '%s'", #object, #sel);    \
    __s;                                                    \
})


/**
 * Returns the current function's name as a C string.
 * 
 * When called in an Objective-C method the macro returns the name of the method's
 * selector, i.e., the result of sel_getName(_cmd). When called in a regular C function 
 * the macro is equivalent to __FUNCTION__.
 *
 * Note: The compiler requires both expressions in __builtin_choose_expr to be valid.
 * The _cmd variable isn't available in C functions so to prevent a syntax error during
 * compilation we declare a placeholder _cmd symbol of type void* below.
 */
#define FUNCTIONNAME()                                      \
    __builtin_choose_expr(                                  \
        __builtin_types_compatible_p(typeof(_cmd), SEL),    \
        sel_getName(_cmd),                                  \
        __FUNCTION__)


/**
 * A pair of convenience macros that simplify the weak/strong pattern commonly used
 * to prevent retain cycles when creating blocks.
 *
 * For example, the following code creates a retain cycle between self and the block
 * being created.
 *
 *     self.reloadBlock = ^{
 *         [self.tableView reloadData];
 *     };
 *
 * We can prevent a retain cycle by using a weak reference to self and passing it to
 * the block instead.
 *
 *     __weak typeof(self) selfWeak = self;
 *     self.reloadBlock = ^{
 *         typeof(self) selfStrong = selfWeak;
 *         [selfStrong.tableView reloadData];
 *     };
 *
 * The code becomes much less verbose and error prone if we use WEAKIFY and STRONGIFY:
 *
 *     WEAKIFY(self);
 *     self.reloadBlock = ^{
 *         STRONGIFY(self);
 *         [self.tableView reloadData];
 *     };
 *
 * Note that STRONGIFY intentionally creates a new variable with the same name inside 
 * the block to prevent accidental use of the original variable.
 *
 * Based on: https://github.com/jspahrsummers/libextobjc
 */
#define WEAKIFY(var, ...)               _WEAKIFY(var, ##__VA_ARGS__)

#define STRONGIFY(var, ...)             _STRONGIFY(var, ##__VA_ARGS__)


/**
 * Swaps the values of two variables. Usage:
 *
 *     CGRect rect = UIScreen.mainScreen.bounds;
 *     SWAP(rect.size.width, rect.size.height);
 */
#define SWAP(foo, bar)                  \
do {                                    \
    typeof(bar) __b = (bar);            \
    (bar) = (foo);                      \
    (foo) = __b;                        \
} while (0)




//
// Implementation details, do not use directly
//

// Calls one of the two helpers below, depending on if given 1 or 2 arguments
#define _SINGLETON(ACCESSOR, ...)       GS_VA_OVERLOAD(_SINGLETON, ACCESSOR, ##__VA_ARGS__)
// Base call with default initializer [self new]
#define _SINGLETON1(ACCESSOR)           _SINGLETON2(ACCESSOR, [self new])
// Advanced call with custom initializer
#define _SINGLETON2(ACCESSOR, INIT)     \
+ (instancetype)ACCESSOR {              \
    static id instance = nil;           \
    static dispatch_once_t predicate;   \
    dispatch_once(&predicate, ^{        \
        instance = (INIT);              \
    });                                 \
    return instance;                    \
}

// Placeholder _cmd symbol so FUNCTIONNAME() won't cause a syntax error during compilation.
extern void *_cmd;

// Calls _WEAKIFY_VAR on each variable
#define _WEAKIFY(...)                                   \
    GS_VA_ENUMERATE(_WEAKIFY_VAR, ##__VA_ARGS__)
// Calls _STRONGIFY_VAR on each variable, suppresses warning about shadowing local variables
#define _STRONGIFY(...)                                 \
    _Pragma("clang diagnostic push")                    \
    _Pragma("clang diagnostic ignored \"-Wshadow\"")    \
    GS_VA_ENUMERATE(_STRONGIFY_VAR, ##__VA_ARGS__)      \
    _Pragma("clang diagnostic pop")
// Defines weak refernce to variable
#define _WEAKIFY_VAR(var)               __weak typeof(var) var ## Weak = (var)
// Converts weak reference to variable to strong one
#define _STRONGIFY_VAR(var)             __strong typeof(var) var = var ## Weak
