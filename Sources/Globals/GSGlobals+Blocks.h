//
// GSGlobals+Blocks.h
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

#import <Foundation/Foundation.h>


/**
 * Executes a block on the main queue.
 * @param block The block to execute. This parameter may be @c nil.
 */
extern void GSExecuteMain(void(^block)(void));


/**
 * Executes a block on the main queue after a delay. The block is scheduled for
 * execution and the function always returns immediately, even if the delay is 0.
 * @param delay The delay before the block is executed.
 * @param block The block to execute. This parameter may be @c nil.
 */
extern __attribute__((overloadable)) void GSExecuteDelayed(NSTimeInterval delay, void(^block)(void));

/**
 * Executes a block on the main queue after a delay. The block is scheduled for
 * execution and the function always returns immediately, even if the delay is 0.
 * If context is not nil the function keeps a weak reference to it until the block
 * is executed, at which point it passes it (or @c nil if it's been dealloced) to
 * the block.
 * @param delay The delay before the block is executed.
 * @param context A context object to pass to the block.
 * @param block The block to execute. This parameter may be @c nil.
 */
extern __attribute__((overloadable)) void GSExecuteDelayed(NSTimeInterval delay, id context, void(^block)(id context));


/**
 * Executes a block on a background queue.
 * @param block The block to execute. This parameter may be @c nil.
 */
extern __attribute__((overloadable)) void GSExecuteBackground(void(^block)(void));

/**
 * Executes a block on a background queue followed by a completion block on the
 * main queue.
 * @param block The block to execute. This parameter may be @c nil.
 * @param completed The completion block. This parameter may be @c nil.
 */
extern __attribute__((overloadable)) void GSExecuteBackground(void(^block)(void), void(^completed)(void));

/**
 * Executes a block on a background queue followed by a completion block on the
 * main queue. The function keeps a weak reference to the context object and
 * passes it (or @c nil if it's been dealloced) to both blocks.
 * @param context A context object to pass to both blocks.
 * @param block The block to execute. This parameter may be @c nil.
 * @param completed The completion block. This parameter may be @c nil.
 */
extern __attribute__((overloadable)) void GSExecuteBackground(id context, void(^block)(id context), void(^completed)(id context));
