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
#import "GSMacros+Defines.h"


typedef NS_OPTIONS(NSUInteger, CGRectAnchor) {
    CGRectAnchorTop = 1 << 0,
    CGRectAnchorCenterY = 1 << 1,
    CGRectAnchorBottom = 1 << 2,
    CGRectAnchorLeft = 1 << 3,
    CGRectAnchorCenterX = 1 << 4,
    CGRectAnchorRight = 1 << 5,
    
    CGRectAnchorOutsideX = 1 << 6,
    CGRectAnchorOutsideY = 1 << 7,
    CGRectAnchorOutside = CGRectAnchorOutsideX | CGRectAnchorOutsideY,
    
    CGRectAnchorTopLeft = CGRectAnchorTop | CGRectAnchorLeft,
    CGRectAnchorTopCenter = CGRectAnchorTop | CGRectAnchorCenterX,
    CGRectAnchorTopRight = CGRectAnchorTop | CGRectAnchorRight,
    CGRectAnchorLeftCenter = CGRectAnchorLeft | CGRectAnchorCenterY,
    CGRectAnchorCenter = CGRectAnchorCenterX | CGRectAnchorCenterY,
    CGRectAnchorRightCenter = CGRectAnchorRight | CGRectAnchorCenterY,
    CGRectAnchorBottomLeft = CGRectAnchorBottom | CGRectAnchorLeft,
    CGRectAnchorBottomCenter = CGRectAnchorBottom | CGRectAnchorCenterX,
    CGRectAnchorBottomRight = CGRectAnchorBottom | CGRectAnchorRight,
    
    CGRectAnchorTopOutside = CGRectAnchorTop | CGRectAnchorOutsideY,
    CGRectAnchorBottomOutside = CGRectAnchorBottom | CGRectAnchorOutsideY,
    CGRectAnchorLeftOutside = CGRectAnchorLeft | CGRectAnchorOutsideX,
    CGRectAnchorRightOutside = CGRectAnchorRight | CGRectAnchorOutsideX,

    CGRectAnchorTopCenterOutside = CGRectAnchorTopOutside | CGRectAnchorCenterX,
    CGRectAnchorBottomCenterOutside = CGRectAnchorBottomOutside | CGRectAnchorCenterX,
    CGRectAnchorLeftCenterOutside = CGRectAnchorLeftOutside | CGRectAnchorCenterY,
    CGRectAnchorRightCenterOutside = CGRectAnchorRightOutside | CGRectAnchorCenterY,
};


GS_INLINE_OVERLOAD CGRect CGRectAlign(CGRect rect, CGRect other, CGRectAnchor anchor, CGFloat paddingX, CGFloat paddingY) {
    NSUInteger outsideX = anchor & CGRectAnchorOutsideX;
    NSUInteger outsideY = anchor & CGRectAnchorOutsideY;
    
    if (anchor & CGRectAnchorTop) {
        rect.origin.y = other.origin.y + (outsideY ? -(rect.size.height + paddingY) : paddingY);
    } else if (anchor & CGRectAnchorBottom) {
        rect.origin.y = other.origin.y + other.size.height + (outsideY ? paddingY : -(rect.size.height + paddingY));
    } else if (anchor & CGRectAnchorCenterY) {
        rect.origin.y = other.origin.y + (other.size.height - rect.size.height) / 2;
    }
    
    if (anchor & CGRectAnchorLeft) {
        rect.origin.x = other.origin.x + (outsideX ? -(rect.size.width + paddingX) : paddingX);
    } else if (anchor & CGRectAnchorRight) {
        rect.origin.x = other.origin.x + other.size.width + (outsideX ? paddingX : -(rect.size.width + paddingX));
    } else if (anchor & CGRectAnchorCenterX) {
        rect.origin.x = other.origin.x + (other.size.width - rect.size.width) / 2;
    }
    
    return rect;
}

GS_INLINE_OVERLOAD CGRect CGRectAlign(CGRect rect, CGRect other, CGRectAnchor anchor) {
    return CGRectAlign(rect, other, anchor, 0, 0);
}

GS_INLINE_OVERLOAD CGRect CGRectAlign(CGRect rect, CGRect other, CGRectAnchor anchor, CGFloat padding) {
    return CGRectAlign(rect, other, anchor, padding, padding);
}


GS_INLINE_OVERLOAD CGRect CGRectInsetAll(CGRect rect, CGFloat top, CGFloat left, CGFloat bottom, CGFloat right) {
    rect.origin.x += left;
    rect.origin.y += top;
    rect.size.width -= left + right;
    rect.size.height -= top + bottom;
    return rect;
}

GS_INLINE_OVERLOAD CGRect CGRectInsetAll(CGRect rect, CGFloat inset) {
    return CGRectInsetAll(rect, inset, inset, inset, inset);
}


GS_INLINE CGRect CGRectInsetLeft(CGRect rect, CGFloat left) {
    rect.origin.x += left;
    rect.size.width -= left;
    return rect;
}

GS_INLINE CGRect CGRectInsetRight(CGRect rect, CGFloat right) {
    rect.size.width -= right;
    return rect;
}

GS_INLINE CGRect CGRectInsetTop(CGRect rect, CGFloat top) {
    rect.origin.y += top;
    rect.size.height -= top;
    return rect;
}

GS_INLINE CGRect CGRectInsetBottom(CGRect rect, CGFloat bottom) {
    rect.size.height -= bottom;
    return rect;
}


GS_INLINE_OVERLOAD CGRect CGRectSized(CGSize size) {
    return (CGRect) {CGPointZero, size};
}

GS_INLINE_OVERLOAD CGRect CGRectSized(CGFloat width, CGFloat height) {
    return (CGRect) {CGPointZero, {width, height}};
}
