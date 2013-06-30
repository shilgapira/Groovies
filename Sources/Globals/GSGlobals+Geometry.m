//
// GSGlobals+Geometry.m
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

#import "GSGlobals+Geometry.h"


__attribute__((overloadable)) CGRect CGRectAlign(CGRect rect, CGRect other, CGRectAnchor anchor) {
    return CGRectAlign(rect, other, anchor, 0.0f, 0.0f);
}

__attribute__((overloadable)) CGRect CGRectAlign(CGRect rect, CGRect other, CGRectAnchor anchor, CGFloat padding) {
    return CGRectAlign(rect, other, anchor, padding, padding);
}

__attribute__((overloadable)) CGRect CGRectAlign(CGRect rect, CGRect other, CGRectAnchor anchor, CGFloat paddingX, CGFloat paddingY) {
    BOOL outside = anchor & CGRectAnchorOutside;
    
    if (anchor & CGRectAnchorTop) {
        rect.origin.y = other.origin.y + (outside ? -(rect.size.height + paddingY) : paddingY);
    } else if (anchor & CGRectAnchorBottom) {
        rect.origin.y = other.origin.y + other.size.height + (outside ? paddingY : -(rect.size.height + paddingY));
    } else if (anchor & CGRectAnchorCenterY) {
        rect.origin.y = other.origin.y + (other.size.height - rect.size.height) / 2.0f;
    }
    
    if (anchor & CGRectAnchorLeft) {
        rect.origin.x = other.origin.x + (outside ? -(rect.size.width + paddingX) : paddingX);
    } else if (anchor & CGRectAnchorRight) {
        rect.origin.x = other.origin.x + other.size.width + (outside ? paddingX : -(rect.size.width + paddingX));
    } else if (anchor & CGRectAnchorCenterX) {
        rect.origin.x = other.origin.x + (other.size.width - rect.size.width) / 2.0f;
    }
    
    return rect;
}
