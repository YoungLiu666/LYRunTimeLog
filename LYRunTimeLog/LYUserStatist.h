//
//  LYUserStatist.h
//  LYRunTimeLog
//
//  Created by liuyang on 2017/8/10.
//  Copyright © 2017年 liuyang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LYUserStatist : NSObject
+ (void)sendEventToServer:(NSString *)eventId;

+ (void)appearPageViewWithPageID:(NSString *)pageID;

+ (void)disAppearPageViewWithPageID:(NSString *)pageID;

@end
