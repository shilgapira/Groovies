//
// GSTheme.m
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

#import "GSTheme.h"
#import "GSLogging+Assert.h"


@interface GSTheme ()

@property (nonatomic,strong,readonly) NSMutableDictionary *entries;

@end


@interface GSThemeEntry : NSObject

@property (nonatomic,copy,readonly) id style;

@property (nonatomic,copy,readonly) void(^block)(id object);

@property (nonatomic,strong) Class expectedClass;

- (id)initWithStyle:(id)style block:(void(^)(id object))block;

- (void)applyToObject:(id)object;

@end


@implementation GSTheme

static GSTheme *__currentTheme;

+ (id)currentTheme {
    return __currentTheme;
}

+ (void)setCurrentTheme:(GSTheme *)theme {
    __currentTheme = theme;
}

- (id)init {
    if (self = [super init]) {
        _entries = [NSMutableDictionary new];
    }
    return self;
}

- (void)applyStyle:(id)style toObject:(id)object {
    GSThemeEntry *entry = self.entries[style];
    [entry applyToObject:object];
}

- (void)addStyle:(id<NSCopying>)style block:(void(^)(id object))block {
    [self addStyle:style forClass:Nil block:block];
}

- (void)addStyle:(id<NSCopying>)style forClass:(Class)expectedClass block:(void(^)(id object))block {
    GSThemeEntry *entry = [[GSThemeEntry alloc] initWithStyle:style block:block];
    entry.expectedClass = expectedClass;
    self.entries[style] = entry;
}

@end


@implementation GSThemeEntry

- (id)initWithStyle:(id)style block:(void(^)(id object))block {
    if (self = [super init]) {
        _style = [style copy];
        _block = [block copy];
    }
    return self;
}

- (void)applyToObject:(id)object {
    if (self.expectedClass && ![object isKindOfClass:self.expectedClass]) {
        GSAssertFailed(@"Unable to apply style %@ to object %@, expected class %@", self.style, object, NSStringFromClass(self.expectedClass));
        return;
    }
    
    if (self.block) self.block(object);
}

@end
