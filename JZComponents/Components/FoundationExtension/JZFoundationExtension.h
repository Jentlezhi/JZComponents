//
//  JZFoundationExtension.h
//  Github
//
//  Created by Jentle-Zhi on 2020/3/20.
//  Copyright © 2020 Github. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSObject (JZExtension)

/**
 字典数组转模型数组.
 @param json - 字典数组.
 @return 模型数组.
 */
+ (NSArray *)jz_modelArrayWithKeyValuesArray:(id _Nullable)json;

/**
 字典转模型.
 @param json - 字典.
 @return 模型.
 */
+ (instancetype)jz_modelWithJSON:(id _Nullable)json;

/**
 模型转字典.
 @return 字典.
 */
@property(copy, nonatomic, readonly) NSDictionary *jz_keyValues;
/**
 模型赋值.
 @param data    - 数据.
 @return void.
 */
- (void)jz_setModelValueWithData:(id)data;

@end

@interface NSString (JZExtension)

/**
 拼接字符串.
 @param str  - 新字符串.
 @return 拼接后的字符串.
 */
@property(copy, nonatomic, readonly) NSString* (^jz_append)(NSString *str);

/**
 判断字符串是否为空(nil/空字符串).
 @param str  - 字符串.
 @return 是否为空.
 */
@property(copy, nonatomic, readonly, class) BOOL (^jz_isEmpty)(NSString * _Nullable str);

/**
 判断字符串是否为非空.
 @param str  - 字符串.
 @return 是否为非空.
 */
@property(copy, nonatomic, readonly ,class) BOOL (^jz_isNotEmpty)(NSString * _Nullable str);

/**
 判断字符串是否相等.
 @param str  - 字符串.
 @return 是否相等.
 */
@property(copy, nonatomic, readonly) BOOL (^jz_isEqual)(NSString * _Nullable str);

/**
 守护字符串安全，非空.
 @param str  - 字符串.
 @return 返回非空字符串.
 */
@property(copy, nonatomic, readonly, class) NSString* (^jz_guard)(NSString * _Nullable value);

/**
 随机英文字符串.
 @param length  - 字符串长度.
 @return 返回非空字符串.
 */
@property(copy, nonatomic, readonly, class) NSMutableString * (^jz_randomLetters)(int length);
/**
 随机英文字符串.
 @param min  - 最小字符串长度.
 @param max  - 最大字符串长度.
 @return 返回非空字符串.
 */
@property(copy, nonatomic, readonly, class) NSMutableString * (^jz_randomRangedLetters)(int min, int max);

/**
 随机中文字符串.
 @param length  - 字符串长度.
 @return 返回非空字符串.
 */
@property(copy, nonatomic, readonly, class) NSMutableString * (^jz_randomChineseLetters)(int length);
/**
 随机中文字符串.
 @param min  - 最小字符串长度.
 @param max  - 最大字符串长度.
 @return 返回非空字符串.
 */
@property(copy, nonatomic, readonly, class) NSMutableString * (^jz_randomRangedChineseLetters)(int min, int max);
/**
 首字母大写.
 @return 首字母大写的新字符串.
 */
@property(copy, nonatomic, readonly) NSString *jz_capitalizedFirstLatter;


@end

@interface NSArray (JZExtension)

@end

@interface NSMutableArray (Safe)

@end

@interface NSBundle (JZExtension)

+ (id)jz_loadLocalFileWithName:(NSString *)name
                          type:(NSString *)type;

@end


NS_ASSUME_NONNULL_END
