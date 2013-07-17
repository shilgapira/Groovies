//
// GSGlobals+Objects.h
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

#import <Foundation/Foundation.h>
#import "GSMacros+Defines.h"


/**
 * Swizzles the implementation of two class methods.
 * @param cls The class to perform the swizzling on.
 * @param selector1 The selector for the first method.
 * @param selector2 The selector for the second method.
 */
GS_EXTERN void GSSwizzle(Class cls, SEL selector1, SEL selector2);


/**
 * Equality check that handles the case of both objects being nil.
 * @param obj1 The first object to compare.
 * @param obj2 The second object to compare.
 * @return Whether both objects are equal or nil.
 */
GS_INLINE BOOL GSEqualObjects(id obj1, id obj2) {
    return (obj1 == obj2) || [obj1 isEqual:obj2];
}


/**
 * Equality check that handles the case of either string being nil.
 * @param str1 The first string to compare.
 * @param str2 The second string to compare.
 * @return Whether both strings are equal or nil.
 */
GS_INLINE BOOL GSEqualStrings(NSString *str1, NSString *str2) {
    return (str1 == str2) || [str1 isEqualToString:str2];
}

/**
 * Case-insensitive equality check that handles the case of either string being nil.
 * @param str1 The first string to compare.
 * @param str2 The second string to compare.
 * @return Whether both strings are equal or nil.
 */
GS_INLINE BOOL GSEqualStringsIgnoreCase(NSString *str1, NSString *str2) {
    return (str1 == str2) || (str2 && [str1 compare:str2 options:NSCaseInsensitiveSearch] == NSOrderedSame);
}

/**
 * Checks that the argument is a non-empty string, i.e., it is not nil and contains 
 * at least one non-whitespace character.
 * @param string The string to check.
 * @return Whether the string isn't empty.
 */
GS_EXTERN BOOL GSNonEmptyString(NSString *string);
