//
// TGGlobals+Geometry.m
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

#import "TGGlobals+Geometry.h"
#import "GSGlobals+Geometry.h"


@implementation TGGlobals_Geometry

- (void)testAlign {
    CGRect rect = CGRectSized(5, 5);
    CGRect other = CGRectMake(-10, -10, 20, 20);;
    CGRect result = CGRectZero;
    
    result = CGRectAlign(rect, other, CGRectAnchorTopRight);
    TGAssert(CGRectEqualToRect(result, CGRectMake(5, -10, 5, 5)));
    
    result = CGRectAlign(rect, other, CGRectAnchorBottomLeft);
    TGAssert(CGRectEqualToRect(result, CGRectMake(-10, 5, 5, 5)));
    
    result = CGRectAlign(rect, other, CGRectAnchorRightCenter, 1, 1000);
    TGAssert(CGRectEqualToRect(result, CGRectMake(4, -2.5, 5, 5)));

    
    result = CGRectAlign(rect, other, CGRectAnchorCenter);
    TGAssert(CGRectEqualToRect(result, CGRectMake(-2.5, -2.5, 5, 5)));
    
    result = CGRectAlign(rect, other, CGRectAnchorCenter, 1000);
    TGAssert(CGRectEqualToRect(result, CGRectMake(-2.5, -2.5, 5, 5)));
    
    
    result = CGRectAlign(rect, other, CGRectAnchorTop, 3);
    TGAssert(CGRectEqualToRect(result, CGRectMake(0, -7, 5, 5)));

    result = CGRectAlign(rect, other, CGRectAnchorCenterX);
    TGAssert(CGRectEqualToRect(result, CGRectMake(-2.5, 0, 5, 5)));
    
    
    result = CGRectAlign(rect, other, CGRectAnchorTopOutside);
    TGAssert(CGRectEqualToRect(result, CGRectMake(0, -15, 5, 5)));
    
    result = CGRectAlign(rect, other, CGRectAnchorTopOutside | CGRectAnchorLeft, 0, -2);
    TGAssert(CGRectEqualToRect(result, CGRectMake(-10, -13, 5, 5)));
    
    result = CGRectAlign(rect, other, CGRectAnchorBottomOutside | CGRectAnchorRight);
    TGAssert(CGRectEqualToRect(result, CGRectMake(5, 10, 5, 5)));
    
    result = CGRectAlign(rect, other, CGRectAnchorBottom | CGRectAnchorLeft | CGRectAnchorOutsideX, 2, -3);
    TGAssert(CGRectEqualToRect(result, CGRectMake(-17, 8, 5, 5)));
    
    result = CGRectAlign(rect, other, 0);
    TGAssert(CGRectEqualToRect(result, rect));
    
    
    rect = CGRectZero;
    
    result = CGRectAlign(rect, other, CGRectAnchorTopRight);
    TGAssert(CGRectEqualToRect(result, CGRectMake(10, -10, 0, 0)));
    
    result = CGRectAlign(rect, other, CGRectAnchorBottom | CGRectAnchorLeft | CGRectAnchorOutsideX, 2, -3);
    TGAssert(CGRectEqualToRect(result, CGRectMake(-12, 13, 0, 0)));
    
    result = CGRectAlign(rect, other, 0);
    TGAssert(CGRectEqualToRect(result, rect));
}

- (void)testInset {
    CGRect rect = CGRectSized(5, 5);
    CGRect result = CGRectZero;
    
    result = CGRectInsetAll(rect, 1, 0, -2, 0.5);
    TGAssert(CGRectEqualToRect(result, CGRectMake(0, 1, 4.5, 6)));
    
    result = CGRectInsetAll(rect, 1.2f);
    TGAssert(CGRectEqualToRect(result, CGRectMake(1.2f, 1.2f, 2.6f, 2.6f)));
    
    result = CGRectInsetAll(rect, 0);
    TGAssert(CGRectEqualToRect(result, rect));
}

@end
