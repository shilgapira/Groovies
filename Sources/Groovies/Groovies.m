//
// Groovies.m
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

#import "Groovies.h"
#import "GSLogging+Internal.h"
#import "DCIntrospect.h"
#import "MSVCLeakHunter.h"


NSString * const GSGrooveOptionLoggingColorsEnabled = @"LoggingColorsEnabled";
NSString * const GSGrooveOptionDCIntrospectEnabled = @"DCIntrospectEnabled";
NSString * const GSGrooveOptionLeakHunterEnabled = @"LeakHunterEnabled";


static const NSTimeInterval kDCIntrospectDelay = 0.5;


@implementation Groovies

static BOOL initialized = NO;

+ (void)groove {
    [self groove:nil];
}

+ (void)groove:(NSDictionary *)options {
    if (initialized) {
        return;
    }
    initialized = YES;

    if (!options) {
        options = [NSDictionary dictionary];
    }
    
    BOOL colors = [options boolForKey:GSGrooveOptionLoggingColorsEnabled withDefault:YES];
    GSLoggingSetup(colors);
    GSLogI(@"Initialized logging");
    
    #if defined(DEBUG)
    GSLogW(@"*************************");
    GSLogW(@"Binary compiled for DEBUG");
    GSLogW(@"*************************");
    #endif

    #if TARGET_IPHONE_SIMULATOR
    GSLogV(@"Simulator Path: %@", [GSDocumentsPath() stringByDeletingLastPathComponent]);
    #endif
    
    #if defined(DEBUG) && TARGET_IPHONE_SIMULATOR
    if ([options boolForKey:GSGrooveOptionDCIntrospectEnabled withDefault:YES]) {
        GSLogV(@"Starting DCIntrospect in %dms", (int) (kDCIntrospectDelay * 1000));
        DCLogger = ^(NSString *msg) {
            GSLogV(@"%@", msg);
        };
        GSExecuteDelayed(kDCIntrospectDelay, ^{
            [DCIntrospect.sharedIntrospector start];
        });
    }
    #endif

    #if defined(DEBUG)
    if ([options boolForKey:GSGrooveOptionLeakHunterEnabled withDefault:NO]) {
        GSLogV(@"Starting leak hunter");
        [MSVCLeakHunter install];
    }
    #endif
}

@end
