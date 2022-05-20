//
//  JZUtility.h
//  Github
//
//  Created by Jentle-Zhi on 2020/3/20.
//  Copyright © 2020 Github. All rights reserved.
//

#import <Foundation/Foundation.h>

///屏蔽PerformSelector的警告
#define SuppressPerformSelectorLeakWarning(Stuff) \
    do { \
        _Pragma("clang diagnostic push") \
        _Pragma("clang diagnostic ignored \"-Warc-performSelector-leaks\"") \
        Stuff; \
        _Pragma("clang diagnostic pop") \
    } while (0)

NS_ASSUME_NONNULL_BEGIN

@interface JZUtility : NSObject

@end

NS_ASSUME_NONNULL_END
