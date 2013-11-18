//
// TGMacros+Maths.m
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

#import "TGMacros+Math.h"
#import "GSMacros+Math.h"


@implementation TGMacros_Math

- (void)testMinMax {
    TGAssertEquals(GSMinMax(0, -10, 100), 0);
    TGAssertEquals(GSMinMax(10, -10, 100), 10);
    
    TGAssertEquals(GSMinMax(99, -10, 100), 99);
    TGAssertEquals(GSMinMax(100, -10, 100), 100);
    TGAssertEquals(GSMinMax(101, -10, 100), 100);
    
    TGAssertEquals(GSMinMax(-9, -10, 100), -9);
    TGAssertEquals(GSMinMax(-10, -10, 100), -10);
    TGAssertEquals(GSMinMax(-11, -10, 100), -10);

    TGAssertEquals(GSMinMax(-8, 0, 0), 0);
    TGAssertEquals(GSMinMax(0, 0, 0), 0);
    TGAssertEquals(GSMinMax(1, 0, 0), 0);
    TGAssertEquals(GSMinMax(8, 0, 0), 0);
    
    TGAssertEquals(GSMinMax(-9.3, -10.7, 100.9), -9.3);
    TGAssertEquals(GSMinMax(-10.7f, -10.7f, 100.9f), -10.7f);
    TGAssertEquals(GSMinMax(111.5f, -10.7f, 100.9f), 100.9f);
}

- (void)testBits {
    TGAssert(GSHasBits(0, 0));
    TGAssert(GSHasBits(1, 0));
    TGAssert(GSHasBits(8, 0));

    TGAssert(GSHasBits(1, 1));
    TGAssert(GSHasBits(4, 4));
    TGAssert(GSHasBits(13, 4 | 8 | 1));
    
    TGAssert(GSHasBits(0b01011111, 0b01001101));
    TGAssertNot(GSHasBits(0b00011111, 0b01001101));
    
    NSUInteger nbits = (NSUInteger) sizeof(NSUInteger) * 8;
    
    NSUInteger mask = 0;
    for (NSUInteger i = 0; i < nbits; i++) {
        NSUInteger x = (NSUInteger) 1 << i;
        
        TGAssertNot(GSHasBits(mask, x));
        
        mask |= x;
        
        TGAssert(GSHasBits(mask, x));
        
        if (i > 0) {
            NSUInteger y = (NSUInteger) 1 << (i - 1);
            TGAssertNot(GSHasBits(x, y));
        }
        
        TGAssert(GSHasBits(mask, 0u));
    }
}

typedef NS_OPTIONS(NSUInteger, TGTestEnum) {
    TGTestEnumNone = 0,
    TGTestEnumA = 1 << 0,
    TGTestEnumB = 1 << 1,
    TGTestEnumC = 1 << 2,
    TGTestEnumD = 1 << 3,
};

- (void)testEnums {
    TGTestEnum t = TGTestEnumNone;
    
    TGAssert(GSHasBits(t, TGTestEnumNone));
    TGAssertNot(GSHasBits(t, TGTestEnumA));
    TGAssertNot(GSHasBits(t, TGTestEnumD));
    
    t = TGTestEnumA;

    TGAssert(GSHasBits(t, TGTestEnumNone));
    TGAssert(GSHasBits(t, TGTestEnumA));
    TGAssertNot(GSHasBits(t, TGTestEnumD));
    
    t |= TGTestEnumC;

    TGAssert(GSHasBits(t, TGTestEnumNone));
    TGAssert(GSHasBits(t, TGTestEnumA));
    TGAssert(GSHasBits(t, TGTestEnumC));
    TGAssert(GSHasBits(t, TGTestEnumA | TGTestEnumC));
    TGAssertNot(GSHasBits(t, TGTestEnumD));
    
    t = (TGTestEnumD << 1);
    
    TGAssert(GSHasBits(t, TGTestEnumNone));
    TGAssertNot(GSHasBits(t, TGTestEnumA));
    TGAssertNot(GSHasBits(t, TGTestEnumC));
    TGAssertNot(GSHasBits(t, TGTestEnumA | TGTestEnumC));
    TGAssertNot(GSHasBits(t, TGTestEnumD));
}

@end
