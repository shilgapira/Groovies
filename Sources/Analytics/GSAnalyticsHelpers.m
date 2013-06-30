//
// GSAnalyticsHelpers.m
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

#import "GSAnalyticsHelpers.h"
#import "GSAnalytics.h"


NSString *GSAnalyticsDefaultCategory = @"Misc";


void GSTrackScreen(NSString *screen) {
    [GSAnalytics.sharedAnalytics trackScreen:screen];
}


__attribute__((overloadable)) void GSTrackEvent(NSString *event) {
    [GSAnalytics.sharedAnalytics trackEvent:event label:nil category:GSAnalyticsDefaultCategory];
}

__attribute__((overloadable)) void GSTrackEvent(NSString *category, NSString *event) {
    [GSAnalytics.sharedAnalytics trackEvent:event label:nil category:category];
}

__attribute__((overloadable)) void GSTrackEvent(NSString *category, NSString *event, NSString *label) {
    [GSAnalytics.sharedAnalytics trackEvent:event label:label category:category];
}


__attribute__((overloadable)) void GSTrackTiming(NSString *timing, NSTimeInterval value) {
    [GSAnalytics.sharedAnalytics trackTiming:timing value:value category:GSAnalyticsDefaultCategory];
}

__attribute__((overloadable)) void GSTrackTiming(NSString *category, NSString *timing, NSTimeInterval value) {
    [GSAnalytics.sharedAnalytics trackTiming:timing value:value category:category];
}
