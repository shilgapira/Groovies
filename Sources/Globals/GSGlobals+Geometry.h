//
// GSGlobals+Geometry.h
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

#import <QuartzCore/QuartzCore.h>


typedef NS_OPTIONS(NSUInteger, CGRectAnchor) {
    CGRectAnchorTop = 1 << 0,
    CGRectAnchorCenterY = 1 << 1,
    CGRectAnchorBottom = 1 << 2,
    CGRectAnchorLeft = 1 << 3,
    CGRectAnchorCenterX = 1 << 4,
    CGRectAnchorRight = 1 << 5,
    CGRectAnchorOutside = 1 << 6,
    CGRectAnchorTopLeft = CGRectAnchorTop | CGRectAnchorLeft,
    CGRectAnchorTopCenter = CGRectAnchorTop | CGRectAnchorCenterX,
    CGRectAnchorTopRight = CGRectAnchorTop | CGRectAnchorRight,
    CGRectAnchorCenterLeft = CGRectAnchorCenterY | CGRectAnchorLeft,
    CGRectAnchorCenter = CGRectAnchorCenterY | CGRectAnchorCenterX,
    CGRectAnchorCenterRight = CGRectAnchorCenterY | CGRectAnchorRight,
    CGRectAnchorBottomLeft = CGRectAnchorBottom | CGRectAnchorLeft,
    CGRectAnchorBottomCenter = CGRectAnchorBottom | CGRectAnchorCenterX,
    CGRectAnchorBottomRight = CGRectAnchorBottom | CGRectAnchorRight,
};

extern __attribute__((overloadable)) CGRect CGRectAlign(CGRect rect, CGRect other, CGRectAnchor anchor);

extern __attribute__((overloadable)) CGRect CGRectAlign(CGRect rect, CGRect other, CGRectAnchor anchor, CGFloat padding);

extern __attribute__((overloadable)) CGRect CGRectAlign(CGRect rect, CGRect other, CGRectAnchor anchor, CGFloat paddingX, CGFloat paddingY);


NS_INLINE CGRect CGRectInsetAll(CGRect rect, CGFloat top, CGFloat left, CGFloat bottom, CGFloat right) {
    rect.origin.x += left;
    rect.origin.y += top;
    rect.size.width -= left + right;
    rect.size.height -= top + bottom;
    return rect;
}

NS_INLINE CGRect CGRectInsetLeft(CGRect rect, CGFloat left) {
    rect.origin.x += left;
    rect.size.width -= left;
    return rect;
}

NS_INLINE CGRect CGRectInsetRight(CGRect rect, CGFloat right) {
    rect.size.width -= right;
    return rect;
}

NS_INLINE CGRect CGRectInsetTop(CGRect rect, CGFloat top) {
    rect.origin.y += top;
    rect.size.height -= top;
    return rect;
}

NS_INLINE CGRect CGRectInsetBottom(CGRect rect, CGFloat bottom) {
    rect.size.height -= bottom;
    return rect;
}


NS_INLINE __attribute__((overloadable)) CGRect CGRectSized(CGSize size) {
    return (CGRect) {CGPointZero, size};
}

NS_INLINE __attribute__((overloadable)) CGRect CGRectSized(CGFloat width, CGFloat height) {
    return (CGRect) {CGPointZero, {width, height}};
}
