//
// TGMacros+Varargs.m
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

#import "TGMacros+Varargs.h"
#import "GSMacros+Varargs.h"


@implementation TGMacros_Varargs

- (void)testCount {
    TGAssertEquals(0, GS_VA_COUNT());
    TGAssertEquals(1, GS_VA_COUNT(a));
    TGAssertEquals(2, GS_VA_COUNT(i, j));
    TGAssertEquals(3, GS_VA_COUNT(a, b, c));
    TGAssertEquals(4, GS_VA_COUNT(x, y, z, w));
    TGAssertEquals(5, GS_VA_COUNT(1, 2, 3, 4,5));
}


#define IncreaseEach(...)   GS_VA_FOREACH(Increase, ##__VA_ARGS__)

#define Increase(x)         (x++)

- (void)testEach {
    int foo = 0;
    int bar = 0;
    
    IncreaseEach(foo);
    
    TGAssert(foo == 1);
    
    IncreaseEach(foo, bar);
    
    TGAssert(foo == 2);
    TGAssert(bar == 1);
    
    if (0 == 1)
        IncreaseEach(foo, bar);
    else
        IncreaseEach(foo, foo, bar, foo);
    
    TGAssert(foo == 5);
    TGAssert(bar == 2);
}


#define Average(...)                 GS_VA_OVERLOAD(_Average, ##__VA_ARGS__)

#define _Average0(x)                 (0)
#define _Average1(x)                 (x)
#define _Average2(x, y)              (((x) + (y)) / 2)
#define _Average3(x, y, z)           (((x) + (y) + (z)) / 3)
#define _Average4(x, y, z, w)        (((x) + (y) + (z) + (w)) / 4)

- (void)testOverload {
    TGAssertEquals(Average(), 0);
    TGAssertEquals(Average(5), 5);
    TGAssertEquals(Average(4, 12), 8);
    TGAssertEquals(Average(80, 100, 90), 90);
    TGAssertEquals(Average(8, 9, 10, 13), 10);
}

@end
