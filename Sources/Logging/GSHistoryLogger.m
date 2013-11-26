//
// GSHistoryLogger.m
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

#import "GSHistoryLogger.h"
#import "GSMacros+Language.h"
#import "GSLogging+Base.h"
#import "GSLogFormatter.h"


static const NSUInteger kDefaultCapacity = 250;
static const NSUInteger kPruneFrequency = 50;


@interface GSHistoryLogger ()

@property (nonatomic,strong,readonly) NSMutableArray *messages;

@end


@implementation GSHistoryLogger

SINGLETON(sharedLogger);

- (id)init {
    if (self = [super init]) {
        _capacity = kDefaultCapacity;
        _messages = [NSMutableArray new];
    }
    return self;
}

#pragma mark Logging

- (void)setEnabled:(BOOL)enabled {
    if (_enabled != enabled) {
        _enabled = enabled;
        if (_enabled) {
            self.logFormatter = GSLogFormatter.sharedFormatter;
            [DDLog addLogger:self];
        } else {
            [DDLog removeLogger:self];
            self.logFormatter = nil;
            
            dispatch_async(self.loggerQueue, ^{
                [self.messages removeAllObjects];
            });
        }
    }
}

- (void)setCapacity:(NSUInteger)capacity {
    if (_capacity != capacity) {
        _capacity = capacity;
        
        dispatch_async(self.loggerQueue, ^{
            [self prune];
        });
    }
}

- (void)prune {
    if (_messages.count > _capacity) {
        [_messages removeObjectsInRange:NSMakeRange(0, _messages.count - _capacity)];
    }
}

- (void)logMessage:(DDLogMessage *)message {
    [_messages addObject:message];
    
    if (_messages.count % kPruneFrequency == 0) {
        [self prune];
    }
}

#pragma mark Export

- (NSArray *)messageObjects {
    __block NSArray *objects = nil;
    
    dispatch_sync(self.loggerQueue, ^{
        objects = [self.messages copy];
    });
    
    return objects;
}

- (NSString *)messagesAsDocumentWithFormat:(GSHistoryMessageFormat)format {
    NSMutableString *document = [NSMutableString new];
    
    NSString *eol = @"\n";
    if (format == GSHistoryMessageFormatHTML) {
        eol = @"<br/>";
        [document appendString:@"<font face=\"courier new\" size=\"2\">"];
    }
    
    NSArray *strings = [self messagesAsStringsWithFormat:format];
    for (NSString *string in strings) {
        [document appendString:string];
        [document appendString:eol];
    }

    if (format == GSHistoryMessageFormatHTML) {
        [document appendString:@"</font>"];
    }
    
    return document;
}

- (NSArray *)messagesAsStringsWithFormat:(GSHistoryMessageFormat)format {
    NSMutableArray *result = [NSMutableArray new];
    
    NSArray *messages = [self messageObjects];
    for (DDLogMessage *message in messages) {
        NSString *string;
        if (format == GSHistoryMessageFormatHTML) {
            string = [self HTMLForMessage:message];
        } else {
            string = [self textForMessage:message];
        }
        [result addObject:string];
    }
    
    return result;
}

- (NSString *)textForMessage:(DDLogMessage *)message {
    return [formatter formatLogMessage:message] ?: message->logMsg;
}

- (NSString *)HTMLForMessage:(DDLogMessage *)message {
    NSString *text = [self textForMessage:message];
    
    // we replace some common characters with their HTML entities to prevent
    // the HTML from breaking
    text = [[[[[[text stringByReplacingOccurrencesOfString:@"&" withString:@"&amp;"]
        stringByReplacingOccurrencesOfString:@"<" withString:@"&lt;"]
        stringByReplacingOccurrencesOfString:@">" withString:@"&gt;"]
        stringByReplacingOccurrencesOfString:@"\"" withString:@"&quot;"]
        stringByReplacingOccurrencesOfString:@"'" withString:@"&apos;"]
        stringByReplacingOccurrencesOfString:@"\n" withString:@"<br>"];

    // for logs formatted by GSLogFormatter we make the important parts bold
    NSUInteger bracketIndex = [text rangeOfString:@"["].location;
    if (bracketIndex != NSNotFound) {
        NSString *head = [text substringToIndex:bracketIndex];
        NSString *tail = [text substringFromIndex:bracketIndex];
        text = [NSString stringWithFormat:@"%@<b>%@</b>", head, tail];
    }

    // every message is colored by its level
    NSString *color = [self colorForMessage:message];
    NSString *HTML = [NSString stringWithFormat:@"<font color=\"%@\">%@</font>", color, text];
    
    return HTML;
}

- (NSString *)colorForMessage:(DDLogMessage *)message {
    switch (message->logFlag) {
        case LOG_FLAG_ERROR: return @"red";
        case LOG_FLAG_WARN: return @"olive";
        case LOG_FLAG_INFO: return @"black";
        case LOG_FLAG_VERBOSE: return @"blue";
        default: return @"green";
    }
}

@end
