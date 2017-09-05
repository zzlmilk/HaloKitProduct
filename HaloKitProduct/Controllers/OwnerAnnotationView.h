//
//  OwnerAnnotationView.h
//  可点
//
//  Created by 何小弟 on 16/7/31.
//  Copyright © 2016年 赵东明. All rights reserved.
//
#import <BaiduMapAPI_Map/BMKMapView.h>//只引入所需的单个头文件
#import <BaiduMapAPI_Base/BMKBaseComponent.h>//引入base相关所有的头文件
#import <BaiduMapAPI_Map/BMKMapComponent.h>//引入地图功能所有的头文件
#import <BaiduMapAPI_Location/BMKLocationComponent.h>//引入定位功能所有的头文件
#import <BaiduMapAPI_Search/BMKSearchComponent.h>

@interface OwnerAnnotationView : BMKAnnotationView
@property (weak, nonatomic) IBOutlet UIImageView *BgView;
@property (weak, nonatomic) IBOutlet UIImageView *headview;

@end
