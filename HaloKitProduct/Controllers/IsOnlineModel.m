//
//  IsOnlineModel.m
//  socketDemo
//
//  Created by 范博 on 2017/5/31.
//  Copyright © 2017年 范博. All rights reserved.
//

#import "IsOnlineModel.h"

@implementation IsOnlineModel

+ (nullable NSDictionary<NSString *, id> *)modelContainerPropertyGenericClass{
    return @{
             @"data": onlineStatus.class
             };
}
@end

@implementation onlineStatus



@end
