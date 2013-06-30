//
// GSMacros+Stringify.h
//
// Copyright (c) 2013 Gil Shapira
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


/**
 * Converts the value of an expression to a string.
 *
 * This macro uses compile time conditionals to pick a type appropriate way to convert
 * the value to an NSString object. Because the choice is made at compile time
 * this should be as efficient as using any specific conversion explicitly.
 *
 * The following conversions are supported:
 *
 *      Objects/Classes -> [... description]
 *      Primitives/Pointers -> [NSString stringWithFormat:...]
 *      SEL -> NSStringFromSelector
 *      CGRect -> NSStringFromCGRect
 *      CGPoint -> NSStringFromCGPoint
 *      CGSize -> NSStringFromCGSize
 *      CGAffineTransform -> NSStringFromCGAffineTransform
 *      NSRange -> NSStringFromRange
 *      BOOL -> "YES"/"NO"
 *      Everything else -> NSValue
 *
 * Not supported:
 *
 *      C arrays
 *
 * Based on: http://www.mikeash.com/pyblog/friday-qa-2010-12-31-c-macro-tips-and-tricks.html
 * Based on: http://vgable.com/blog/tag/log_expr/
 */
#define GSStringify(expr)                                                       \
__builtin_choose_expr(_GSStringifyIsType(expr, CGRect),                         \
    _GSStringifyFunc(expr, CGRect, NSStringFromCGRect),                         \
__builtin_choose_expr(_GSStringifyIsType(expr, CGPoint),                        \
    _GSStringifyFunc(expr, CGPoint, NSStringFromCGPoint),                       \
__builtin_choose_expr(_GSStringifyIsType(expr, CGSize),                         \
    _GSStringifyFunc(expr, CGSize, NSStringFromCGSize),                         \
__builtin_choose_expr(_GSStringifyIsType(expr, CGAffineTransform),              \
    _GSStringifyFunc(expr, CGAffineTransform, NSStringFromCGAffineTransform),   \
__builtin_choose_expr(_GSStringifyIsType(expr, NSRange),                        \
    _GSStringifyFunc(expr, NSRange, NSStringFromRange),                         \
__builtin_choose_expr(_GSStringifyIsType(expr, SEL),                            \
    _GSStringifyFunc(expr, SEL, NSStringFromSelector),                          \
__builtin_choose_expr(_GSStringifyIsType(expr, BOOL),                           \
    _GSStringifyBool(expr),                                                     \
__builtin_choose_expr(_GSStringifyIsType(expr, unsigned char),                  \
    _GSStringifyFormat(expr, unsigned char, @"'%c'"),                           \
__builtin_choose_expr(_GSStringifyIsType(expr, long long),                      \
    _GSStringifyFormat(expr, long long, @"%lld"),                               \
__builtin_choose_expr(_GSStringifyIsType(expr, unsigned long long),             \
    _GSStringifyFormat(expr, unsigned long long, @"%llu"),                      \
__builtin_choose_expr(_GSStringifyIsType(expr, float),                          \
    _GSStringifyFormat(expr, float, @"%g"),                                     \
__builtin_choose_expr(_GSStringifyIsType(expr, double),                         \
    _GSStringifyFormat(expr, double, @"%g"),                                    \
__builtin_choose_expr(_GSStringifyIsType(expr, short),                          \
    _GSStringifyFormat(expr, short, @"%hd"),                                    \
__builtin_choose_expr(_GSStringifyIsType(expr, unsigned short),                 \
    _GSStringifyFormat(expr, unsigned short, @"%hu"),                           \
__builtin_choose_expr(_GSStringifyIsType(expr, int),                            \
    _GSStringifyFormat(expr, int, @"%d"),                                       \
__builtin_choose_expr(_GSStringifyIsType(expr, unsigned),                       \
    _GSStringifyFormat(expr, unsigned, @"%u"),                                  \
__builtin_choose_expr(_GSStringifyIsType(expr, long),                           \
    _GSStringifyFormat(expr, long, @"%ld"),                                     \
__builtin_choose_expr(_GSStringifyIsType(expr, long double),                    \
    _GSStringifyFormat(expr, long double, @"%Lf"),                              \
__builtin_choose_expr(_GSStringifyIsType(expr, char *),                         \
    _GSStringifyFormat(expr, char *, @"%s"),                                    \
__builtin_choose_expr(_GSStringifyIsType(expr, const char *),                   \
    _GSStringifyFormat(expr, char *, @"%s"),                                    \
__builtin_choose_expr(_GSStringifyIsType(expr, void *),                         \
    _GSStringifyFormat(expr, void *, @"%p"),                                    \
__builtin_choose_expr(_GSStringifyIsType(expr, id),                             \
    [_GSStringifyCast(expr, id) description],                                   \
    _GSStringifyFallback(expr)                                                  \
))))))))))))))))))))))



//
// Implementation details, do not use directly
//

// Compile-time check of expression type
#define _GSStringifyIsType(expr, type)          __builtin_types_compatible_p(typeof(expr), type)

// Force casts an expression into a specific type
#define _GSStringifyCast(expr, type)            *(const type *)((void *)((typeof(expr)[]){ expr }))

// Formats a string with the value of the expression cast to the appropriate type
#define _GSStringifyFormat(expr, type, format)  [NSString stringWithFormat:format,_GSStringifyCast(expr, type)]

// Calls a function with the value of the expression cast to the appropriate type
#define _GSStringifyFunc(expr, type, func)      func(_GSStringifyCast(expr, type))

// Returns a boolean string for the special values of YES and NO, or the numeric
// value of the char otherwise
#define _GSStringifyBool(expr)                  \
({                                              \
    BOOL __v = _GSStringifyCast(expr, BOOL);    \
    __v == YES ? @"YES" :                       \
        __v == NO ? @"NO" :                     \
        [NSString stringWithFormat:@"%d",__v];  \
})

// Returns a byte representation of an unknown type
#define _GSStringifyFallback(expr)              \
({                                              \
    const void *__b = (typeof(expr)[]){ expr };                 \
    const char *__t = @encode(typeof(expr));                    \
    NSValue *__v = [NSValue valueWithBytes:__b objCType:__t];   \
    [__v description];                          \
})
