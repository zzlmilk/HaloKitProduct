//
//  PowerDeviceModel.h
//  socketDemo
//
//  Created by 范博 on 2017/5/31.
//  Copyright © 2017年 范博. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YYModel.h"

@interface PowerDataModel : NSObject
@property (nonatomic, strong)NSString *power;

@end

@interface PowerDeviceModel : NSObject
@property (nonatomic, strong)NSString *state;
@property (nonatomic,strong)NSString *msg;
@property (nonatomic, strong)NSString *servercode;
@property (nonatomic,strong)NSString *deviceid;
@property (nonatomic, strong)NSDictionary *data;

@end
