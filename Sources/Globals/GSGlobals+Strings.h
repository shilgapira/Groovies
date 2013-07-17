//
// GSGlobals+Strings.h
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

#import <Foundation/Foundation.h>
#import "GSMacros+Defines.h"


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


/**
 * Converts the value of the argument to a string using a type appropriate conversion.
 * @return @c value as an NSString.
 */
GS_INLINE_OVERLOAD NSString *GSStringify(id value) {
    return [value description];
}


//
// GSStringify variant for boolean values.
//

GS_INLINE_OVERLOAD NSString *GSStringify(BOOL value) {
    if (value == YES) {
        return @"YES";
    } else if (value == NO) {
        return @"NO";
    } else {
        return [NSString stringWithFormat:@"%d",value];
    }
}


//
// GSStringify variants for types with existing functions.
//

#define _GSSTRINGIFY_DEFINE_FUNC(type, func)                            \
    GS_INLINE_OVERLOAD NSString * GSStringify(type value) {             \
        return func(value);                                             \
    }

_GSSTRINGIFY_DEFINE_FUNC(CGRect, NSStringFromCGRect)
_GSSTRINGIFY_DEFINE_FUNC(CGPoint, NSStringFromCGPoint)
_GSSTRINGIFY_DEFINE_FUNC(CGSize, NSStringFromCGSize)
_GSSTRINGIFY_DEFINE_FUNC(CGAffineTransform, NSStringFromCGAffineTransform)
_GSSTRINGIFY_DEFINE_FUNC(NSRange, NSStringFromRange)
_GSSTRINGIFY_DEFINE_FUNC(SEL, NSStringFromSelector)


//
// GSStringify variants for primitives using format strings.
//

#define _GSSTRINGIFY_DEFINE_FORMAT(type, format)                        \
    GS_INLINE_OVERLOAD NSString * GSStringify(type value) {             \
        return [NSString stringWithFormat:format,value];                \
    }

_GSSTRINGIFY_DEFINE_FORMAT(unsigned char, @"'%c'")
_GSSTRINGIFY_DEFINE_FORMAT(long long, @"%lld")
_GSSTRINGIFY_DEFINE_FORMAT(unsigned long long, @"%llu")
_GSSTRINGIFY_DEFINE_FORMAT(float, @"%g")
_GSSTRINGIFY_DEFINE_FORMAT(double, @"%g")
_GSSTRINGIFY_DEFINE_FORMAT(short, @"%hd")
_GSSTRINGIFY_DEFINE_FORMAT(unsigned short, @"%hu")
_GSSTRINGIFY_DEFINE_FORMAT(int, @"%d")
_GSSTRINGIFY_DEFINE_FORMAT(unsigned int, @"%u")
_GSSTRINGIFY_DEFINE_FORMAT(long, @"%ld")
_GSSTRINGIFY_DEFINE_FORMAT(unsigned long, @"%lu")
_GSSTRINGIFY_DEFINE_FORMAT(long double, @"%Lf")
_GSSTRINGIFY_DEFINE_FORMAT(const char *, @"%s")
_GSSTRINGIFY_DEFINE_FORMAT(void *, @"%p")


//
// GSStringify variant for CLLocation coordinates for when the CoreLocation framework
// is available and <CoreLocation/CoreLocation.h> is imported before this header.
//

#ifdef __CORELOCATION__

GS_INLINE_OVERLOAD NSString *GSStringify(CLLocationCoordinate2D value) {
    return [NSString stringWithFormat:@"{%g, %g}",value.latitude,value.longitude];
}

#endif
