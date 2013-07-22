//
// GSTheme.h
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
 * The @c GSTheme class enables apps to create themes that provide a central place
 * to encapsulate all styling logic. Styles are created by providing a block that
 * takes an object and performs actions on it, e.g., setting a view's background
 * color or a label's font.
 */
@interface GSTheme : NSObject

/**
 * The current theme used to style objects.
 * @return The current theme, or @c nil if none has been set.
 */
+ (instancetype)currentTheme;

/**
 * Sets the current theme used to style objects.
 * @param theme An instance of @c GSTheme or user defined subclass.
 */
+ (void)setCurrentTheme:(GSTheme *)theme;

/**
 * Adds a style to the theme.
 * @param style The style identifier, e.g., a boxed enum value.
 * @param block A block that performs styling actions on an object.
 */
- (void)addStyle:(id<NSCopying>)style block:(void(^)(id obj))block;

/**
 * Adds a style to the theme.
 * @param style The style identifier, e.g., a boxed enum value.
 * @param expectedClass The style will only be applied to instances of this class. Pass @c Nil to allow the style to be applied to any object.
 * @param block A block that performs styling actions on an object.
 */
- (void)addStyle:(id<NSCopying>)style forClass:(Class)expectedClass block:(void(^)(id obj))block;

/**
 * Applies a style to an object.
 * @param style The style identifier, e.g., a boxed enum value.
 * @param object The object to apply the style to.
 */
- (void)applyStyle:(id)style toObject:(id)object;

@end
