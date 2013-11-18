//
// GSLogging.m
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

#import "GSLogging+Internal.h"
#import "GSMacros+Colors.h"
#import "GSLogFormatter.h"
#import "DDTTYLogger.h"
#import "DDASLLogger.h"


int GSLogLevel = LOG_LEVEL_DEBUG;


void GSLoggingSetup(BOOL colors) {
    DDASLLogger *aslLogger = DDASLLogger.sharedInstance;
    aslLogger.logFormatter = GSLogFormatter.sharedFormatter;
    [DDLog addLogger:aslLogger];

    DDTTYLogger *ttyLogger = DDTTYLogger.sharedInstance;
    ttyLogger.logFormatter = GSLogFormatter.sharedFormatter;

    #ifdef DEBUG
    if (colors) {
        ttyLogger.colorsEnabled = YES;
        
        [ttyLogger setForegroundColor:GSColor(0.90f, 0.15f, 0.10f) backgroundColor:nil forFlag:LOG_FLAG_ERROR];
        [ttyLogger setForegroundColor:GSColor(0.70f, 0.30f, 0.10f) backgroundColor:nil forFlag:LOG_FLAG_WARN];
        [ttyLogger setForegroundColor:GSColor(0.00f, 0.00f, 0.00f) backgroundColor:nil forFlag:LOG_FLAG_INFO];
        [ttyLogger setForegroundColor:GSColor(0.20f, 0.40f, 0.60f) backgroundColor:nil forFlag:LOG_FLAG_VERBOSE];
        [ttyLogger setForegroundColor:GSColor(0.20f, 0.50f, 0.30f) backgroundColor:nil forFlag:LOG_FLAG_DEBUG];
    }
    #endif

    [DDLog addLogger:ttyLogger];
}
