//
// GSGlobals+Timing.m
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

#import "GSGlobals+Timing.h"
#import <mach/mach_time.h>


/** Timebase info used to convert between mach absolute times and real world time */
static mach_timebase_info_data_t __timebaseInfo;


/**
 * Retrieves timebase info values on application launch
 */
static __attribute__((constructor)) void GSTimebaseSetup(void) {
    kern_return_t result = mach_timebase_info(&__timebaseInfo);
    if (result != KERN_SUCCESS) {
        __timebaseInfo = (mach_timebase_info_data_t) { 0, 0 };
    }
}

/**
 * Converts a mach absolute time measurement to an NSTimeInterval
 */
static NSTimeInterval GSConvertElapsedTime(uint64_t time) {
    uint64_t nanos = time * __timebaseInfo.numer / __timebaseInfo.denom;
    return (double) nanos / NSEC_PER_SEC;
}


NSTimeInterval GSExecuteTimed(void(^block)(void)) {
    if (!__timebaseInfo.denom) {
        block();
        return -1.0;
    }
    
    uint64_t start = mach_absolute_time();
    block();
    uint64_t elapsed = mach_absolute_time() - start;
    
    return GSConvertElapsedTime(elapsed);
}

uint64_t GSTimingNow(void) {
    return mach_absolute_time();
}

__attribute__((overloadable)) NSTimeInterval GSTimingElapsed(uint64_t start) {
    return GSTimingElapsed(start, GSTimingNow());
}

__attribute__((overloadable)) NSTimeInterval GSTimingElapsed(uint64_t start, uint64_t end) {
    if (end >= start) {
        return GSConvertElapsedTime(end - start);
    } else {
        return -1 * GSConvertElapsedTime(start - end);
    }
}
