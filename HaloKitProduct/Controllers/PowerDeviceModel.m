//
//  PowerDeviceModel.m
//  socketDemo
//
//  Created by 范博 on 2017/5/31.
//  Copyright © 2017年 范博. All rights reserved.
//

#import "PowerDeviceModel.h"


@implementation PowerDataModel

@end

@implementation PowerDeviceModel
+ (nullable NSDictionary<NSString *, id> *)modelContainerPropertyGenericClass{
    return @{
                @"data": PowerDataModel.class
             };
}

@end
