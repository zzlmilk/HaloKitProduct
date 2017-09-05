//
//  GCDSocketManager.m
//  socketDemo
//
//  Created by 范博 on 2017/5/23.
//  Copyright © 2017年 范博. All rights reserved.
// 3030

//#import "GCDSocketManager.h"
//#import "NSObject+YYModel.h"
//#import "PostionPushModel.h"
//#import "PowerDeviceModel.h"
//#import "IsOnlineModel.h"
//#import <Foundation/Foundation.h>
//
//#define SocketHost @"api.halokit.cn"
//#define SocketPort 3030
//
//
//@inte/rface GCDSocketManager()<GCDAsyncSocketDelegate>
//
////握手次数
//@property(nonatomic,assign) NSInteger pushCount;
//
////断开重连定时器
//@property(nonatomic,strong) NSTimer *timer;
//
////重连次数clientid
//@property(nonatomic,assign) NSInteger reconnectCount;
//
//
//@property(nonatomic, strong)NSString *deviceId;
//
//
//@property(nonatomic, strong)NSString *clientId;
//
//@property(nonatomic,strong) NSTimer *timer1;
//
//@property(nonatomic,strong) NSTimer *timer2;
//
//@property(nonatomic,strong) NSTimer *timer3;
//
//@end
//
//@implementation GCDSocketManager
//{
//    BOOL flag;
//}
//
////全局访问点
//+ (instancetype)sharedSocketManager {
//    static GCDSocketManager *_instance = nil;
//    static dispatch_once_t onceToken;
//    dispatch_once(&onceToken, ^{
//        _instance = [[self alloc] init];
//    });
//    
//    return _instance;
//}
//
////可以在这里做一些初始化操作
//- (instancetype)init
//{
//    self = [super init];
//    if (self) {
//        _reconnectCount = 0;
//        flag = NO;
//    }
//    return self;
//}
//
//
//
//#pragma mark 请求连接
////连接
//- (void)connectToServer:(NSString *)deviceid AndClientId:(NSString *)clientid {
//    self.deviceId = deviceid;
//    self.clientId = clientid;
//    self.pushCount = 0;
//    NSLog(@"连接_connectToServer");
//    self.socket = [[GCDAsyncSocket alloc] initWithDelegate:self delegateQueue:dispatch_get_main_queue()];
//    self.socket.delegate = self;
//    self.socket.autoDisconnectOnClosedReadStream = NO;
//    NSError *error = nil;
//    [self.socket connectToHost:SocketHost onPort: SocketPort error:&error];
//    if (error) {
//        NSLog(@"SocketConnectError:%@",error);
//    }
//}
//
//#pragma mark 连接成功
////连接成功的回调
//- (void)socket:(GCDAsyncSocket *)sock didConnectToHost:(NSString *)host port:(uint16_t)port {
//    NSLog(@"socket连接成功：%@， %@", self.deviceId, self.clientId);
//    [self sendDataToServer:self.deviceId AndClientId:self.clientId];
//    [[NSUserDefaults standardUserDefaults] setObject:self.deviceId forKey:@"deviceId"];
//    NSString* token = [[NSUserDefaults standardUserDefaults] objectForKey:@"token"];
//
//    if (flag) {
//        NSString * response = [@{@"deviceid":_deviceId,@"token":token, @"func":@"00"} JSONString];
//        NSData * data = [[NSData alloc] initWithData:[response dataUsingEncoding:NSASCIIStringEncoding]];//NSUTF8StringEncoding
//        //发送
//        [self.socket writeData:data withTimeout:-1 tag:1];
//        //    //读取数据
//        [self.socket readDataWithTimeout:-1 tag:200];
//
//    }
//}
//
//
////连接成功后向服务器发送数据
//- (void)sendDataToServer:(NSString *)deviceid AndClientId:(NSString *)clientid {
//    NSLog(@"socket连接成功后向服务器发送数据");
//    //发送数据代码省略...
//    NSDictionary * dict;
//    NSLog(@"self.nameself.name:%u",self.name);
//    switch (self.name) {
//        case Positionpush://位置推送6506
//            
//            dict = @{@"deviceid":deviceid,@"clientid":clientid,@"func":@"01"};
//            NSLog(@"\n, 011");
//
//            break;
//        case Querypoint://查询位置
//            
//            dict = @{@"deviceid":deviceid,@"clientid":clientid,@"func":@"03"};
//            NSLog(@"\n, 1");
//
//            break;
//        case Lightcontrol://灯光控制
//            
//            dict = @{@"deviceid":deviceid,@"clientid":clientid,@"func":@"06", @"content": self.content};
//            NSLog(@"\n, 2");
//
//            break;
//        case Powerpushing_08://电量推送
//            
//            dict = @{@"deviceid":deviceid,@"clientid":clientid,@"func":@"08"};
//            NSLog(@"\n, dianliang3");
//
//            break;
//        case Powerpushing_10://响应设置
//            
//            dict = @{@"deviceid":deviceid,@"clientid":clientid,@"func":@"10"};
//            NSLog(@"\n, 4");
//
//            break;
//        case Devicedisconnect://设备断开连接
//            
//            dict = @{@"deviceid":deviceid,@"clientid":clientid,@"func":@"1C"};
//            NSLog(@"\n, 5");
//
//            break;
//        case Equipmentinjection://设备注连
//            
//            dict = @{@"deviceid":deviceid,@"clientid":clientid,@"func":@"00"};
//            NSLog(@"\n, 6");
//            break;
//            
//        case Settingmode://设置模式
//            NSLog(@"deviceid:%@, clientid:%@",deviceid,  clientid);
//            dict = @{@"deviceid":deviceid,@"clientid":clientid,@"func":@"05", @"content":@"2"};
//            NSLog(@"\n, 7");
//            break;
//            
//        case Settingmode_0://设置模式
//            NSLog(@"deviceid:%@, clientid:%@",deviceid,  clientid);
//            dict = @{@"deviceid":deviceid,@"clientid":clientid,@"func":@"05", @"content":@"0"};
//            NSLog(@"\n, 8");
//            break;
//
//    }
//
//    NSString * response = [dict JSONString];
//    NSData * data = [[NSData alloc] initWithData:[response dataUsingEncoding:NSASCIIStringEncoding]];//NSUTF8StringEncoding
//    //发送
//    [self.socket writeData:data withTimeout:-1 tag:1];
////  //读取数据
//    [self.socket readDataWithTimeout:-1 tag:200];
//}
//
//
//
//
////连接成功向服务器发送数据后,服务器会有响应
//- (void)socket:(GCDAsyncSocket *)sock didReadData:(NSData *)data withTag:(long)tag {
//    NSLog(@"服务器会有响应:%@", data);
//    //服务器推送次数
//    self.pushCount++;
//    在这里进行校验操作,情况分为成功和失败两种,成功的操作一般都是拉取数据
//    if (data) {
//      self.socketRespsoneData(data);
//        NSString *dataString = [[NSString alloc] initWithBytes:data.bytes length:data.length encoding:NSUTF8StringEncoding];
//        GeTuiModel *model = [GeTuiModel yy_modelWithJSON:dataString];
//        NSLog(@"dataString:%@", dataString);
////      NSLog(@"data:%@", model.data);
//        NSLog(@"servercode:%@", model.servercode);
//        if ([model.servercode isEqualToString:@"01"]) {
//            PostionPushModel *postionModel = [PostionPushModel yy_modelWithJSON:dataString];
//            PostionPushDataModel *pushDataModel = [[PostionPushDataModel alloc]init];
//            pushDataModel = [postionModel.data objectForKey:@"g3"];
//            PostionPushg3Model *g3Model =  [[PostionPushg3Model alloc]init];
//            g3Model = pushDataModel.g3data;
//            NSLog(@"g3Modelg3Modelg3Model:%@", g3Model.collCount);
//            [[NSNotificationCenter defaultCenter] postNotificationName:@"posttude" object:g3Model];
//            [[NSNotificationCenter defaultCenter] postNotificationName:@"Hposttude" object:g3Model];
//            [[NSUserDefaults standardUserDefaults] setObject:g3Model.collCount  forKey:@"collCount"];
//            [[NSNotificationCenter defaultCenter] postNotificationName:@"postelector1" object:g3Model.collCount];
//
//        }else if ([model.servercode isEqualToString:@"08"]){
//            PowerDeviceModel* powerModel = [PowerDeviceModel  yy_modelWithJSON:dataString];
//            PowerDataModel *powerDataModel = [[PowerDataModel alloc ]init];
//            powerDataModel = [powerModel.data objectForKey:@"device"];
//            NSArray * arr = [powerDataModel.power componentsSeparatedByString:@","];
//            NSString * chargeValue = [NSString stringWithFormat:@"%@", arr[0]];
//            NSLog(@"电量：%d", [chargeValue intValue]);
//            NSString *str1 = [NSString stringWithFormat:@"%@", chargeValue];
//            [[NSUserDefaults standardUserDefaults] setObject:str1  forKey:@"collCount"];
//            [[NSNotificationCenter defaultCenter] postNotificationName:@"postelector" object:powerDataModel.power];
//
//        }else if ([model.servercode isEqualToString:@"10"]){
//            
//            
//        }else if ([model.servercode isEqualToString:@"1C"]){
//            IsOnlineModel *onlineModel = [IsOnlineModel yy_modelWithJSON:dataString];
//            NSLog(@"IsOnlineModelIsOnlineModel%@",onlineModel);
//            
//                [[NSNotificationCenter defaultCenter] postNotificationName:@"postStute" object:onlineModel.data];
//                [[NSUserDefaults standardUserDefaults]setObject:@"FLASE" forKey:@"contect"];
//                [[NSNotificationCenter defaultCenter] postNotificationName:@"loginstate" object:nil];
//                [[NSNotificationCenter defaultCenter] postNotificationName:@"loginstate1" object:nil];
//            
//        }else if ([model.servercode isEqualToString:@"00"]){
//            BGUserModel *useModel = [BGUserModel yy_modelWithJSON:dataString];
//            BGUserInfoModel *infoModel = [[BGUserInfoModel alloc]init];
//            infoModel.model = [useModel.data objectForKey:@"user"];
//            NSLog(@"infoModel.modelinfoModel.modelinfoModel.model:%@",infoModel.model.clientID);
//            if ([self.className isEqualToString:@"LinkVC"]) {
//                self.LinkDeviceBlock(useModel);
//            }else if ([self.className isEqualToString:@"BGDevice"]){
//                self.BGDeviceBlock(useModel);
//                NSLog(@"BGDeviceBGDeviceBGDevice");
//            }else if ([self.className isEqualToString:@"DeviceVc"]){
//                self.DeviceBlock(useModel);
//                NSLog(@"DeviceVcDeviceVcDeviceVc");
//
//            }else{
//                self.MapVcBlock(useModel);
//            }
//
//            if ([model.state  isEqual: @200]){
//                NSLog(@"0101010101010101");
//
//                NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(connectServer_08) userInfo:nil repeats:NO];
//                self.timer = timer;
//                
//                NSTimer *timer1 = [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(connectServer_05) userInfo:nil repeats:NO];
//                self.timer1 = timer1;
//
//                
//                [[NSUserDefaults standardUserDefaults]setObject:@"TRUE" forKey:@"contect"];
//            }else{
//                NSLog(@"iiiiiiiii@@@");
//
////                [[NSUserDefaults standardUserDefaults]setObject:@"FALSE" forKey:@"contect"];
//            }
//        }else if ([model.servercode isEqualToString:@"0D"]){
//            
//            PostionPushModel *postionModel = [PostionPushModel yy_modelWithJSON:dataString];
//            PostionPushDataModel *pushDataModel = [[PostionPushDataModel alloc]init];
//            pushDataModel = [postionModel.data objectForKey:@"g3"];
//            NSLog(@"g3Modelg3Modelg3Model:%@", pushDataModel._id);
//            NSLog(@"g3Modelg3Modelg3Model:%@", pushDataModel.g3data);
//            PostionPushg3Model *g3Model =  [[PostionPushg3Model alloc]init];
//            g3Model = pushDataModel.g3data;
//            NSLog(@"0D0D0D0D0D:%@", g3Model.altitude);
//            [[NSNotificationCenter defaultCenter] postNotificationName:@"posttude" object:g3Model];
//            [[NSNotificationCenter defaultCenter] postNotificationName:@"poststate" object:nil];
//            [[NSUserDefaults standardUserDefaults] setObject:g3Model.collCount  forKey:@"collCount"];
//            [[NSNotificationCenter defaultCenter] postNotificationName:@"postelector1" object:g3Model.collCount];
//        }
//    }
//    //读取数据
//    [self.socket readDataWithTimeout:-1 tag:200];
//    NSLog(@"[self.socket readDataWithTimeout:-1 tag:200]");
//
//}
//
//
//- (void)connectServer_08{
//    NSDictionary *dictionary2 = @{@"deviceid":self.deviceId,@"clientid":self.clientId,@"func":@"08"};
//    NSString * response2 = [dictionary2 JSONString];
//    NSData * data2 = [[NSData alloc] initWithData:[response2 dataUsingEncoding:NSASCIIStringEncoding]];
//    [self.socket writeData:data2 withTimeout:3600 tag:1];
//    [self.socket readDataWithTimeout:3600 tag:200];
//    [self.timer invalidate];
//    NSLog(@"0808080808@@@");
//
//}
//
//
//- (void)connectServer_05{
//
//    NSDictionary *dictionary = @{@"deviceid":self.deviceId,@"clientid":self.clientId,@"func":@"05", @"content":@"1"};
//    NSString * response = [dictionary JSONString];
//    NSData * data = [[NSData alloc] initWithData:[response dataUsingEncoding:NSASCIIStringEncoding]];
//    [self.socket writeData:data withTimeout:-1 tag:1];
//    [self.socket readDataWithTimeout:-1 tag:200];
//    [self.timer1 invalidate];
//
//}
//
//
//
//-(void)connectServer_00{
//    [self cutOffSocket];
//    self.className = @" ";
//    NSError *error = nil;
//    [self.socket connectToHost:SocketHost onPort:SocketPort error:&error];
//}
//
//
//- (void)callBack:(socketMapVcBlock)finishBlock{
//    if ([self.className isEqualToString:@"LinkVC"]) {
//        self.LinkDeviceBlock = finishBlock;
//    }else if ([self.className isEqualToString:@"BGDevice"]){
//        self.BGDeviceBlock = finishBlock;
//        NSLog(@"BGDeviceBlockBGDeviceBlock:%@", finishBlock);
//    }else if ([self.className isEqualToString:@"DeviceVc"]){
//        self.DeviceBlock = finishBlock;
//        
//    }else{
//        self.MapVcBlock = finishBlock;
//
//    }
//}
//
//
//#pragma mark 连接失败
////连接失败的回调
//- (void)socketDidDisconnect:(GCDAsyncSocket *)sock withError:(NSError *)err {
//    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
//
//    NSString *currentStatu = [userDefaults valueForKey:@"Statu"];
////  NSLog(@"Socket连接失败:%@---%hhd",err, [currentStatu isEqualToString:@"Foreground"]);
//    self.pushCount = 0;
////  程序在前台才进行重连
////    if ([currentStatu isEqualToString:@"Foreground"]) {
////        //重连次数
////        self.reconnectCount++;
////        //如果连接失败 累加1秒重新连接 减少服务器压力
////        NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:1.0 * self.reconnectCount target:self selector:@selector(reconnectServer) userInfo:nil repeats:NO];
////        self.timer = timer;
////    }
//
//}
//
//
//- (void)socketDidCloseReadStream:(GCDAsyncSocket *)sock{
//    
//    NSTimer *timer3 = [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(connectServer_00) userInfo:nil repeats:NO];
//    self.timer3 = timer3;
//    NSLog(@"socketDidCloseReadStreamsocketDidCloseReadStreamsocketDidCloseReadStream");
//}
//
//
////如果连接失败,5秒后重新连接
//- (void)reconnectServer {
//    
//    NSLog(@"reconnectServerreconnectServerreconnectServer");
//    self.pushCount = 0;
//    self.reconnectCount = 0;
//    //连接失败重新连接
//    NSError *error = nil;
//    [self.socket connectToHost:SocketHost onPort:SocketPort error:&error];
//    if (error) {
//        NSLog(@"SocektConnectError:%@",error);
//    }
//}
//
//
//#pragma mark 断开连接
////切断连接
//- (void)cutOffSocket {
//    NSLog(@"socket断开连接");
//    flag = YES;
//    self.pushCount = 0;
//    self.reconnectCount = 0;
//    [self.timer invalidate];
//    self.timer = nil;
//    [self.socket disconnect];
//}
//
//
//@end
//


