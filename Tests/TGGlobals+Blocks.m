//
// TGGlobals+Blocks.m
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

#import "TGGlobals+Blocks.h"
#import "GSGlobals+Blocks.h"


@implementation TGGlobals_Blocks

- (void)testMain {
    __block BOOL executed = NO;
    GSExecuteMain(^{
        executed = YES;
    });
    TGAssertNot(executed);
}

- (void)testDelayed {
    __block BOOL executed = NO;
    GSExecuteDelayed(0, ^{
        executed = YES;
    });
    TGAssertNot(executed);
}

- (void)testBackground {
    __block BOOL executed = NO;
    __block BOOL background = NO;
    
    GSExecuteBackground(^{
        executed = YES;
        background = ![NSThread isMainThread];
    });
    
    [NSThread sleepForTimeInterval:0.01];
    
    TGAssert(executed);
    TGAssert(background);
}

- (void)testTiming {
    NSTimeInterval epsilon = 0.01;
    
    for (NSTimeInterval time = 0.01; time < 0.2; time *= 1.5) {
        NSTimeInterval measured = GSExecuteTimed(^{
            [NSThread sleepForTimeInterval:time];
        });
        NSLog(@"Interval: %g, Measured: %g", time, measured);
        TGAssert(measured > time - epsilon);
        TGAssert(measured < time + epsilon);
    }
}

@end
