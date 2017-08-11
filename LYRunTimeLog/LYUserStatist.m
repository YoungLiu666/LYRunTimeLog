//
//  LYUserStatist.m
//  LYRunTimeLog
//
//  Created by liuyang on 2017/8/10.
//  Copyright © 2017年 liuyang. All rights reserved.
//

#import "LYUserStatist.h"

@implementation LYUserStatist

#pragma mark -- 自定义事件统计部分


+ (void)sendEventToServer:(NSString *)eventId
{
    if([eventId isEqualToString:@"VIEW_FIELD"]){
    NSTimeInterval nowtime = [[NSDate date] timeIntervalSince1970]*1000;
    
    long long theTime = [[NSNumber numberWithDouble:nowtime] longLongValue];
    
    NSString *curTime = [NSString stringWithFormat:@"%llu",theTime];
        //获取NSUserDefaults对象
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
       [userDefaults setObject:curTime forKey:@"fieldStart"];
         NSLog(@"***模拟发送统计事件给服务端，事件ID: %@", eventId);
    }else{
        NSTimeInterval nowtime = [[NSDate date] timeIntervalSince1970]*1000;
        
        long long theTime = [[NSNumber numberWithDouble:nowtime] longLongValue];
        
        NSString *endTime = [NSString stringWithFormat:@"%llu",theTime];
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        //读取数据
        NSString * startTime  = [userDefaults objectForKey:@"fieldStart"];
        
        float time = ([endTime integerValue]-[startTime integerValue]);
        float sumTime= time/1000;
        NSString * fieldSumTime = [NSString stringWithFormat:@"textField经历%.2lf秒",sumTime];
        [userDefaults setObject:fieldSumTime forKey:@"fieldSumTime"];
         NSLog(@"发送统计事件给服务端，事件ID: %@  textField经历%.2lf秒", eventId,sumTime);

    }
    //在这里发送event统计信息给服务端
}

+ (void)appearPageViewWithPageID:(NSString *)pageID
{
    //进入页面
    NSLog(@"发送[进入页面]事件给服务端，页面ID:%@", pageID);
}

+ (void)disAppearPageViewWithPageID:(NSString *)pageID
{
    //离开页面 
    NSLog(@"发送[离开页面]事件给服务端，页面ID:%@", pageID);
}

@end
