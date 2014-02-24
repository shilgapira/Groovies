//
// GSMacros+Colors.h
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

#import "GSMacros+Varargs.h"



/**
 * Creates a UIColor/NSColor instance using various color representations.
 *
 * Colors can be created with hex codes using one of the following formats:
 *
 *     // 8 char length hex code for full RGB colors
 *     UIColor *orange = GSColor(0xFF8000);
 *
 *     // 4 char length hex code for grayscale colors
 *     UIColor *white = GSColor(0xFF);
 *
 *     // Optional alpha argument (always 0..1 float)
 *     UIColor *shadow = GSColor(0x00, 0.5f);
 *
 * The following formats are supported for integers:
 *
 *     // RGB components as integers in the 0..255 range
 *     UIColor *orange = GSColor(255, 128, 0);
 *     
 *     // Optional alpha argument (always 0..1 float)
 *     UIColor *glow = GSColor(255, 192, 0, 0.5f);
 *
 * The following formats are supported for floats:
 *
 *     // RGB components as floats in the 0..1 range
 *     UIColor *orange = GSColor(1.0f, 0.5f, 0);
 *
 *     // Grayscale color as float in the 0..1 range
 *     UIColor *white = GSColor(1.0f);
 *
 *     // Optional alpha argument
 *     UIColor *glow = GSColor(1.0f, 0.5f, 0, 0.5f);
 *
 * For convenience, the macro returns clearColor when called without
 * any arguments:
 *
 *     // Equivalent to [UIColor clearColor]
 *     UIColor *transparent = GSColor();
 */
#define GSColor(...)                    GS_VA_OVERLOAD(_GSColor, ##__VA_ARGS__)



//
// Implementation details, do not use directly
//

// Platform specific variants
#if TARGET_OS_IPHONE
    #define _GSColorClear()             [UIColor clearColor]
    #define _GSColorRGB(r, g, b, a)     [UIColor colorWithRed:(CGFloat)(r) green:(CGFloat)(g) blue:(CGFloat)(b) alpha:(CGFloat)(a)]
    #define _GSColorWhite(w, a)         [UIColor colorWithWhite:(CGFloat)(w) alpha:(CGFloat)(a)]
#else
    #define _GSColorClear()             [NSColor clearColor]
    #define _GSColorRGB(r, g, b, a)     [NSColor colorWithCalibratedRed:(CGFloat)(r) green:(CGFloat)(g) blue:(CGFloat)(b) alpha:(CGFloat)(a)]
    #define _GSColorWhite(w, a)         [NSColor colorWithCalibratedWhite:(CGFloat)(w) alpha:(CGFloat)(a)]
#endif

// Coverts hex colors to RGB float triplets
#define _GSColorHex(h, a)               _GSColorRGB((CGFloat) (((h) & 0xFF0000) >> 16) / 255, (CGFloat) (((h) & 0xFF00) >> 8) / 255, (CGFloat) ((h) & 0xFF) / 255, a)

// Overloaded macros
#define _GSColor0()                     _GSColorClear()

#define _GSColor1(c)                    _GSColor2(c, 1)

#define _GSColor2(c, a)                                                                         \
    __builtin_choose_expr(__builtin_types_compatible_p(typeof(c), typeof(0xFFFFFF)),            \
        __builtin_choose_expr(sizeof(#c) == sizeof("0xFFFFFF"),                                 \
            _GSColorHex((unsigned long) (c), a),                                                \
            __builtin_choose_expr(sizeof(#c) == sizeof("0xFF"),                                 \
                _GSColorWhite((CGFloat) (c) / 255, a),                                          \
                _GSColorWhite(c, a))),                                                          \
        _GSColorWhite(c, a))

#define _GSColor3(r, g, b)              _GSColor4(r, g, b, 1)

#define _GSColor4(r, g, b, a)                                                                   \
    __builtin_choose_expr(__builtin_types_compatible_p(typeof((r)+(g)+(b)), typeof(255)),       \
        _GSColorRGB((CGFloat) (r) / 255, (CGFloat) (g) / 255, (CGFloat) (b) / 255, a),          \
        _GSColorRGB(r, g, b, a))
