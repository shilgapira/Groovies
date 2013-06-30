//
// GSGlobals+Device.m
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

#import "GSGlobals+Device.h"
#import "GSMacros+Language.h"


#pragma mark - Device

BOOL GSDeviceIsSimulator(void) {
	static NSString *simulatorModel = @"Simulator";
    return [UIDevice.currentDevice.model hasSuffix:simulatorModel];
}

BOOL GSDeviceIsPhone(void) {
    return UIDevice.currentDevice.userInterfaceIdiom == UIUserInterfaceIdiomPhone;
}

BOOL GSDeviceIsPad(void) {
    return UIDevice.currentDevice.userInterfaceIdiom == UIUserInterfaceIdiomPad;
}

float GSSystemVersion(void) {
    return [UIDevice.currentDevice.systemVersion floatValue];
}

BOOL GSSystemVersionIsAtLeast(float version) {
    return (GSSystemVersion() - version > -1.0e-6);
}


#pragma mark - Screen

BOOL GSScreenIsRetina(void) {
	return UIScreen.mainScreen.scale == 2.0f;
}

BOOL GSScreenIsWide(void) {
    return GSDeviceIsPhone() && (UIScreen.mainScreen.bounds.size.height == 568.0f);
}


__attribute__((overloadable)) CGRect GSScreenBounds(void) {
    UIInterfaceOrientation currentOrientation = UIApplication.sharedApplication.statusBarOrientation;
    return GSScreenBounds(currentOrientation);
}

__attribute__((overloadable)) CGRect GSScreenBounds(UIInterfaceOrientation orientation) {
	CGRect bounds = UIScreen.mainScreen.bounds;
    
	if (UIInterfaceOrientationIsLandscape(orientation)) {
        SWAP(bounds.size.width, bounds.size.height);
	}
    
	return bounds;
}
