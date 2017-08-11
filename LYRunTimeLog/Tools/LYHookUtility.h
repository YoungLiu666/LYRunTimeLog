//
//  LYHookUtility.h
//  LYRunTimeLog
//
//  Created by liuyang on 2017/8/10.
//  Copyright © 2017年 liuyang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LYHookUtility : NSObject
// 互换实现的工具类方法
+ (void)swizzlingInClass:(Class)processedClass originalSelector:(SEL)originalSelector swizzledSelector:(SEL)swizzledSelector;
@end
