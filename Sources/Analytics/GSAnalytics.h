//
// GSAnalytics.h
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
#import "GSAnalyticsProvider.h"


/**
 * A utility class for working with analytics frameworks.
 */
@interface GSAnalytics : NSObject

/**
 * The shared @c GSAnalytics object.
 */
+ (instancetype)sharedAnalytics;

/**
 * Adds an analytics provider. All subsequent tracking calls will be forwarded to it.
 * @param provider An object implementing the @c GSAnalyticsProvider protocol.
 */
- (void)addProvider:(id<GSAnalyticsProvider>)provider;

/**
 * Removes an analytics provider.
 * @param provider An analytics provider that was previously added.
 */
- (void)removeProvider:(id<GSAnalyticsProvider>)provider;

/**
 * Tracks a screen that the user viewed.
 * @param screen The name of the screen.
 */
- (void)trackScreen:(NSString *)screen;

/**
 * Tracks an event.
 * @param event The name of the event.
 * @param label The event label.
 * @param category The event category.
 */
- (void)trackEvent:(NSString *)event label:(NSString *)label category:(NSString *)category;

/**
 * Tracks a timing.
 * @param timing The name of the timing.
 * @param value The timing value.
 * @param category The timing category.
 */
- (void)trackTiming:(NSString *)timing value:(NSTimeInterval)value category:(NSString *)category;

/**
 * Saves or sends all analytics data.
 */
- (void)flush;

@end
