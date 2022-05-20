//
//  FoundationExtension.m
//  Github
//
//  Created by Jentle-Zhi on 2020/3/20.
//  Copyright © 2020 Github. All rights reserved.
//

#import "JZFoundationExtension.h"
#import "NSObject+YYModel.h"
#import <objc/runtime.h>

#define _SuppressPerformSelectorLeakWarning(Stuff) \
    do { \
        _Pragma("clang diagnostic push") \
        _Pragma("clang diagnostic ignored \"-Warc-performSelector-leaks\"") \
        Stuff; \
        _Pragma("clang diagnostic pop") \
    } while (0)

@implementation NSObject (JZExtension)

/**
 字典数组转模型数组.
 @param json - 字典数组.
 @return 模型数组.
 */
+ (NSArray *)jz_modelArrayWithKeyValuesArray:(id _Nullable)json {
    return [NSArray yy_modelArrayWithClass:[self class] json:json];
}

/**
 字典转模型.
 @param json - 字典.
 @return 模型.
 */
+ (instancetype)jz_modelWithJSON:(id _Nullable)json {
    return [self yy_modelWithJSON:json];
}

/**
 模型转字典.
 @return 字典.
 */
- (NSDictionary *)jz_keyValues {
    return [self yy_modelToJSONObject];
}
/**
 模型赋值.
 @param data    - 数据.
 */
- (void)jz_setModelValueWithData:(id)data {
    NSDictionary  *d;
    if ([data isKindOfClass:[NSDictionary class]]) {
        d = data;
    }else{
        d = [data jz_keyValues];
    }
    if (d == nil || ![d isKindOfClass:[NSDictionary class]]) {
        return;
    }
    [d.allKeys enumerateObjectsUsingBlock:^(NSString *  _Nonnull key, NSUInteger idx, BOOL * _Nonnull stop) {
        NSString *selName = @"set".jz_append(key.jz_capitalizedFirstLatter).jz_append(@":");
        SEL setSel = NSSelectorFromString(selName);
        _SuppressPerformSelectorLeakWarning(
           if([self respondsToSelector:setSel]){
               id value = [d valueForKey:key];
               [self performSelector:setSel withObject:value];
           }
        );
    }];
}

@end

@implementation NSString (JZExtension)

/**
 拼接字符串.
 @param str - 新字符串.
 @return 拼接后的字符串.
 */
- (instancetype)_append:(NSString *)str {
    if (![str isKindOfClass:[NSString class]] || str.length == 0) {
        return self;
    }
    return [self stringByAppendingString:str];
}

- (NSString * _Nonnull (^)(NSString * _Nonnull))jz_append {
    return ^(NSString *content){
        return [self _append:content];
    };
}
/**
 首字母大写.
 @return 首字母大写的新字符串.
 */
- (instancetype)jz_capitalizedFirstLatter {
    NSString *firstLetter = [self substringToIndex:1].capitalizedString;
    return [self stringByReplacingCharactersInRange:NSMakeRange(0,1) withString:firstLetter];
}

/**
 判断字符串是否为空(nil/空字符串).
 @return 是否为空.
 */
+ (BOOL (^)(NSString * nullable))jz_isEmpty {
    return ^(NSString *str){
        return [self _isEmpty:str];
    };
}

/**
 判断字符串是否为非空.
 @return 是否为非空.
 */
+ (BOOL (^)(NSString * nullable))jz_isNotEmpty {
    return ^(NSString *str){
        BOOL ret = ![self _isEmpty:str];
        return ret;
    };
}

+ (BOOL)_isEmpty:(NSString *)str {
    if(str == nil) return YES;
    return str.length == 0;
}

/**
 判断字符串是否相等.
 @return 是否相等.
 */
- (BOOL (^)(NSString * _Nullable))jz_isEqual {
    return ^(NSString *str){
        if (NSString.jz_isEmpty(str)) {
            return NO;
        }
        return [self isEqualToString:str];
    };
}

/**
 守护字符串安全，非空.
 @return 返回非空字符串.
 */
+ (NSString * _Nonnull (^)(NSString * _Nullable))jz_guard {
    return ^(NSString *str){
        if (NSString.jz_isEmpty(str)) {
            return @"";
        }
        return str;
    };;
}

/**
 随机英文字符串.
 @return 返回非空字符串.
 */
+ (NSMutableString * _Nonnull (^)(int))jz_randomLetters {
    return ^(int length){
        return [self _randomLettersWithMin:length max:length];
    };
}

/**
 随机英文字符串.
 @return 返回非空字符串.
 */
+ (NSMutableString * _Nonnull (^)(int, int))jz_randomRangedLetters {
    return ^(int min,int max){
        return [self _randomLettersWithMin:min max:max];
    };
}

+ (NSMutableString *)_randomLettersWithMin:(int)min max:(int)max {
    NSMutableString *randomString = [NSMutableString string];
    if (min <= 0 || min > max) {
        return randomString;
    }
    NSString *letters = @"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";
    NSInteger length = arc4random()%(max-min+1) + min;
    for (NSInteger i = 0; i < length; i++) {
        uint32_t index = (uint32_t)[letters length];
        [randomString appendFormat: @"%C", [letters characterAtIndex: arc4random_uniform(index)]];
    }
    return randomString;
}

