//
//  BGElectFenceVc.h
//  HaloKitGlobal
//
//  Created by 范博 on 2017/5/7.
//  Copyright © 2017年 范博. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZTSlider.h"
#import <BaiduMapAPI_Map/BMKMapView.h>//只引入所需的单个头文件
#import <BaiduMapAPI_Base/BMKBaseComponent.h>//引入base相关所有的头文件
#import <BaiduMapAPI_Map/BMKMapComponent.h>//引入地图功能所有的头文件
#import <BaiduMapAPI_Location/BMKLocationComponent.h>//引入定位功能所有的头文件

@interface BGElectFenceVc : UIViewController
@property(nonatomic,strong) ZTSlider *pointSlider;//积分的段落
@property(nonatomic,strong) UILabel *tilbl;//标题
@property(strong, nonatomic) UIView *operationView;


@property (strong, nonatomic) BMKMapView *mapView;


@end
