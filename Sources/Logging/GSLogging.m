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
        
        [ttyLogger setForegroundColor:[UIColor colorWithRed:0.90f green:0.15f blue:0.10f alpha:1.0f] backgroundColor:nil forFlag:LOG_FLAG_ERROR];
        [ttyLogger setForegroundColor:[UIColor colorWithRed:0.70f green:0.30f blue:0.10f alpha:1.0f] backgroundColor:nil forFlag:LOG_FLAG_WARN];
        [ttyLogger setForegroundColor:[UIColor colorWithRed:0.00f green:0.00f blue:0.00f alpha:1.0f] backgroundColor:nil forFlag:LOG_FLAG_INFO];
        [ttyLogger setForegroundColor:[UIColor colorWithRed:0.20f green:0.40f blue:0.60f alpha:1.0f] backgroundColor:nil forFlag:LOG_FLAG_VERBOSE];
        [ttyLogger setForegroundColor:[UIColor colorWithRed:0.20f green:0.50f blue:0.30f alpha:1.0f] backgroundColor:nil forFlag:LOG_FLAG_DEBUG];
    }
    #endif

    [DDLog addLogger:ttyLogger];
}
