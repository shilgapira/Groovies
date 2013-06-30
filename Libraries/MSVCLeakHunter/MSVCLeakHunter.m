/*

 Copyright 2012 Javier Soto (javi@mindsnacks.com)

 Licensed under the Apache License, Version 2.0 (the "License");
 you may not use this file except in compliance with the License.
 You may obtain a copy of the License at

 http://www.apache.org/licenses/LICENSE-2.0

 Unless required by applicable law or agreed to in writing, software
 distributed under the License is distributed on an "AS IS" BASIS,
 WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 See the License for the specific language governing permissions and
 limitations under the License.
 */

#ifdef DEBUG

#import "MSVCLeakHunter.h"
#import "GSLogging+Base.h"
#include <objc/runtime.h>

#if MSVCLeakHunter_EnableUIViewControllerLog
    #define MSLOG_METHOD() GSLogD(@"")
#else
    #define MSLOG_METHOD()
#endif

@interface UIViewController (MSVCLeakHunter)

- (void)_msvcLeakHunter_viewDidAppear:(BOOL)animated;
- (void)_msvcLeakHunter_viewDidDisappear:(BOOL)animated;
- (void)_msvcLeakHunter_dealloc;

@end

@implementation MSVCLeakHunter

/**
 * @discussion just an instance of the class to schedule the calls to `viewControllerLeakedWithReference:`
 */
+ (MSVCLeakHunter *)sharedInstance
{
    static MSVCLeakHunter *sharedInstance = nil;

    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
    });

    return sharedInstance;
}

- (void)handleViewControllerReferenceObject:(id)referenceObject
{
    if ([referenceObject isKindOfClass:NSString.class]) {
        GSLogW(@"Possible leak of view controller: %@", referenceObject);
    } else {
        UIViewController *(^block)(void) = referenceObject;
        UIViewController *vc = block();
        if (vc && !vc.parentViewController && !vc.presentingViewController && (vc != UIApplication.sharedApplication.keyWindow.rootViewController)) {
            GSLogW(@"Possible leak of view controller: %@", vc);
        }
    }
}

+ (void)install
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [self swizzleUIViewControllerSelector:@selector(viewDidAppear:)
                                 withSelector:@selector(_msvcLeakHunter_viewDidAppear:)];

        [self swizzleUIViewControllerSelector:@selector(viewDidDisappear:)
                                 withSelector:@selector(_msvcLeakHunter_viewDidDisappear:)];

        [self swizzleUIViewControllerSelector:NSSelectorFromString(@"dealloc")
                                 withSelector:@selector(_msvcLeakHunter_dealloc)];
    });

}

#pragma mark - Swizzling

+ (void)swizzleUIViewControllerSelector:(SEL)originalSelector
                           withSelector:(SEL)newSelector
{
    Class class = [UIViewController class];

    Method originalMethod = class_getInstanceMethod(class, originalSelector);
    Method newMethod = class_getInstanceMethod(class, newSelector);

    method_exchangeImplementations(originalMethod, newMethod);
}

@end

@implementation UIViewController (MSVCLeakHunter)

/**
 * @return an object that identifies the controller. This is used to be pased to `MSVCLeakHunter` without retaining the controller.
 */
- (id)referenceObject
{
    if ([self respondsToSelector:@selector(presentingViewController)]) {
        __weak UIViewController *ref = self;

        UIViewController *(^block)(void) = ^UIViewController *{
            UIViewController *vc = ref;
            if (vc) {
                return vc;
            }
            return nil;
        };
        
        return [block copy];
    } else {
        return [NSString stringWithFormat:@"<%@: %p>", NSStringFromClass([self class]), self];
    }
}

#pragma mark - Alternative method implementations

- (void)_msvcLeakHunter_viewDidAppear:(BOOL)animated
{
    MSLOG_METHOD();

    [self cancelLeakCheck];

    // Call original implementation
    [self _msvcLeakHunter_viewDidAppear:animated];
}

- (void)_msvcLeakHunter_viewDidDisappear:(BOOL)animated
{
    MSLOG_METHOD();

    // Call original implementation
    [self _msvcLeakHunter_viewDidDisappear:animated];

    [self scheduleLeakCheck];
}

- (void)_msvcLeakHunter_dealloc
{
    MSLOG_METHOD();

    [self cancelLeakCheck];

    // Call original implementation
    [self _msvcLeakHunter_dealloc];
}

static char GSLeakHunterKey;

- (void)cancelLeakCheck
{
    id referenceObject = objc_getAssociatedObject(self, &GSLeakHunterKey);

    if (referenceObject) {
        [NSObject cancelPreviousPerformRequestsWithTarget:[MSVCLeakHunter sharedInstance]
                                                 selector:@selector(handleViewControllerReferenceObject:)
                                                   object:referenceObject];

        objc_setAssociatedObject(self, &GSLeakHunterKey, nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
}

- (void)scheduleLeakCheck
{
    // Cancel previous ones just in case to avoid multiple calls.
    [self cancelLeakCheck];

    id referenceObject = [self referenceObject];

    objc_setAssociatedObject(self, &GSLeakHunterKey, referenceObject, OBJC_ASSOCIATION_RETAIN_NONATOMIC);

    [[MSVCLeakHunter sharedInstance] performSelector:@selector(handleViewControllerReferenceObject:)
                                          withObject:referenceObject
                                          afterDelay:kMSVCLeakHunterDisappearAndDeallocateMaxInterval];
}

@end

#endif
