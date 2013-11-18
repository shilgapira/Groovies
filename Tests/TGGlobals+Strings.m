//
// TGGlobals+Strings.m
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

#import "TGGlobals+Strings.h"


// So we can test GSStringify(CLLocationCoordinate2D value) without the framework
#ifndef __CORELOCATION__
#define __CORELOCATION__
typedef double CLLocationDegrees;
typedef struct { CLLocationDegrees latitude; CLLocationDegrees longitude; } CLLocationCoordinate2D;
#endif


#import "GSGlobals+Strings.h"


@implementation TGGlobals_Strings

- (void)testObjects {
    TGAssertEqualObjects(GSStringify(self), [self description]);
    
    id obj = nil;
    TGAssertEqualObjects(GSStringify(obj), [obj description]);
    
    obj = @[ @"hello" ];
    TGAssertEqualObjects(GSStringify(obj), [obj description]);
    
    obj = self.class;
    TGAssertEqualObjects(GSStringify(obj), [obj description]);
    
    obj = @"hello";
    TGAssertEqualObjects(GSStringify(obj), [obj description]);
    
    obj = @(42);
    TGAssertEqualObjects(GSStringify(obj), [obj description]);
    
    obj = self;
    TGAssertEqualObjects(GSStringify(obj), [obj description]);
}

- (void)testPointers {
    char *str = "world";
    TGAssertEqualObjects(GSStringify(str), @(str));
    
    const char *cst = "world";
    TGAssertEqualObjects(GSStringify(cst), @(cst));
    
    void *buffer = str;
    TGAssertEqualObjects(GSStringify(buffer), ([NSString stringWithFormat:@"%p",buffer]));
}

- (void)testNumbers {
    TGAssertEqualObjects(GSStringify(0), @"0");
    TGAssertEqualObjects(GSStringify(0.0), @"0");
    TGAssertEqualObjects(GSStringify(0.1f), @"0.1");
    TGAssertEqualObjects(GSStringify(256), [@(256) stringValue]);
    TGAssertEqualObjects(GSStringify(-8), [@(-8) stringValue]);
    TGAssertEqualObjects(GSStringify(128), [@(128) stringValue]);
    TGAssertEqualObjects(GSStringify(-127), [@(-127) stringValue]);
    TGAssertEqualObjects(GSStringify(NSIntegerMax), [@(NSIntegerMax) stringValue]);
    TGAssertEqualObjects(GSStringify(NSIntegerMin), [@(NSIntegerMin) stringValue]);
    TGAssertEqualObjects(GSStringify(LLONG_MIN), [@(LLONG_MIN) stringValue]);
    TGAssertEqualObjects(GSStringify(LLONG_MAX), [@(LLONG_MAX) stringValue]);
    TGAssertEqualObjects(GSStringify(LONG_MIN), [@(LONG_MIN) stringValue]);
    TGAssertEqualObjects(GSStringify(LONG_MAX), [@(LONG_MAX) stringValue]);
    TGAssertEqualObjects(GSStringify(ULONG_MAX), [@(ULONG_MAX) stringValue]);
    TGAssertEqualObjects(GSStringify(FLT_MIN), ([NSString stringWithFormat:@"%g",FLT_MIN]));
    TGAssertEqualObjects(GSStringify(FLT_MAX), ([NSString stringWithFormat:@"%g",FLT_MAX]));
    TGAssertEqualObjects(GSStringify(DBL_MIN), ([NSString stringWithFormat:@"%g",DBL_MIN]));
    TGAssertEqualObjects(GSStringify(DBL_MAX), ([NSString stringWithFormat:@"%g",DBL_MAX]));
    TGAssertEqualObjects(GSStringify(LDBL_MIN), ([NSString stringWithFormat:@"%Lf",LDBL_MIN]));
    TGAssertEqualObjects(GSStringify(LDBL_MAX), ([NSString stringWithFormat:@"%Lf",LDBL_MAX]));
}

- (void)testBool {
    TGAssertEqualObjects(GSStringify(YES), @"YES");
    TGAssertEqualObjects(GSStringify(NO), @"NO");
    
    BOOL b = 65;
    if (__builtin_types_compatible_p(BOOL, bool)) {
        TGAssertEqualObjects(GSStringify(b), @"YES");
    } else {
        TGAssertEqualObjects(GSStringify(b), @"65");
    }

    signed char c = 65;
    TGAssertEqualObjects(GSStringify(c), @"65");
    
    c = 0;
    if (__builtin_types_compatible_p(BOOL, signed char)) {
        TGAssertEqualObjects(GSStringify(c), @"NO");
    } else {
        TGAssertEqualObjects(GSStringify(c), @"0");
    }
    TGAssertEqualObjects(GSStringify((BOOL) c), @"NO");
    
    c = 1;
    if (__builtin_types_compatible_p(BOOL, signed char)) {
        TGAssertEqualObjects(GSStringify(c), @"YES");
    } else {
        TGAssertEqualObjects(GSStringify(c), @"1");
    }
    TGAssertEqualObjects(GSStringify((BOOL) c), @"YES");
    
    c = -127;
    TGAssertEqualObjects(GSStringify(c), @"-127");
    
    unsigned char u = 65;
    TGAssertEqualObjects(GSStringify(u), @"'A'");
    
    u = 0;
    TGAssert(![@"NO" isEqual:GSStringify(u)]);
    
    u = 1;
    TGAssert(![@"YES" isEqual:GSStringify(u)]);
}

- (void)testSelector {
    SEL sel = @selector(performSelector:onThread:withObject:waitUntilDone:);
    TGAssertEqualObjects(GSStringify(sel), NSStringFromSelector(sel));
}

- (void)testGeometry {
    CGRect rect = CGRectMake(0.0f, 20.0f, 320.0f, 460.0f);
    TGAssertEqualObjects(GSStringify(rect), NSStringFromCGRect(rect));
    
    TGAssertEqualObjects(GSStringify(rect.origin), NSStringFromCGPoint(rect.origin));
    
    TGAssertEqualObjects(GSStringify(rect.size), NSStringFromCGSize(rect.size));
    
    NSRange range = NSMakeRange(8, 10);
    TGAssertEqualObjects(GSStringify(range), NSStringFromRange(range));
    
    CGAffineTransform transform = CGAffineTransformMakeRotation((CGFloat) M_PI_2);
    TGAssertEqualObjects(GSStringify(transform), NSStringFromCGAffineTransform(transform));
}

- (void)testLocation {
    CLLocationCoordinate2D coords = (CLLocationCoordinate2D) { 30, 10.1234 };
    TGAssertEqualObjects(GSStringify(coords), @"{30, 10.1234}");
}

// Should fail compilation
#if 0
typedef struct {
    double x;
    double f;
} UnknownStruct;

- (void)testFail {
    UnknownStruct unknown = { 91, 0.83f };
    GSStringify(unknown);
}
#endif

@end
