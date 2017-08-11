//
//  LYHookUtility.m
//  LYRunTimeLog
//
//  Created by liuyang on 2017/8/10.
//  Copyright © 2017年 liuyang. All rights reserved.
//

#import "LYHookUtility.h"
#import <objc/runtime.h>

@implementation LYHookUtility

+ (void)swizzlingInClass:(Class)processedClass originalSelector:(SEL)originalSelector swizzledSelector:(SEL)swizzledSelector
{
    Method originMethod = class_getInstanceMethod(processedClass, originalSelector);
    Method swizzleMethod = class_getInstanceMethod(processedClass, swizzledSelector);
    
    BOOL didAddMethod = class_addMethod(processedClass, originalSelector, method_getImplementation(swizzleMethod), method_getTypeEncoding(swizzleMethod));
    
    if (didAddMethod) {
        class_replaceMethod(processedClass, originalSelector, method_getImplementation(originMethod), method_getTypeEncoding(originMethod));
    }else{
        method_exchangeImplementations(originMethod, swizzleMethod);
    }
}

@end
