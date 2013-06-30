//
// GSAnalytics.m
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

#import "GSAnalytics.h"
#import "GSMacros+Language.h"
#import "GSGlobals+Objects.h"
#import "UIViewController+Analytics.h"


@interface UIViewController (Automatic)

- (void)GSAnalytics_viewDidAppear:(BOOL)animated;

@end


@interface GSAnalytics ()

@property (nonatomic,strong,readonly) NSMutableArray *providers;

@end


@implementation GSAnalytics

SINGLETON(sharedAnalytics);

+ (void)initialize {
    GSSwizzle(UIViewController.class, @selector(viewDidAppear:), @selector(GSAnalytics_viewDidAppear:));
}

- (id)init {
    if (self = [super init]) {
        _providers = [NSMutableArray new];
        
        [NSNotificationCenter.defaultCenter addObserver:self selector:@selector(applicationLifecycle:) name:UIApplicationDidEnterBackgroundNotification object:nil];
        [NSNotificationCenter.defaultCenter addObserver:self selector:@selector(applicationLifecycle:) name:UIApplicationWillTerminateNotification object:nil];
    }
    return self;
}

- (void)dealloc {
    [NSNotificationCenter.defaultCenter removeObserver:self name:UIApplicationDidEnterBackgroundNotification object:nil];
    [NSNotificationCenter.defaultCenter removeObserver:self name:UIApplicationWillTerminateNotification object:nil];
}

- (void)applicationLifecycle:(NSNotification *)notification {
    [self flush];
}

- (void)addProvider:(id<GSAnalyticsProvider>)provider {
    [self.providers addObject:provider];
}

- (void)removeProvider:(id<GSAnalyticsProvider>)provider {
    [self.providers removeObject:provider];
}

- (void)trackScreen:(NSString *)screen {
    for (id<GSAnalyticsProvider> provider in self.providers) {
        [provider trackScreen:screen];
    }
}

- (void)trackEvent:(NSString *)event label:(NSString *)label category:(NSString *)category {
    for (id<GSAnalyticsProvider> provider in self.providers) {
        [provider trackEvent:event label:label category:category];
    }
}

- (void)trackTiming:(NSString *)timing value:(NSTimeInterval)value category:(NSString *)category {
    for (id<GSAnalyticsProvider> provider in self.providers) {
        [provider trackTiming:timing value:value category:category];
    }
}

- (void)flush {
    for (id<GSAnalyticsProvider> provider in self.providers) {
        [provider flush];
    }
}

@end


@implementation UIViewController (Automatic)

- (void)GSAnalytics_viewDidAppear:(BOOL)animated {
    NSString *analyticsName = self.analyticsName;
    if (analyticsName) {
        [GSAnalytics.sharedAnalytics trackScreen:analyticsName];
    }
    
    [self GSAnalytics_viewDidAppear:animated];
}

@end
