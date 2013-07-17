//
// GSGlobals+Blocks.m
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

#import "GSGlobals+Blocks.h"


void GSExecuteMain(void(^block)(void)) {
    if (block) {
        dispatch_async(dispatch_get_main_queue(), block);
    }
}

__attribute__((overloadable)) void GSExecuteDelayed(NSTimeInterval delay, void(^block)(void)) {
    if (block) {
        dispatch_time_t when = dispatch_time(DISPATCH_TIME_NOW, (int64_t) (delay * NSEC_PER_SEC));
        dispatch_after(when, dispatch_get_main_queue(), block);
    }
}

__attribute__((overloadable)) void GSExecuteDelayed(NSTimeInterval delay, id context, void(^block)(id context)) {
    __weak id contextWeak = context;
    dispatch_time_t when = dispatch_time(DISPATCH_TIME_NOW, (int64_t) (delay * NSEC_PER_SEC));
    dispatch_after(when, dispatch_get_main_queue(), ^{
        __strong id contextStrong = contextWeak;
        if (block) {
            block(contextStrong);
        }
    });
}

__attribute__((overloadable)) void GSExecuteBackground(void(^block)(void)) {
    GSExecuteBackground(block, nil);
}

__attribute__((overloadable)) void GSExecuteBackground(void(^block)(void), void(^completed)(void)) {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        if (block) {
            block();
        }
        if (completed) {
            dispatch_async(dispatch_get_main_queue(), completed);
        }
    });
}

__attribute__((overloadable)) void GSExecuteBackground(id context, void(^block)(id context), void(^completed)(id context)) {
    __weak id contextWeak = context;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        __strong id contextStrongBg = contextWeak;
        if (block) {
            block(contextStrongBg);
        }
        if (completed) {
            dispatch_async(dispatch_get_main_queue(), ^{
                __strong id contextStrongMain = contextWeak;
                completed(contextStrongMain);
            });
        }
    });
}

NSTimeInterval GSExecuteTimed(void(^block)(void)) {
    NSTimeInterval start = CACurrentMediaTime();
    if (block) block();
    NSTimeInterval elapsed = CACurrentMediaTime() - start;
    return elapsed;
}
