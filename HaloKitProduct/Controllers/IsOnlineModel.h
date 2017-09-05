//
//  IsOnlineModel.h
//  socketDemo
//
//  Created by 范博 on 2017/5/31.
//  Copyright © 2017年 范博. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YYModel.h"

@interface onlineStatus : NSObject

@property (nonatomic, strong)NSString *onlineStatus;

@end

@interface IsOnlineModel : NSObject
@property (nonatomic, strong)NSString *state;
@property (nonatomic,strong)NSString *msg;
@property (nonatomic, strong)NSString *servercode;
@property (nonatomic,strong)NSString *deviceid;
@property (nonatomic, strong)NSDictionary *data;

@end
