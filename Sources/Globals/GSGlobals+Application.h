//
// GSGlobals+Application.h
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


/**
 * The application version from the main bundle's Info dictionary.
 */
extern NSString *GSAppVersion(void);

/** 
 * The application build (i.e., short version) from the main bundle's Info dictionary.
 */
extern NSString *GSAppBuild(void);


/**
 * A directory for persistent files that are backed up to iCloud/iTunes by default.
 */
extern NSString *GSDocumentsPath(void);

/**
 * A directory for files that are not backed up and may be removed by the system.
 */
extern NSString *GSCachesPath(void);


/**
 * Preloads the keyboard to prevent jankiness when the keyboard appears for the first time.
 */
extern void GSPreloadKeyboard(BOOL delayed);
