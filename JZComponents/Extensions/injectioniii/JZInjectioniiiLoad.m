//
//  JZInjectioniiiLoad.m
//  GitHub
//
//  Created by Jentle-Zhi on 2020/4/15.
//  Copyright © 2020 GitHub. All rights reserved.
//

#import "JZInjectioniiiLoad.h"

@implementation JZInjectioniiiLoad

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        __block id observer =
           [[NSNotificationCenter defaultCenter] addObserverForName:UIApplicationDidFinishLaunchingNotification object:nil queue:nil usingBlock:^(NSNotification * _Nonnull note) {
               [[NSBundle bundleWithPath:@"/Applications/InjectionIII.app/Contents/Resources/iOSInjection.bundle"] load];
               [[NSNotificationCenter defaultCenter] removeObserver:observer];
           }];
    });
}

@end
