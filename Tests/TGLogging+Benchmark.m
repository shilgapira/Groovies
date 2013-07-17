//
// TGLogging+Benchmark.m
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

#import "TGLogging+Benchmark.h"
#import "GSLogging+Benchmark.h"
#import "GSGlobals+Blocks.h"


@implementation TGLogging_Benchmark

- (void)testBenchmark {
    for (NSUInteger count = 5000; count <= 500000; count *= 10) {
        for (NSUInteger repeat = 0; repeat < 10; repeat++) {
            GSBLog([self work:count]);
        }
    }
}

- (void)work:(NSUInteger)count {
    uint64_t sum = 0;
    for (NSUInteger n = 0; n < count; n++) {
        sum += n;
    }
}

@end
