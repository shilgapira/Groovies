//
// GSLogging+Expression.h
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

#import "GSLogging+Base.h"
#import "GSMacros+Varargs.h"
#import "GSMacros+Stringify.h"


//
// Logs the value of one or more expressions using GSStringify. For example,
//
//     GSXLog(self.hash);
//     GSXLog(self.presentingViewController, self.view.frame);
//
// logs the following messages:
//
//     self.hash = 2105490313
//     self.presentingViewController = <UIViewController: 0x7649e40>
//     self.view.frame = (0 20; 320 460)
//

#define GSXLog(expr, ...)       GS_VA_FOREACH(_GSXLog, expr, ##__VA_ARGS__)


//
// Implementation details, do not use directly
//

#define _GSXLog(expr)           GSLogV(@"%s = %@", #expr, GSStringify(expr))
