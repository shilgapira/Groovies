//
// UIColor+Create.h
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

#import <UIKit/UIKit.h>
#import "GSMacros+Varargs.h"


/**
 * Creates a UIColor instance with a hex color number (0xRRGGBB long) and with
 * an optional alpha value (0..1 float). For example,
 *
 *     UIColor *blue = COLORHEX(0x4444ff);
 *     UIColor *white = COLORHEX(0xffffff);
 *     UIColor *shadow = COLORHEX(0x000000, 0.3f);
 */
#define COLORHEX(hex, ...)          _COLORHEX(hex, ##__VA_ARGS__)


/**
 * Creates a UIColor instance with RGB color values (0..255 ints) and
 * with an optional alpha value (0..1 float). For example,
 *
 *     UIColor *blue = COLORRGB(68, 68, 255);
 *     UIColor *white = COLORRGB(255, 255, 255);
 *     UIColor *shadow = COLORRGB(0, 0, 0, 0.3f);
 */
#define COLORRGB(r, g, b, ...)      _COLORRGB(r, g, b, ##__VA_ARGS__)


/*
 * Creates a UIColor instance with HSV color values (hue 0..360 int,
 * sat/value 0..100 ints) and with an optional alpha value (0..1 float).
 * For example,
 *
 *     UIColor *blue = COLORHSV(240, 73, 100);
 *     UIColor *white = COLORHSV(0, 0, 100);
 *     UIColor *shadow = COLORHSV(0, 0, 0, 0.3f);
 */
#define COLORHSV(h, s, v, ...)      _COLORHSV(h, s, v, ##__VA_ARGS__)


/**
 * UIColor extensions that allow easier creation of color objects.
 */
@interface UIColor (Create)

/**
 * Creates a UIColor object with a hex color number and an alpha value.
 * @param hex The color number, e.g., 0xff8844.
 * @param alpha The alpha value specified as a value in the 0..1 range.
 * @return The color object.
 */
+ (UIColor *)colorWithHex:(long)hex alpha:(float)alpha;

@end



//
// Implementation details, do not use directly
//

#define _COLORHEX(hex, ...)     GS_VA_OVERLOAD(_COLORHEX, hex, ##__VA_ARGS__)
#define _COLORHEX1(hex)         _COLORHEX2(hex, 1.0f)
#define _COLORHEX2(hex, a)      [UIColor colorWithHex:(hex) alpha:(a)]

#define _COLORRGB(r, g, b, ...) GS_VA_OVERLOAD(_COLORRGB, r, g, b, ##__VA_ARGS__)
#define _COLORRGB3(r, g, b)     _COLORRGB4(r, g, b, 1.0f)
#define _COLORRGB4(r, g, b, a)  [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:(a)]

#define _COLORHSV(h, s, v, ...) GS_VA_OVERLOAD(_COLORHSV, h, s, v, ##__VA_ARGS__)
#define _COLORHSV3(h, s, v)     _COLORHSV4(h, s, v, 1.0f)
#define _COLORHSV4(h, s, v, a)  [UIColor colorWithHue:(h)/360.0f saturation:(s)/100.0f brightness:(v)/100.0f alpha:(a)]
