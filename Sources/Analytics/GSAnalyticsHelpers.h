//
// GSAnalyticsHelpers.h
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

#import <Foundation/Foundation.h>
#import "GSMacros+Defines.h"


/** The default category for events and timings, initially set to "Misc" */
extern NSString *GSAnalyticsDefaultCategory;


/**
 * Tracks a screen that the user viewed. With @c UIViewController screens you
 * can use automatic tracking by setting the @c analyticsName property.
 * @param screen The name of the screen.
 */
GS_EXTERN void GSTrackScreen(NSString *screen);


/**
 * Tracks an event with the default category.
 * @param event The name of the event.
 */
GS_EXTERN_OVERLOAD void GSTrackEvent(NSString *event);

/**
 * Tracks an event.
 * @param category The event category.
 * @param event The name of the event.
 */
GS_EXTERN_OVERLOAD void GSTrackEvent(NSString *category, NSString *event);

/**
 * Tracks an event.
 * @param category The event category.
 * @param event The name of the event.
 * @param label The event label.
 */
GS_EXTERN_OVERLOAD void GSTrackEvent(NSString *category, NSString *event, NSString *label);


/**
 * Tracks a timing with the default category.
 * @param timing The name of the timing.
 * @param value The timing value.
 */
GS_EXTERN_OVERLOAD void GSTrackTiming(NSString *timing, NSTimeInterval value);

/**
 * Tracks a timing.
 * @param category The timing category.
 * @param timing The name of the timing.
 * @param value The timing value.
 */
GS_EXTERN_OVERLOAD void GSTrackTiming(NSString *category, NSString *timing, NSTimeInterval value);
