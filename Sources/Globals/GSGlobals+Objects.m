//
// GSGlobals+Objects.m
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

#import "GSGlobals+Objects.h"
#import <objc/runtime.h>


// Based on: http://cocoadev.com/wiki/MethodSwizzling
void GSSwizzle(Class cls, SEL selector1, SEL selector2) {
    Method method1 = class_getInstanceMethod(cls, selector1);
    Method method2 = class_getInstanceMethod(cls, selector2);
    
    if (method1 && method2) {
        if (class_addMethod(cls, selector1, method_getImplementation(method2), method_getTypeEncoding(method2))) {
            class_replaceMethod(cls, selector2, method_getImplementation(method1), method_getTypeEncoding(method1));
        } else {
            method_exchangeImplementations(method1, method2);
        }
    }
}
