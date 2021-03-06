//
// TGMacros+Language.m
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

#import "TGMacros+Language.h"
#import "GSMacros+Language.h"
#import "GSLogging+Assert.h"


@protocol TGFoobar <NSObject>

- (NSString *)foobar;

@end


@interface TGMacros_Language () <TGFoobar>

@end


@implementation TGMacros_Language

SINGLETON(testSingleton);

- (NSString *)foobar {
    return @"FOOBAR!";
}

- (void)testSingleton {
    id foo = [TGMacros_Language testSingleton];
    TGAssertNotNil(foo);
    
    id bar = [TGMacros_Language testSingleton];
    TGAssertNotNil(bar);
    TGAssertEqualObjects(foo, bar);
}

- (void)testObjectKeypath {
    NSString *k1 = @"foobar";
    NSString *k2 = KEYPATH(self, foobar);
    TGAssertEqualObjects(k1, k2);
    TGAssertEquals(k1, k2);
    TGAssertEqualObjects([self valueForKey:k1], [self valueForKey:k2]);
}

- (void)testClassKeypath {
    NSString *k1 = @"foobar";
    NSString *k2 = KEYPATH(TGMacros_Language, foobar);
    TGAssertEqualObjects(k1, k2);
    TGAssertEquals(k1, k2);
    TGAssertEqualObjects([self valueForKey:k1], [self valueForKey:k2]);
}

- (void)testProtocolKeypath {
    NSString *k1 = @"foobar";
    NSString *k2 = KEYPATH(id<TGFoobar>, foobar);
    TGAssertEqualObjects(k1, k2);
    TGAssertEquals(k1, k2);
    TGAssertEqualObjects([self valueForKey:k1], [self valueForKey:k2]);
}

- (void)testArrayKeypath {
    NSObject *x = @1;
    NSObject *y = @"Hello";
    NSObject *z = @YES;
    NSArray *objects = @[ x, y, z ];
    
    NSArray *d1 = [objects valueForKey:@"description"];
    NSArray *d2 = [objects valueForKey:KEYPATH(x, description)];
    NSArray *d3 = [objects valueForKey:KEYPATH(NSObject, description)];
    NSArray *d4 = [objects valueForKey:KEYPATH(id<NSObject>, description)];
    
    TGAssertEqualObjects(d1, d2);
    TGAssertEqualObjects(d2, d3);
    TGAssertEqualObjects(d3, d4);
}

// Should fail compilation on a2, a3, and a4
#if 0
- (void)testInvalidKeypath {
    NSObject *x = @1;
    NSObject *y = @"Hello";
    NSObject *z = @YES;
    NSArray *objects = @[ x, y, z ];
    
    NSArray *a1 = [objects valueForKey:@"description"];
    NSArray *a2 = [objects valueForKey:KEYPATH(x, desc)];
    NSArray *a3 = [objects valueForKey:KEYPATH(NSObject, desc)];
    NSArray *a4 = [objects valueForKey:KEYPATH(id<NSObject>, desc)];
}
#endif

- (void)testSelector {
    SEL s1 = @selector(description);
    SEL s2 = SELECTOR(self, description);
    TGAssertEquals(s1, s2);
    
    s1 = @selector(objectAtIndex:);
    s2 = SELECTOR([NSMutableArray new], objectAtIndex:);
    TGAssertEquals(s1, s2);
    
    s1 = @selector(setObject:forKey:);
    s2 = SELECTOR([NSMutableDictionary new], setObject:forKey:);
    TGAssertEquals(s1, s2);
    
    TGAssertDebugThrows(s1 = SELECTOR(self, length));
    TGAssertDebugThrows(s1 = SELECTOR(self, objectAtIndex:));
    TGAssertDebugThrows(s1 = SELECTOR(self, setObject:forKey:));
}

- (void)testSwap {
    NSUInteger x = 99;
    NSUInteger y = 101;
    
    NSUInteger a = x;
    NSUInteger b = y;
    
    SWAP(a, b);
    
    TGAssert(a == y);
    TGAssert(b == x);
    
    id i = @(x);
    id j = @(y);
    
    SWAP(i, j);
    
    TGAssertEqualObjects(i, @(y));
    TGAssertEqualObjects(j, @(x));
}

- (void)testWeakify {
    __block BOOL firstFailed = NO;
    __block BOOL secondFailed = NO;
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
        __block id obj = [NSObject new];
        WEAKIFY(obj);

        dispatch_time_t time1 = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC));
        dispatch_after(time1, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^(void){
            STRONGIFY(obj);
            if (!obj) {
                firstFailed = YES;
            }
        });
        
        dispatch_time_t time2 = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC));
        dispatch_after(time2, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^(void){
            obj = nil;
        });
        
        dispatch_time_t time3 = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC));
        dispatch_after(time3, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^(void){
            STRONGIFY(obj);
            if (obj) {
                secondFailed = YES;
            }
        });
    });
    
    [NSThread sleepForTimeInterval:0.5f];
    
    TGAssertNot(firstFailed);
    TGAssertNot(secondFailed);
}

@end
