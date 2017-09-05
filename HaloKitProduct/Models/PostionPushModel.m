//
//  PostionPushModel.m
//  socketDemo
//
//  Created by 范博 on 2017/5/30.
//  Copyright © 2017年 范博. All rights reserved.
//

#import "PostionPushModel.h"

@implementation PostionPushModel

+ (nullable NSDictionary<NSString *, id> *)modelContainerPropertyGenericClass{
    return @{
             @"data": PostionPushDataModel.class
             };
}
@end

@implementation PostionPushDataModel
//+ (nullable NSDictionary<NSString *, id> *)modelContainerPropertyGenericClass{
//    return @{
//             @"g3data": PostionPushg3Model.class
//             };
//}

@end

@implementation g3AinfoModel

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{
             @"g3Ainfo" : @"g3info"
             };
}



@end


@implementation PostionPushg3Model


@end

@implementation g3infoModel 

@end

@implementation formattedAddressModel



@end
