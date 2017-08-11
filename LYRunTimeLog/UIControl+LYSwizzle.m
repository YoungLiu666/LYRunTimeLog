//
//  UIControl+LYSwizzle.m
//  LYRunTimeLog
//
//  Created by liuyang on 2017/8/10.
//  Copyright © 2017年 liuyang. All rights reserved.
//  继承UIControl的button textfield等

#import "UIControl+LYSwizzle.h"
#import "LYHookUtility.h"
#import "LYEventId.h"
#import "LYUserStatist.h"
@implementation UIControl (LYSwizzle)

+(void)load{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
       SEL originalSelector = @selector(sendAction:to:forEvent:);
        SEL swizzledSelector = @selector(swiz_sendAction:to:forEvent:);
        [LYHookUtility swizzlingInClass:[self class] originalSelector:originalSelector swizzledSelector:swizzledSelector];
    });
}

#pragma mark - Method Swizzling

- (void)swiz_sendAction:(SEL)action to:(id)target forEvent:(UIEvent *)event;
{
    //插入埋点代码
    [self performUserStastisticsAction:action to:target forEvent:event];
    [self swiz_sendAction:action to:target forEvent:event];
}

- (void)performUserStastisticsAction:(SEL)action to:(id)target forEvent:(UIEvent *)event;
{
    NSString *eventID = nil;
    //只统计触摸结束时
        NSString *actionString = NSStringFromSelector(action);
        NSString *targetName = NSStringFromClass([target class]);
        NSDictionary *configDict = [self dictionaryFromUserStatisticsConfigPlist];
        eventID = configDict[targetName][@"ControlEventIDs"][actionString];
    
    if (eventID != nil) {
        [LYUserStatist sendEventToServer:eventID];
    }
}

- (NSDictionary *)dictionaryFromUserStatisticsConfigPlist
{
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"LYFieldType" ofType:@"plist"];
    NSDictionary *dic = [NSDictionary dictionaryWithContentsOfFile:filePath];
    return dic;
}


@end
