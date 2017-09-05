////
////  GCDSocketManager.h
////  socketDemo
////
////  Created by 范博 on 2017/5/23.
////  Copyright © 2017年 范博. All rights reserved.
////

//#import <Foundation/Foundation.h>
//#import "JSONKit.h"
//#import "BGUserModel.h"
//#import "PostionPushModel.h"
//typedef enum {
//    
//    Positionpush       ,
//    Querypoint         ,
//    Lightcontrol       ,
//    Powerpushing_08    ,
//    Powerpushing_10    ,
//    Devicedisconnect   ,
//    Equipmentinjection ,
//    Settingmode        ,
//    Settingmode_0
//    
//    
//} Name;
//
//
//
//typedef void (^socketMapVcBlock)(BGUserModel *name);
//
//@interface GCDSocketManager : NSObject
//@property(nonatomic, assign)Name name;
//
//@property(nonatomic, assign)NSString * content;
//
//@property(nonatomic, assign)NSString *className;
//
//@property(nonatomic,strong) GCDAsyncSocket *socket;
//
//@property(nonatomic,strong)socketMapVcBlock MapVcBlock;//LinkDeviceBlock BGDevice
//
//@property(nonatomic,strong)socketMapVcBlock LinkDeviceBlock;//
//
//@property(nonatomic,strong)socketMapVcBlock BGDeviceBlock;//
//
//@property(nonatomic,strong)socketMapVcBlock DeviceBlock;//
//
//@property(nonatomic,strong)void(^socketRespsoneData)(NSData *data);
//
//
////单例
//+ (instancetype)sharedSocketManager;
//
////连接
//- (void)connectToServer:(NSString *)deviceid AndClientId:(NSString *)clientid ;
//
////断开
//- (void)cutOffSocket;
//
//- (void)sendDataToServer:(NSString *)deviceid AndClientId:(NSString *)clientid ;
//
//- (void)callBack:(socketMapVcBlock)finishBlock;
//
//- (void)reconnectServer;
//@end
