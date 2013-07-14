//
// TGLogging+Base.m
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

#import "TGLogging+Base.h"
#import "GSLogging+Base.h"


@implementation TGLogging_Base

- (void)testLog {
    GSLogD();
    GSLogV(@"Foo");
    GSLogI(@"Foo: %@", self);
    GSLogW(@"Foo: %@, Bar: %d", self.class, self.description.length);
    GSLogE(@"Foo: %s", sel_getName(@selector(description)));
}

- (void)testLevels {
    BOOL logged;
    
    GSLogLevel = LOG_LEVEL_OFF;
    
    logged = NO;
    GSLogE(@"Bar: %d", (logged = YES));
    TGAssertNot(logged);
    
    GSLogLevel = LOG_LEVEL_ERROR;
    
    logged = NO;
    GSLogE(@"Bar: %d", (logged = YES));
    TGAssert(logged);
    
    logged = NO;
    GSLogW(@"Bar: %d", (logged = YES));
    TGAssertNot(logged);
    
    GSLogLevel = LOG_LEVEL_WARN;
    
    logged = NO;
    GSLogW(@"Bar: %d", (logged = YES));
    TGAssert(logged);
    
    logged = NO;
    GSLogI(@"Bar: %d", (logged = YES));
    TGAssertNot(logged);
    
    GSLogLevel = LOG_LEVEL_INFO;
    
    logged = NO;
    GSLogI(@"Bar: %d", (logged = YES));
    TGAssert(logged);
    
    logged = NO;
    GSLogV(@"Bar: %d", (logged = YES));
    TGAssertNot(logged);
    
    GSLogLevel = LOG_LEVEL_VERBOSE;
    
    logged = NO;
    GSLogV(@"Bar: %d", (logged = YES));
    TGAssert(logged);
    
    logged = NO;
    GSLogD(@"Bar: %d", (logged = YES));
    TGAssertNot(logged);
    
    GSLogLevel = LOG_LEVEL_DEBUG;
    
    logged = NO;
    GSLogD(@"Bar: %d", (logged = YES));
    TGAssert(logged);
}

@end
