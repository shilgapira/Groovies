//
// GSMacros+Varargs.h
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


/**
 * Creates overloadable macros with different implementations for each number
 * of arguments.
 *
 * For example, the code below defines a macro called Average that calculates
 * the average of the arguments (up to 4) that are passed to it:
 *
 *     #define Average(...)                 GS_VA_OVERLOAD(_Average, ##__VA_ARGS__)
 *
 *     #define _Average1(x)                 (x)
 *     #define _Average2(x, y)              (((x) + (y)) / 2)
 *     #define _Average3(x, y, z)           (((x) + (y) + (z)) / 3)
 *     #define _Average4(x, y, z, w)        (((x) + (y) + (z) + (w)) / 4)
 *
 *     ...
 *
 *     int three = Average(2, 4);       // calls _Average2(2, 4)
 *     int four = Average(2, 2, 4, 6);  // calls _Average4(2, 2, 4, 6)
 *
 * We define several helpers that each handles a specific number of arguments. Note
 * they are all named exactly the same apart from the number at the end, which must
 * be equal to the expected number of arguments.
 *
 * The Average macro itself is defined as a call to GS_VA_OVERLOAD, passing along the
 * name of the helpers as well as all the arguments from the original call.
 *
 * In the above example calling Average() without any arguments is an error, even
 * though the syntax suggests that it should be possible. To require at least one or
 * more arguments we add them to the definition of the macro itself and pass them
 * along to GS_VA_OVERLOAD. For example,
 *
 *     #define Average(x, ...)              GS_VA_OVERLOAD(_Average, x, ##__VA_ARGS__)
 *
 * In cases where we want the macro to support calls without any arguments, we simply
 * define another helper that ends with 0. For example, the code below defines a macro
 * called LogCall that can be used at the beginning of a function to log the function's
 * name and optionally any of its parameters:
 *
 *     #define LogCall(...)                 GS_VA_OVERLOAD(_LogCall, ##__VA_ARGS__)
 *
 *     #define _LogCall0()                  NSLog(@"%s()", __PRETTY_FUNCTION__)
 *     #define _LogCall1(obj1)              NSLog(@"%s(%@)", __PRETTY_FUNCTION__, obj1)
 *     #define _LogCall2(obj1, obj2)        NSLog(@"%s(%@,%@)", __PRETTY_FUNCTION__, obj1, obj2)
 *     ...
 */
#define GS_VA_OVERLOAD(helper, ...)     _GS_VA_OVERLOAD(helper, ##__VA_ARGS__)


/**
 * Calls a function or macro on each of the arguments passed to it.
 *
 * For example, we define a macro called LogObject that receives an object argument and
 * prints the argument itself and its value.
 *
 *     #define LogObject(obj)               NSLog(@"%s: %@", #obj, obj)
 *
 *     ...
 *
 *     self.name = @"James";
 *     LogObject(self.name);    // prints 'self.name: James'
 *
 * Using GS_VA_FOREACH we can build on this macro and define a more generic version
 * called LogObjects that calls LogObject on each of its arguments:
 *
 *     #define LogObjects(...)              GS_VA_FOREACH(LogObject, ##__VA_ARGS__)
 *
 *     ...
 *
 *     LogObjects(self.name, self.address, self.telephone);
 */
#define GS_VA_FOREACH(func, ...)        _GS_VA_FOREACH(func, ##__VA_ARGS__)


/**
 * A variant of GS_VA_FOREACH that doesn't nest the calls in a block. This can be
 * useful when the expressions need to be in the same scope as the one the macro
 * was called from.
 */
#define GS_VA_ENUMERATE(expr, ...)      _GS_VA_ENUMERATE(expr, ##__VA_ARGS__)


/**
 * A helper macro that returns the number of arguments passed to it (up to 8).
 *
 * Based on: http: *efesx.com/2010/07/17/variadic-macro-to-count-number-of-arguments/
 */
#define GS_VA_COUNT(...)                _GS_VA_COUNT(__VA_ARGS__)



//
// Implementation details, do not use directly
//

// Calls _COUNT to generate the helper name, then calls it with the arguments
#define _GS_VA_OVERLOAD(helper, ...)            _GS_VA_OVERLOAD_COUNT(helper, __VA_ARGS__)(__VA_ARGS__)
// Counts the number of arguments, and calls _ATTACH to attach it to the helper name
#define _GS_VA_OVERLOAD_COUNT(helper, ...)      _GS_VA_OVERLOAD_ATTACH(helper, GS_VA_COUNT(__VA_ARGS__))
// Calls _CONCAT to concatenate the two arguments
#define _GS_VA_OVERLOAD_ATTACH(helper, count)   _GS_VA_OVERLOAD_CONCAT(helper, count)
// Concatenates the two arguments
#define _GS_VA_OVERLOAD_CONCAT(helper, count)   helper ## count


// Opens a nested block and makes the calls inside
#define _GS_VA_FOREACH(func, ...)               do { _GS_VA_ENUMERATE(func, ##__VA_ARGS__); } while (0)


// Uses GS_VA_OVERLOAD to redirect the call to one of the helpers below
#define _GS_VA_ENUMERATE(expr, ...)                     GS_VA_OVERLOAD(_GS_VA_ENUMERATE, expr, ##__VA_ARGS__)
// Helpers that cause the call to be performed as many times as needed
#define _GS_VA_ENUMERATE8(expr, a, b, c, d, e, f, g)    expr(a); _GS_VA_ENUMERATE7(expr, b, c, d, e, f, g)
#define _GS_VA_ENUMERATE7(expr, a, b, c, d, e, f)       expr(a); _GS_VA_ENUMERATE6(expr, b, c, d, e, f)
#define _GS_VA_ENUMERATE6(expr, a, b, c, d, e )         expr(a); _GS_VA_ENUMERATE5(expr, b, c, d, e)
#define _GS_VA_ENUMERATE5(expr, a, b, c, d)             expr(a); _GS_VA_ENUMERATE4(expr, b, c, d)
#define _GS_VA_ENUMERATE4(expr, a, b, c)                expr(a); _GS_VA_ENUMERATE3(expr, b, c)
#define _GS_VA_ENUMERATE3(expr, a, b)                   expr(a); _GS_VA_ENUMERATE2(expr, b)
#define _GS_VA_ENUMERATE2(expr, a)                      expr(a)
#define _GS_VA_ENUMERATE1(expr)                         ((void)0)


// Calls _PICK with the arguments arranged so the appropriate number is passed as the 'count' argument
#define _GS_VA_COUNT(...)                       _GS_VA_COUNT_PICK(, ##__VA_ARGS__, 8, 7, 6, 5, 4, 3, 2, 1, 0)
// Returns the seventh argument
#define _GS_VA_COUNT_PICK(a0, a1, a2, a3, a4, a5, a6, a7, a8, count, ...)   count

