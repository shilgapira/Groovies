//
// GSGlobals+Device.h
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

#import <UIKit/UIKit.h>
#import "GSMacros+Defines.h"


/**
 * Returns true if running on an iPhone or iPod (device or simulator).
 */
GS_EXTERN BOOL GSDeviceIsPhone(void);

/**
 * Returns true if running on an iPad (device or simulator).
 */
GS_EXTERN BOOL GSDeviceIsTablet(void);

/**
 * Returns true if running on a simulator.
 */
GS_EXTERN BOOL GSDeviceIsSimulator(void);


/**
 * Returns the device's iOS version.
 */
GS_EXTERN float GSSystemVersion(void);

/**
 * Returns true if the device's iOS is at least the specfied version.
 */
GS_EXTERN BOOL GSSystemVersionAtLeast(float version);


/**
 * Returns true if the device has a retina screen.
 */
GS_EXTERN BOOL GSScreenIsRetina(void);

/**
 * Returns true if the device has a 16:9 retina screen.
 */
GS_EXTERN BOOL GSScreenIsWide(void);
