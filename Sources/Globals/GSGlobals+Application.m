//
// GSGlobals+Application.m
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

#import "GSGlobals+Application.h"


#pragma mark - Version

static NSString *GSInfoDictionaryString(NSString *key) {
    id obj = [NSBundle.mainBundle objectForInfoDictionaryKey:key];
    if ([obj isKindOfClass:NSString.class]) {
        return obj;
    }
    return nil;
}

NSString *GSAppVersion(void) {
    return GSInfoDictionaryString((NSString *)kCFBundleVersionKey);
}

NSString *GSAppBuild(void) {
    return GSInfoDictionaryString(@"CFBundleShortVersionString");
}


#pragma mark - Directories

NSString *GSDocumentsPath(void) {
    NSURL *url = [[NSFileManager.defaultManager URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
	return [url path];
}

NSString *GSCachesPath(void) {
	NSURL *url = [[NSFileManager.defaultManager URLsForDirectory:NSCachesDirectory inDomains:NSUserDomainMask] lastObject];
    return [url path];
}


#pragma mark - Keyboard

void GSPreloadKeyboard(BOOL delayed) {
    void(^preloadBlock)(void) = ^{
        UITextField *field = [UITextField new];
        [UIApplication.sharedApplication.windows.lastObject addSubview:field];
        [field becomeFirstResponder];
        [field resignFirstResponder];
        [field removeFromSuperview];
    };
    
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        if (delayed) {
            dispatch_time_t when = dispatch_time(DISPATCH_TIME_NOW, NSEC_PER_MSEC * 50);
            dispatch_after(when, dispatch_get_main_queue(), preloadBlock);
        } else {
            preloadBlock();
        }
    });
}
