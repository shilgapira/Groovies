//
// GSGlobals+Timing.h
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


/**
 * Executes a block and measures how much time the execution took. This function
 * uses mach absolute times for maximum precision.
 * @return The execution duration.
 */
extern NSTimeInterval GSExecuteTimed(void(^block)(void));


/**
 * Returns a timing value for the current time.
 * @return A mach absolute time value.
 */
extern uint64_t GSTimingNow(void);

/**
 * Calculates the elapsed time since the specified timing value.
 * @param start The timing value as returned by @c GSTimingNow.
 * @return The number of seconds since the start timing value was taken.
 */
extern __attribute__((overloadable)) NSTimeInterval GSTimingElapsed(uint64_t start);

/**
 * Calculates the elapsed time between two mach absolute times.
 * @param start The start timing value as returned by @c GSTimingNow.
 * @param end The end timing value as returned by @c GSTimingNow.
 * @return The number of seconds between the two timing values.
 */
extern __attribute__((overloadable)) NSTimeInterval GSTimingElapsed(uint64_t start, uint64_t end);
