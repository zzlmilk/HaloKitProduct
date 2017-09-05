//
//  BGUserModel.h
//  socketDemo
//
//  Created by 范博 on 2017/6/2.
//  Copyright © 2017年 范博. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BGUserInfoModel : NSObject

@property (nonatomic, strong)NSString *clientID;
@property (nonatomic,strong)NSString *deviceID;
@property (nonatomic, strong)NSDictionary *created;
@property (nonatomic, strong)NSString *__v;
@property (nonatomic, strong)NSString *_id;

@property (nonatomic, strong)BGUserInfoModel *model;

@end

@interface BGUserModel : NSObject

@property (nonatomic, strong)NSString *state;
@property (nonatomic,strong)NSString *msg;
@property (nonatomic, strong)NSString *servercode;
@property (nonatomic, strong)NSDictionary *data;

@end
