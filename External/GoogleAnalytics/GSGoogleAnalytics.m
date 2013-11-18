//
// GSGoogleAnalytics.m
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

#import "GSGoogleAnalytics.h"
#import "GAI.h"
#import "GAIFields.h"
#import "GAIDictionaryBuilder.h"


@interface GSGoogleAnalytics ()

@property (nonatomic,strong) id<GAITracker> tracker;

@end


@implementation GSGoogleAnalytics

SINGLETON(sharedAnalytics);

- (void)enableWithTrackingId:(NSString *)trackingId {
    [GSAnalytics.sharedAnalytics removeProvider:self];
    
    self.tracker = [GAI.sharedInstance trackerWithTrackingId:trackingId];
    
    [GSAnalytics.sharedAnalytics addProvider:self];
}

- (void)disable {
    [GSAnalytics.sharedAnalytics removeProvider:self];
    
    self.tracker = nil;
}

- (void)trackScreen:(NSString *)screen {
    [self.tracker set:kGAIScreenName value:screen];
    
    GAIDictionaryBuilder *builder = [GAIDictionaryBuilder createAppView];
    
    [self.tracker send:[builder build]];
}

- (void)trackEvent:(NSString *)event label:(NSString *)label category:(NSString *)category {
    GAIDictionaryBuilder *builder = [GAIDictionaryBuilder createEventWithCategory:category action:event label:label value:nil];
    
    [self.tracker send:[builder build]];
}

- (void)trackTiming:(NSString *)timing value:(NSTimeInterval)value category:(NSString *)category {
    NSNumber *intervalMillis = @(value * 1000);
    
    GAIDictionaryBuilder *builder = [GAIDictionaryBuilder createTimingWithCategory:category interval:intervalMillis name:timing label:nil];
    
    [self.tracker send:[builder build]];
}

- (void)flush {
    [GAI.sharedInstance dispatch];
}

@end
