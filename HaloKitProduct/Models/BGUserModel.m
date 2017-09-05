//
//  BGUserModel.m
//  socketDemo
//
//  Created by 范博 on 2017/6/2.
//  Copyright © 2017年 范博. All rights reserved.
//

#import "BGUserModel.h"


@implementation BGUserInfoModel
- (void)setModel:(BGUserInfoModel*)model{
    _model = model;
    [[NSUserDefaults standardUserDefaults] setObject:_model.__v forKey:@"version"];
    [[NSUserDefaults standardUserDefaults] setObject:_model._id forKey:@"ID"];
    [[NSUserDefaults standardUserDefaults] setObject:_model.created forKey:@"created"];

}

@end
@implementation BGUserModel
+ (nullable NSDictionary<NSString *, id> *)modelContainerPropertyGenericClass{
    return @{
             @"data": BGUserInfoModel.class
             };
}



@end
