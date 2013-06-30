//
// GSLogFormatter.m
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

#import "GSLogFormatter.h"
#import "GSMacros+Language.h"
#import <pthread.h>
#import <libkern/OSAtomic.h>


#define kDateFormatString   @"yyyy-MM-dd HH:mm:ss:SSS"

#define kQueueMain          @"com.apple.main-thread"
#define kQueueHigh          @"com.apple.root.high-priority"
#define kQueueHighOc        @"com.apple.root.high-overcommit-priority"
#define kQueueDefault       @"com.apple.root.default-priority"
#define kQueueDefaultOc     @"com.apple.root.default-overcommit-priority"
#define kQueueLow           @"com.apple.root.low-priority"
#define kQueueLowOc         @"com.apple.root.low-overcommit-priority"
#define kQueueBackground    @"com.apple.root.background-priority"
#define kQueueBackgroundOc  @"com.apple.root.background-overcommit-priority"


@implementation GSLogFormatter 

SINGLETON(sharedFormatter);

- (NSString *)formatLogMessage:(DDLogMessage *)message {
    NSString *date = [self dateForMessage:message];
    
    NSString *level = [self levelForMessage:message];

    NSString *context = [self contextForMessage:message];
    
    NSString *file = DDExtractFileNameWithoutExtension(message->file, NO);

    return [NSString stringWithFormat:@"%@ %@ <%@> [%@:%d > %s]  %@", date, level, context, file, message->lineNumber, message->function, message->logMsg];
}

- (NSString *)levelForMessage:(DDLogMessage *)message {
    NSString *level = @"D";
    switch (message->logFlag) {
        case LOG_FLAG_ERROR   : level = @"E"; break;
        case LOG_FLAG_WARN    : level = @"W"; break;
        case LOG_FLAG_INFO    : level = @"I"; break;
        case LOG_FLAG_VERBOSE : level = @"V"; break;
    }
    return level;
}

- (NSString *)contextForMessage:(DDLogMessage *)message {
    NSMutableDictionary *threadDictionary = NSThread.currentThread.threadDictionary;
    
    static NSString *key = @"GSLogFormatter_contexts";
    NSMutableDictionary *contexts = threadDictionary[key];
    if (!contexts) {
        contexts = [NSMutableDictionary new];
        threadDictionary[key] = contexts;
    }

    NSNumber *threadId = @(message->machThreadID);
    NSString *context = contexts[threadId];
    if (!context) {
        context = [self threadLabelForMessage:message];
        contexts[threadId] = context;
    }

    return context;
}

- (NSString *)threadLabelForMessage:(DDLogMessage *)message {
    if (message->queueLabel == NULL) {
        return [NSString stringWithFormat:@"%u",message->machThreadID];
    }

    NSString *queue = @(message->queueLabel);
    if ([queue isEqualToString:kQueueMain]) {
        return @"M";
    }
    
    if ([queue isEqualToString:kQueueHigh]) {
        queue = @"H";
    } else if ([queue isEqualToString:kQueueHighOc]) {
        queue = @"H:OC";
    } else if ([queue isEqualToString:kQueueDefault]) {
        queue = @"D";
    } else if ([queue isEqualToString:kQueueDefaultOc]) {
        queue = @"D:OC";
    } else if ([queue isEqualToString:kQueueLow]) {
        queue = @"L";
    } else if ([queue isEqualToString:kQueueLowOc]) {
        queue = @"L:OC";
    } else if ([queue isEqualToString:kQueueBackground]) {
        queue = @"B";
    } else if ([queue isEqualToString:kQueueBackgroundOc]) {
        queue = @"B:OC";
    }

    return [NSString stringWithFormat:@"%@:%u",queue,message->machThreadID];
}

- (NSString *)dateForMessage:(DDLogMessage *)message {
    NSMutableDictionary *threadDictionary = NSThread.currentThread.threadDictionary;

    static NSString *key = @"GSLogFormatter_dateFormatter";
    NSDateFormatter *dateFormatter = threadDictionary[key];
    if (!dateFormatter) {
        dateFormatter = [NSDateFormatter new];
        dateFormatter.dateFormat = kDateFormatString;
        threadDictionary[key] = dateFormatter;
    }
    
    return [dateFormatter stringFromDate:message->timestamp];
}

@end
