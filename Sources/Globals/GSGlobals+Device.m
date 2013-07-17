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


static NSString * const kSimulatorSuffix = @"Simulator";


BOOL GSDeviceIsPhone(void) {
    return UIDevice.currentDevice.userInterfaceIdiom == UIUserInterfaceIdiomPhone;
}

BOOL GSDeviceIsTablet(void) {
    return UIDevice.currentDevice.userInterfaceIdiom == UIUserInterfaceIdiomPad;
}

BOOL GSDeviceIsSimulator(void) {
    return [UIDevice.currentDevice.model hasSuffix:kSimulatorSuffix];
}

float GSSystemVersion(void) {
    return [UIDevice.currentDevice.systemVersion floatValue];
}

BOOL GSSystemVersionAtLeast(float version) {
    return (GSSystemVersion() - version > -1.0e-6);
}

BOOL GSScreenIsRetina(void) {
	return UIScreen.mainScreen.scale == 2.0f;
}

BOOL GSScreenIsWide(void) {
    return GSDeviceIsPhone() && (UIScreen.mainScreen.bounds.size.height == 568.0f);
}
