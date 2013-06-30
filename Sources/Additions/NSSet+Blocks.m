//
// NSSet+Blocks.m
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

#import "NSSet+Blocks.h"


@implementation NSSet (Blocks)

- (void)each:(void(^)(id object))block {
    for (id object in self) {
        block(object);
    }
}

- (NSSet *)map:(id(^)(id object))block {
    NSMutableSet *result = [NSMutableSet setWithCapacity:self.count];
    
    for (id object in self) {
        [result addObject:block(object)];
    }
    
    return result;
}

- (NSSet *)select:(BOOL(^)(id object))predicate {
    NSMutableSet *result = [NSMutableSet setWithCapacity:self.count];
    
    for (id object in self) {
        if (predicate(object)) {
            [result addObject:object];
        }
    }
    
    return result;
}

- (NSSet *)filter:(BOOL(^)(id object))predicate {
    NSMutableSet *result = [NSMutableSet setWithCapacity:self.count];
    
    for (id object in self) {
        if (!predicate(object)) {
            [result addObject:object];
        }
    }
    
    return result;
}

@end
