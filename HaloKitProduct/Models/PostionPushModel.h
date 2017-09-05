//
//  PostionPushModel.h
//  socketDemo
//
//  Created by 范博 on 2017/5/30.
//  Copyright © 2017年 范博. All rights reserved.
//

#import <Foundation/Foundation.h>


//{"state":200,"msg":"位置推送","servercode":"01","deviceid":"861933030013924",
//    "data":{
//        "g3":{
//            "__v":0,"deviceID":"861933030013924","created":1496655434188,
//            "g3info":{"poi":"上虹新村四街坊","street":"莲花路","road":"莲花路","adcode":"310112","citycode":"021","city":"上海市","province":"上海市","country":"中国","desc":"上海市 闵行区 莲花路 靠近上虹新村四街坊","radius":"550","location":"121.3893039,31.172089","type":"4"},
//            "_id":"5935264a0dabde7cc9e51922",
//            "g3":{"myr":"260517","sfm":"225518","gpstype":"W","latitude":"121.3893039","longitude":"31.172089","speed":"0.00","direction":"0.0","altitude":"9","steps":"0","collCount":"80"
//            }
//        }
//    }
//}
//



//{"state":200,"msg":"位置推送","servercode":"01","deviceid":"861933030002018",
//    "data":{
//        "g3":{"__v":0,"deviceID":"861933030002018","created":1498447373161,"_id":"59507e0dd5d9953ad23af9b0",
//            "g3data":{"myr":"260617","sfm":"032254","gpstype":"A","latitude":"31.175179","longitude":"121.3870087","speed":"0.00","direction":"0.0","altitude":"9","steps":"13","collCount":"18"}
//        }
//    }
//}


//{
//    "g3":
//    {"__v":0,"deviceID":"861933030002018","created":1498617277892,
//        
//        "g3info":{
//            "addressComponent":{
//                "towncode":"310112107000","township":"虹桥镇","adcode":"310112","district":"闵行区","citycode":"021","city":[],"province":"上海市","country":"中国"
//                                },
//            "formatted_address":"上海市闵行区虹桥镇环镇南路48号"
//                },
//        
//        "g3data":{
//            "myr":"280617","sfm":"023436","gpstype":"A","latitude":"31.175100","longitude":"121.3871307","speed":"0.00","direction":"0.0","altitude":"9","steps":"0","collCount":"7"
//            }
//    }
//}

@interface formattedAddressModel : NSObject
@property (nonatomic,strong)NSString *township;
@property (nonatomic, strong)NSString *district;
@end

@interface g3infoModel : NSObject
@property (nonatomic,strong)NSString *poi;
@property (nonatomic, strong)NSString *desc;

@property (nonatomic, strong) formattedAddressModel *addressComponent;
@property (nonatomic, strong) NSString *formatted_address;
@end

@interface g3AinfoModel: NSObject
//@property (nonatomic, strong) NSString *township;
@property (nonatomic, strong) NSString *addressComponent;
@property (nonatomic, strong) NSString *formatted_address;
@end
@interface PostionPushg3Model : NSObject
@property (nonatomic,strong)NSString *myr;
@property (nonatomic, strong)NSString *sfm;
@property (nonatomic,strong)NSString *gpstype;
@property (nonatomic, strong)NSString *latitude;
@property (nonatomic,strong)NSString *longitude;
@property (nonatomic, strong)NSString *speed;
@property (nonatomic,strong)NSString *direction;
@property (nonatomic, strong)NSString *altitude;
@property (nonatomic,strong)NSString *steps;
@property (nonatomic, strong)NSString *collCount;
@end


@interface PostionPushDataModel : NSObject
@property (nonatomic, strong)NSString *created;
@property (nonatomic, strong)NSString *__v;
@property (nonatomic, strong)NSString *_id;
@property (nonatomic,strong)PostionPushg3Model *g3data;
@property (nonatomic,strong)g3infoModel *g3info;
@property (nonatomic,strong)g3AinfoModel *g3Ainfo;


@end


@interface PostionPushModel : NSObject
@property (nonatomic,strong)NSString *state;
@property (nonatomic,strong)NSString *servercode;
@property (nonatomic,strong)NSDictionary *data;
@property (nonatomic,strong)NSString *msg;
@property (nonatomic, strong)NSString *deviceid;

@end