/**
 随机中文字符串.
 @return 返回非空字符串.
 */
+ (NSMutableString * _Nonnull (^)(int))jz_randomChineseLetters {
    return ^(int length){
        return [self _randomChineseLettersWithMin:length max:length];
    };
}

/**
 随机中文字符串.
 @return 返回非空字符串.
 */
+ (NSMutableString * _Nonnull (^)(int, int))jz_randomRangedChineseLetters {
    return ^(int min,int max){
        return [self _randomChineseLettersWithMin:min max:max];
    };
}


+ (NSMutableString *)_randomChineseLettersWithMin:(int)min max:(int)max {
    NSMutableString *randomChineseString = @"".mutableCopy;
    if (min <= 0 || min > max) {
        return randomChineseString;
    }
    NSUInteger count = arc4random()%(max-min+1) + min;
    for(NSInteger i =0; i < count; i++){
        
        NSStringEncoding gbkEncoding = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);
        NSInteger randomH = 0xA1 + arc4random()%(0xFE - 0xA1+1);
        NSInteger randomL =0xB0+arc4random()%(0xF7 - 0xB0+1);
        NSInteger number = (randomH<<8)+randomL;
        NSData*data = [NSData dataWithBytes:&number length:2];
        NSString*string = [[NSString alloc] initWithData:data encoding:gbkEncoding];
        [randomChineseString appendString:string];
    }
    return randomChineseString;
}

@end

@implementation NSArray (JZExtension)

//+ (void)initialize {
//
//    static dispatch_once_t onceToken;
//    dispatch_once(&onceToken, ^{
//        Method oldObjectAtIndex = class_getInstanceMethod(objc_getClass("__NSArrayI"), @selector(objectAtIndex:));
//            Method newObjectAtIndex = class_getInstanceMethod(objc_getClass("__NSArrayI"), @selector(newObjectAtIndex:));
//            method_exchangeImplementations(oldObjectAtIndex, newObjectAtIndex);
//
//            Method oldMutableObjectAtIndex = class_getInstanceMethod(objc_getClass("__NSArrayI"), @selector(objectAtIndexedSubscript:));
//            Method newMutableObjectAtIndex =  class_getInstanceMethod(objc_getClass("__NSArrayI"), @selector(newObjectAtIndexedSubscript:));
//            method_exchangeImplementations(oldMutableObjectAtIndex, newMutableObjectAtIndex);
//
//            Method oldMObjectAtIndex = class_getInstanceMethod(objc_getClass("__NSArrayM"), @selector(objectAtIndex:));
//            Method newMObjectAtIndex = class_getInstanceMethod(objc_getClass("__NSArrayM"), @selector(newMutableObjectAtIndex:));
//            method_exchangeImplementations(oldMObjectAtIndex, newMObjectAtIndex);
//
//            Method oldMMutableObjectAtIndex = class_getInstanceMethod(objc_getClass("__NSArrayM"), @selector(objectAtIndexedSubscript:));
//            Method newMMutableObjectAtIndex =  class_getInstanceMethod(objc_getClass("__NSArrayM"), @selector(newMutableObjectAtIndexedSubscript:));
//            method_exchangeImplementations(oldMMutableObjectAtIndex, newMMutableObjectAtIndex);
//    });
//}

- (id)newObjectAtIndex:(NSUInteger)index {
    @try {
        return [self newObjectAtIndex:index];
    } @catch (NSException * exception) {
        NSLog(@"Fatal: %@ %@", exception.name, exception.reason);
        return nil;
    }
}

- (id)newObjectAtIndexedSubscript:(NSUInteger)index {
    @try {
        return [self newObjectAtIndexedSubscript:index];
    } @catch (NSException *exception) {
        NSLog(@"!!!![exception]: %@ %@", exception.name, exception.reason);
        return nil;
    }
}

- (id)newMutableObjectAtIndex:(NSUInteger)index {
    @try {
        return [self newMutableObjectAtIndex:index];
    } @catch (NSException *exception) {
        NSLog(@"Fatal: %@ %@", exception.name, exception.reason);
        return nil;
    }
}

- (id)newMutableObjectAtIndexedSubscript:(NSUInteger)index {
    @try {
        return [self newMutableObjectAtIndexedSubscript:index];
    } @catch (NSException *exception) {
        NSLog(@"Fatal: %@ %@", exception.name, exception.reason);
        return nil;
    }
}

@end

@implementation NSBundle (JZExtension)

+ (id)jz_loadLocalFileWithName:(NSString *)name
                       type:(NSString *)type {
    
    NSString *path = [[NSBundle mainBundle] pathForResource:name ofType:type];
    if (path == nil) {return nil;}
    NSData *data = [[NSData alloc] initWithContentsOfFile:path];
    if (data == nil) {return nil;}
    return [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
}

@end


