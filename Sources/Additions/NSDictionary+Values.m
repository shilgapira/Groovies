//
// NSDictionary+Values.m
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

#import "NSDictionary+Values.h"


@implementation NSDictionary (Values)

- (NSDictionary *)dictionaryForKey:(id)key {
    id obj = [self objectForKey:key];
    if ([obj isKindOfClass:NSDictionary.class]) {
        return obj;
    }
    return nil;
}

- (NSArray *)arrayForKey:(id)key {
    id obj = [self objectForKey:key];
    if ([obj isKindOfClass:NSArray.class]) {
        return obj;
    }
    return nil;
}

- (NSString *)stringForKey:(id)key {
    id obj = [self objectForKey:key];
    if ([obj isKindOfClass:NSString.class]) {
        return obj;
    }
    if ([obj isKindOfClass:NSNumber.class]) {
        return [obj stringValue];
    }
    return nil;
}

- (NSString *)stringForKey:(id)key withDefault:(NSString *)def {
    return [self stringForKey:key] ?: def;
}

- (NSNumber *)numberForKey:(id)key {
    id obj = [self objectForKey:key];
    if ([obj isKindOfClass:NSNumber.class]) {
        return obj;
    }
    return nil;
}

- (NSNumber *)numberForKey:(id)key withDefault:(NSNumber *)def {
    return [self numberForKey:key] ?: def;
}

- (BOOL)boolForKey:(id)key withDefault:(BOOL)def {
    id obj = [self objectForKey:key];
    if ([obj isKindOfClass:NSNumber.class] || [obj isKindOfClass:NSString.class]) {
        return [obj boolValue];
    }
    return def;
}

- (NSInteger)integerForKey:(id)key withDefault:(NSInteger)def {
    id obj = [self objectForKey:key];
    if ([obj isKindOfClass:NSNumber.class] || [obj isKindOfClass:NSString.class]) {
        return [obj integerValue];
    }
    return def;
}

- (NSUInteger)unsignedForKey:(id)key withDefault:(NSUInteger)def {
    id obj = [self objectForKey:key];
    // we can't use the same selector for both object types, since NSString doesn't
    // declare an unsignedIntegerValue method
    if ([obj isKindOfClass:NSNumber.class]) {
        return [obj unsignedIntegerValue];
    }
    if ([obj isKindOfClass:NSString.class]) {
        return (NSUInteger) [obj longLongValue];
    }
    return def;
}

- (float)floatForKey:(id)key withDefault:(float)def {
    id obj = [self objectForKey:key];
    if ([obj isKindOfClass:NSNumber.class] || [obj isKindOfClass:NSString.class]) {
        return [obj floatValue];
    }
    return def;
}

- (double)doubleForKey:(id)key withDefault:(double)def {
    id obj = [self objectForKey:key];
    if ([obj isKindOfClass:NSNumber.class] || [obj isKindOfClass:NSString.class]) {
        return [obj doubleValue];
    }
    return def;
}

@end
