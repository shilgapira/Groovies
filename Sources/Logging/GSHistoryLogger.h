//
// GSHistoryLogger.h
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

#import "DDLog.h"


typedef NS_ENUM(NSUInteger, GSHistoryMessageFormat) {
    
    /** Formatted messages in plain text */
    GSHistoryMessageFormatText,
    
    /** Formatted messages with HTML markup colored by level */
    GSHistoryMessageFormatHTML,
};


/**
 * A custom logger that aggregates messages for debugging on a device at
 * runtime or letting testers send bug reports.
 *
 * For example, the following code in a UIViewController subclass can be
 * used to email a bug report with the logging history:
 *
 * @code
 
- (void)presentBugReportComposer {
    if ([MFMailComposeViewController canSendMail]) {
        NSString *body = [GSHistoryLogger.sharedLogger messagesAsDocumentWithFormat:GSHistoryMessageFormatHTML];
        
        MFMailComposeViewController *composer = [MFMailComposeViewController new];
        composer.mailComposeDelegate = self;
        composer.subject = @"Bug Report";
        [composer setMessageBody:body isHTML:YES];
        
        [self presentViewController:composer animated:YES completion:nil];
    }
}

- (void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error {
    [self dismissViewControllerAnimated:YES completion:nil];
}
 
 * @endcode
 */
@interface GSHistoryLogger : DDAbstractLogger

/**
 * Whether the logger is enabled. Disabling the logger clears its history.
 */
@property (nonatomic,assign,getter=isEnabled) BOOL enabled;

/**
 * The number of messages to keep, after which the logger will periodically 
 * prune older ones. Defaults to 150.
 */
@property (nonatomic,assign) NSUInteger capacity;

/**
 * The singleton instance of this logger.
 */
+ (instancetype)sharedLogger;

/**
 * The messages as @c DDLogMessage objects, sorted from oldest to newest.
 */
- (NSArray *)messageObjects;

/**
 * Creates an @c NSString representation for each log message.
 * @param format The message format.
 * @return An array of messages, sorted from oldest to newest.
 */
- (NSArray *)messagesAsStringsWithFormat:(GSHistoryMessageFormat)format;

/**
 * Joins all log messages into a single human-readable document.
 * @param format The document and message format.
 * @return The formatted messages separated with new lines and/or markup.
 */
- (NSString *)messagesAsDocumentWithFormat:(GSHistoryMessageFormat)format;

@end
