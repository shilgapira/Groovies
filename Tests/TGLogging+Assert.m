//
// TGLogging+Assert.m
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

#import "TGLogging+Assert.h"
#import "GSLogging+Assert.h"


@implementation TGLogging_Assert

- (void)testAssert {
    TGAssertDebugThrows(GSAssert(0));

    TGAssertDebugThrows(GSAssert(NO));
    TGAssertNoThrow(GSAssert(YES));
    
    TGAssertNoThrow(GSAssert(1));
    TGAssertNoThrow(GSAssert(self));
    
    TGAssertEquals(GSAssert(self), self);
    
    TGAssertNoThrow(GSAssert(self.description.length));
    TGAssertDebugThrows(GSAssert(self.description.length > 1000));
    TGAssertDebugThrows(GSAssert(self.description.length > 1000, @"Asserted length was equal to %d", self.description.length));
    
    NSUInteger length = 0;
    TGAssertNoThrow(length = GSAssert(self.description.length));
}

- (void)testEqual {
    TGAssertNoThrow(GSAssertEqual(self, self));
    TGAssertNoThrow(GSAssertEqual(self.class, TGLogging_Assert.class));
    TGAssertNoThrow(GSAssertEqual(nil, nil));
    
    TGAssertDebugThrows(GSAssertEqual(self, nil));
    TGAssertDebugThrows(GSAssertEqual(nil, self));
    TGAssertDebugThrows(GSAssertEqual(self, self.description));

    BOOL returnValue = NO;
    TGAssert(returnValue = GSAssertEqual(@8, @8));
    TGAssert(returnValue = GSAssertEqual(nil, nil));
}

- (void)testFailed {
    TGAssertDebugThrows(GSAssertFailed());
    TGAssertDebugThrows(GSAssertFailed(@"Failed!"));
    
    int returnValue = 1;
    TGAssertDebugThrows(returnValue = GSAssertFailed(@"Failed!"));
}

- (void)testMainThread {
    TGAssertNoThrow(GSAssertMainThread());

    int returnValue = 1;
    TGAssert(returnValue = GSAssertMainThread());

    __block BOOL thrown = NO;
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        @try {
            GSAssertMainThread();
        }
        @catch (NSException *exception) {
            thrown = YES;
        }
    });
    
    [NSThread sleepForTimeInterval:0.1];

#ifdef DEBUG
    TGAssert(thrown);
#endif
}

- (void)testKind {
    TGAssertNoThrow(GSAssertKind(self, TGLogging_Assert));
    TGAssertNoThrow(GSAssertKind(self, SenTestCase));
    TGAssertNoThrow(GSAssertKind(self, NSObject));
    
    TGAssertDebugThrows(GSAssertKind(self, NSString));
    TGAssertDebugThrows(GSAssertKind(self, NSNumber));

    TGLogging_Assert *me;
    TGAssertNoThrow(me = GSAssertKind(self, TGLogging_Assert));
    TGAssertDebugThrows(GSAssertKind(me, NSDictionary));

    // This should cause a compilation error if the #if 0 directive is
    // removed. GSAssertKind's return value has the statis type of the 
    // object, which in this case is NSArray. NSArray is incompatible 
    // with a pointer of type NSDictionary so the compiler barks.
#if 0
    NSDictionary *dict1;
    TGAssertDebugThrows(dict1 = GSAssertKind(@[], NSDictionary));
#endif
    
    // id is compatible with every pointer type, so the same assert
    // compiles successfully here
    id dict2;
    TGAssertDebugThrows(dict2 = GSAssertKind(@[], NSDictionary));
}

- (void)testCast {
    TGAssertNoThrow(GSAssertCast(TGLogging_Assert, self));
    TGAssertNoThrow(GSAssertCast(SenTestCase, self));
    TGAssertNoThrow(GSAssertCast(NSObject, self));
    
    TGAssertDebugThrows(GSAssertCast(NSString, self));
    TGAssertDebugThrows(GSAssertCast(NSNumber, self));

    TGLogging_Assert *me;
    TGAssertNoThrow(me = GSAssertCast(TGLogging_Assert, self));
    TGAssertDebugThrows(GSAssertCast(NSDictionary, me));

    NSDictionary *dict;
    TGAssertDebugThrows(dict = GSAssertCast(NSDictionary, @[]));
}

@end
