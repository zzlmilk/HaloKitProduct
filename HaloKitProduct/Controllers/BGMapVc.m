//
//  BGMapVc.m
//  HaloKitGlobal
//
//  Created by 范博 on 2017/4/25.
//  Copyright © 2017年 范博. All rights reserved.
//


#import "BGMapVc.h"
#import "Masonry.h"
#import <CoreLocation/CoreLocation.h>
#import "UIViewController+PopMessage.h"
//#import "NSObject+YYModel.h"
//#import "GeTuiModel.h"
//#import "JSONKit.h"
//#import "LinkDeviceVc.h"
//#import "MBProgressHUD.h"
//#import "HttpRequest.h"
//#import "HttpRequest_url.h"
//#import "fenceModel.h"
//#import "BoGeLangageSettingVc.h"
//#import "AppDelegate.h"
#import "GCDSocketManager.h"
//#import "DogView.h"
//#import "DogWindow.h"

#define DESDEVICEID @"deviceId"
#define IS_IPAD (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
#define SCREENW [UIScreen mainScreen].bounds.size.width
#define SCREENH [UIScreen mainScreen].bounds.size.height
@interface BGMapVc ()<NSStreamDelegate,UIAlertViewDelegate, BMKMapViewDelegate>
{
    
    BMKPointAnnotation *dogMarker;//宠物的大头针
    BMKCircle *Mcirc;

    
//    GMSMarker *dogMarker;//宠物的标记值
    UIImageView *commonView;
    UIImageView *dogView;
    NSMutableArray * dataArray;
    CLLocationCoordinate2D testcoor;//转化为百度地图的坐标
    CLLocationCoordinate2D locacoor;//把本地存储的坐标转成百度坐标
    double  lonNum;//经度
    double  latNum;//纬度
    CLLocationManager *_loacationManager;
    BOOL isCreateFence;
    NSInputStream  * inputStream;
    NSOutputStream * outputStream;
    NSString *deviceId;
    NSTimer *timer;
    NSTimer *HUDTimer;
    NSTimer *HUDTimer1;

    UIButton *refreshButton;
    UIButton *fenceButton;
    BOOL flag;
    BOOL flag1;
    
//    MBProgressHUD *progressHUD;
//    GCDSocketManager *secket;
//    DogWindow * dogW;
    BOOL findDog;
    BMKMapView *mapView;

}
@end



@implementation BGMapVc
- (void)viewDidLoad {
    [super viewDidLoad];
    findDog = YES;
//    dogW = [DogWindow sharedInstance];
    fenceButton = [[UIButton alloc]init];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(data:) name:@"posttude" object:nil];
    [[NSUserDefaults standardUserDefaults] setObject:@"FALSE" forKey:@"contect"];
    deviceId = [[NSUserDefaults standardUserDefaults] objectForKey:@"deviceId"];
    [[NSUserDefaults standardUserDefaults] setObject:@"获取中" forKey:@"collCount"];
//    secket = [GCDSocketManager sharedSocketManager];
    flag1 = YES;
    if (deviceId) {//
//        secket.className = @"MapVC";
//        secket.name = Equipmentinjection;
//        NSString *clientid = [[NSUserDefaults standardUserDefaults]objectForKey:@"clientId"];
//        NSString *deviceid  = [[NSUserDefaults standardUserDefaults]objectForKey:@"deviceId"];
//        [secket connectToServer:deviceid AndClientId:clientid];
//        [secket callBack:^(BGUserModel *model) {
//            if ([model.state isEqualToString:@"200"]) {
//                [[NSUserDefaults standardUserDefaults] setObject:@"TRUE" forKey:@"contect"];
//                secket.name = Positionpush;
//                [secket sendDataToServer:deviceid AndClientId:clientid];
//            }else{
//                [[NSUserDefaults standardUserDefaults] setObject:@"FALSE" forKey:@"contect"];
//                [self popSuccessShow:BGGetStringWithKeyFromTable(@"The collar is not connected" , @"BGLanguageSetting")];
//            }
//            
//        }];

    }else{
            UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
            UINavigationController *deviceVc = [storyboard instantiateViewControllerWithIdentifier:@"nav"];
            [self presentViewController:deviceVc animated:YES completion:nil];
            NSLog(@"********************iPhoneiPhoneiPhoneiPhoneiPhone");        
    }

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(data:) name:@"Hposttude" object:nil];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title  = @"找狗";
    [self init_mapView];
    [self initRefreshBtn];
    [self initFenceBtn];
    [self createMaskView: commonView];
//    progressHUD = [[MBProgressHUD alloc] initWithView:self.view];
//    [self.view addSubview:progressHUD];
//    [self.view bringSubviewToFront:progressHUD];
}

-(void)getFenceData{
    NSMutableDictionary * parameters = [NSMutableDictionary dictionary];
    //异步请求数据
    NSString *clientid = [[NSUserDefaults standardUserDefaults]objectForKey:@"clientId"];
    NSString *deviceid  = [[NSUserDefaults standardUserDefaults]objectForKey:@"deviceId"];
    NSLog(@"clientid%@---------------deviceid:%@",clientid, deviceid);

//    [[HttpRequest sharedInstance] GET:[HttpRequest_url fence_getUrl]  dict:@{@"clientid" : clientid, @"deviceid" : deviceid} succeed:^(id data) {
//        NSError* error;
//        NSDictionary* json = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
//        NSLog(@"createFence_network:%@",json);
//        fenceModel *fenceM = [fenceModel yy_modelWithDictionary:json];
//        railModel *railM = [[railModel alloc] init];
//        railM = [fenceM.data objectForKey:@"rail"];
//        NSLog(@"---------------railMrailMrailMrailM:%f， %d",railM.latitude,railM.status );
//        
//        if (railM.status == 0) {
//            [[NSUserDefaults standardUserDefaults] setObject:@"0.0" forKey:@"latitudeOfFenceCenter"];
//            [[NSUserDefaults standardUserDefaults] setObject:@"0.0" forKey:@"longitudeOfFenceCenter"];
//            [[NSUserDefaults standardUserDefaults] setDouble:0.000000 forKey:@"radiusOfFence"];
//            
//            if (Mcirc.map != nil) {
//                Mcirc.map = nil;
//                NSLog(@"------circcirccirc%@", Mcirc);
//            }
//            fenceButton.hidden = YES;
//            isCreateFence = YES;
//            [self initFenceBtnAct:fenceButton];
//            
//        }else{
//
//            [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"%f",railM.latitude ]forKey:@"latitudeOfFenceCenter"];
//            [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"%f",railM.longitude ] forKey:@"longitudeOfFenceCenter"];
//            [[NSUserDefaults standardUserDefaults] setDouble:railM.radius forKey:@"radiusOfFence"];
//            NSString *latitudeStr  = [[NSUserDefaults standardUserDefaults] objectForKey:@"latitudeOfFenceCenter"];
//            NSString *longtitudeStr   = [[NSUserDefaults standardUserDefaults] objectForKey:@"longitudeOfFenceCenter"];
//            CGFloat latitude = latitudeStr.floatValue;
//            CGFloat longtitude = longtitudeStr.floatValue;
//            CLLocation *location = [[CLLocation alloc]initWithLatitude:latitude longitude:longtitude];
//            location = [AppDelegate transformToMars:location];
//            double radius = [[NSUserDefaults standardUserDefaults] doubleForKey:@"radiusOfFence"];
//            NSLog(@"radiusOfFenceradiusOfFence:%f",radius);
//            NSLog(@"circcirccirc:%f*%f", latitude,longtitude);
//            fenceButton.hidden = NO;
//            isCreateFence = NO;
//            [self initFenceBtnAct:fenceButton];
//        }
//        
//        
//    } failure:^(NSError *error) {
//        
//        NSLog(@"createFence_networkeeroe2:%@",error);
//        [[NSUserDefaults standardUserDefaults] setObject:@"0.0" forKey:@"latitudeOfFenceCenter"];
//        [[NSUserDefaults standardUserDefaults] setObject:@"0.0" forKey:@"longitudeOfFenceCenter"];
//        [[NSUserDefaults standardUserDefaults] setDouble:0.000000 forKey:@"radiusOfFence"];
//        isCreateFence = NO;
//
//        if (Mcirc != nil) {
//            Mcirc.map = nil;
//            NSLog(@"------circcirccirc%@", Mcirc);
//            fenceButton.hidden = YES;
//            isCreateFence = NO;
//        }        
//    }];

}





//向服务器请求位置
-(void)findDog
{

//        secket.name = Settingmode;
//        NSString *clientid = [[NSUserDefaults standardUserDefaults]objectForKey:@"clientId"];
//        NSString *deviceid  = [[NSUserDefaults standardUserDefaults]objectForKey:@"deviceId"];
//        [secket sendDataToServer:deviceid AndClientId:clientid];
}



-(void)createMaskView:(UIImageView *)maskImage
{
    
    UIImage *image1 = [UIImage imageNamed:@"3"];
    UIImage *image2 = [UIImage imageNamed:@"2"];
    UIImage *image3 = [UIImage imageNamed:@"1"];
    maskImage.image = [UIImage animatedImageWithImages:@[image1,image2,image3] duration:0.7];
}



-(void)initRefreshBtn{
    refreshButton = [[UIButton alloc]init];
    [refreshButton setImage:[UIImage imageNamed:@"location"] forState:UIControlStateNormal];
    [self.view addSubview:refreshButton];
    [refreshButton addTarget:self action:@selector(mapRefurbishAct) forControlEvents:UIControlEventTouchUpInside];
    [refreshButton mas_makeConstraints:^(MASConstraintMaker *make) {
         make.size.mas_equalTo(CGSizeMake(40, 40));
         make.bottom.equalTo(self.view).with.offset(-160);
         make.left.equalTo(self.view).with.offset(10);
    }];
}

-(void)mapRefurbishAct{
    
//    if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"contect"] isEqualToString:@"TRUE"]) {
        [refreshButton setImage:[UIImage imageNamed:@"refeshLocation"] forState:UIControlStateNormal];
        [self requestLocation];
        CABasicAnimation *animation =  [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
        //默认是顺时针效果，若将fromValue和toValue的值互换，则为逆时针效果
        animation.fromValue =   [NSNumber numberWithFloat: 0.f];;
        animation.toValue =  [NSNumber numberWithFloat: M_PI *2];
        animation.duration  = 1.5;
        animation.autoreverses = NO;
        animation.fillMode =kCAFillModeForwards;
        animation.repeatCount = MAXFLOAT; //如果这里想设置成一直自旋转，可以设置为MAXFLOAT，否则设置具体的数值则代表执行多少次
        [refreshButton.imageView.layer addAnimation:animation forKey:nil];
        
//    }else{
//        [self popSuccessShow:BGGetStringWithKeyFromTable(@"The device is not connected" , @"BGLanguageSetting")];//"Please connect the device first"
//    }

}




-(void)initFenceBtn{
    
    NSUserDefaults *userD = [NSUserDefaults standardUserDefaults];
    NSString *desStr = [NSString stringWithFormat:@"%@",[userD objectForKey:DESDEVICEID]];
    
    if (desStr != nil) {
        fenceButton.hidden = YES;
        [fenceButton setImage:[UIImage imageNamed:@"fence_off"] forState:UIControlStateNormal];

        [self.view addSubview:fenceButton];
        [fenceButton addTarget:self action:@selector(initFenceBtnAct:) forControlEvents:UIControlEventTouchUpInside];
        [fenceButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(40, 40));
            make.bottom.equalTo(self.view).with.offset(-210);
            make.left.equalTo(self.view).with.offset(10);
        }];
    }else{
        [self popFailureShow:@"项圈未连接"];
    }
}

- (void)anamtion:(UIView *)view{
    
    CABasicAnimation *opacityAnimation = [CABasicAnimation animationWithKeyPath:@"opacity"];
    opacityAnimation.fromValue = [NSNumber numberWithFloat:1.5];
    opacityAnimation.toValue = [NSNumber numberWithFloat:0.0];
    opacityAnimation.duration = 2.0f;
    opacityAnimation.autoreverses= NO;
    opacityAnimation.repeatCount = MAXFLOAT;
    CABasicAnimation * animation2 = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    animation2.fromValue = [NSNumber numberWithDouble:0.5];
    animation2.toValue = [NSNumber numberWithDouble:1];
    animation2.duration= 2.0;
    animation2.autoreverses= NO;
    animation2.repeatCount= FLT_MAX;
    [view.layer addAnimation:animation2 forKey:@"scale"];
    [view.layer addAnimation:opacityAnimation forKey:nil];
}


-(void)initFenceBtnAct:(id)sender{
    if (isCreateFence) {
//        Mcirc.map = nil;
        isCreateFence = NO;
        [fenceButton setImage:[UIImage imageNamed:@"fence_off"] forState:UIControlStateNormal];

    }else{
        [fenceButton setImage:[UIImage imageNamed:@"fence_on"] forState:UIControlStateNormal];
        isCreateFence = YES;
        NSString *latitudeStr   = [[NSUserDefaults standardUserDefaults] objectForKey:@"latitudeOfFenceCenter"];
        NSString *longtitudeStr   = [[NSUserDefaults standardUserDefaults] objectForKey:@"longitudeOfFenceCenter"];
        NSLog(@"00000000:%@, %@",latitudeStr, longtitudeStr);
        CGFloat latitude = latitudeStr.floatValue;
        CGFloat longtitude = longtitudeStr.floatValue;
        double radius = [[NSUserDefaults standardUserDefaults] doubleForKey:@"radiusOfFence"];
        if (radius != 0.000000) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [mapView removeOverlays:mapView.overlays];
            });
            //将手势在地图上的位置转换为经纬度
            CLLocationCoordinate2D coor;
            coor.latitude = latitude;
            coor.longitude = longtitude;
            Mcirc = [BMKCircle circleWithCenterCoordinate:coor radius:radius];
            dispatch_async(dispatch_get_main_queue(), ^{
                [mapView addOverlay:Mcirc];
            });
        }
    }
}


//在地图上显示出来
-(BMKOverlayView *)mapView:(BMKMapView *)mapView viewForOverlay:(id<BMKOverlay>)overlay
{
    
    if (overlay == Mcirc) {
        BMKCircleView * circleView = [[BMKCircleView alloc] initWithOverlay:overlay];
        UIColor *circleFillColor = [[UIColor alloc] initWithRed:0.2 green:0.8 blue:0.2 alpha:0.1];
        circleView.fillColor = circleFillColor;
        UIColor *circleStrokeColor = [[UIColor alloc] initWithRed:0.2 green:0.8 blue:0.2 alpha:1];
        circleView.strokeColor = circleStrokeColor;
        circleView.lineWidth = 1.0;
        return circleView;
    }
    return nil;
}




-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    if (flag) {
        
        HUDTimer1 = [NSTimer scheduledTimerWithTimeInterval:90 target:self selector:@selector(HUDTimeraction1) userInfo:nil repeats:NO];
    }else{
        
    }

    deviceId = [[NSUserDefaults standardUserDefaults] objectForKey:@"deviceId"];
    if (deviceId){
        [self getFenceData];
        
        if (findDog) {
            findDog = NO;
        }else{
            [self findDog];

        }
        
    }

}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];

}

//初始化地图的一些东西
-(void)init_mapView
{
   
    NSUserDefaults *usersd = [NSUserDefaults standardUserDefaults];
    if ([usersd objectForKey:@"lolatitudeFind"]) {
        
        NSString * latNumm = [usersd objectForKey:@"lolatitudeFind"];
        NSString * lonNumm = [usersd objectForKey:@"lolonitudeFind"];
        NSLog(@"--transformToMarstransformToMars:%f, %f",latNumm.doubleValue, lonNumm.doubleValue);

        CLLocation *location = [[CLLocation alloc]initWithLatitude:latNumm.doubleValue  longitude:lonNumm.doubleValue];
        
        mapView = [[BMKMapView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width,  self.view.bounds.size.height)];
        mapView.userTrackingMode = BMKUserTrackingModeFollow;;//设置定位的状态（跟随模式）
        mapView.showsUserLocation = YES;//显示定位图层
        mapView.zoomLevel = 16;
        [self.view addSubview:mapView];
        
        
        UIImage *house = [UIImage imageNamed:@"3"];
        commonView = [[UIImageView alloc] initWithImage:house];
        CLLocationCoordinate2D position = CLLocationCoordinate2DMake(latNumm.doubleValue, lonNumm.doubleValue);
        
        dogMarker = [[BMKPointAnnotation alloc] init];
        mapView.centerCoordinate = CLLocationCoordinate2DMake(31.170785, 121.397421);
        dogMarker.coordinate = CLLocationCoordinate2DMake(31.170785, 121.397421);
        

        
//      HUDTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(HUDTimeraction) userInfo:nil repeats:NO];
    }else{
      
        mapView = [[BMKMapView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width,  self.view.bounds.size.height)];
        mapView.userTrackingMode = BMKUserTrackingModeFollow;;//设置定位的状态（跟随模式）
        mapView.showsUserLocation = YES;//显示定位图层
        mapView.zoomLevel = 16;
        dogMarker = [[BMKPointAnnotation alloc] init];
        mapView.centerCoordinate = CLLocationCoordinate2DMake(31.170785, 121.397421);
        dogMarker.coordinate = CLLocationCoordinate2DMake(31.170785, 121.397421);

        [self.view addSubview:mapView];
        UIImage *house = [UIImage imageNamed:@"3"];
        commonView = [[UIImageView alloc] initWithImage:house];
        flag = YES;
        
    }

}

-(void)HUDTimeraction1{
    [HUDTimer1 invalidate];
//    [progressHUD hide:YES];
    [self popSuccessShow:@"项圈信号弱"];
}



- (void)onClickedLeftbtn{


}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [timer invalidate];
//    [dogW closewindow];

//    dogMarker.iconView = commonView;
    dispatch_async(dispatch_get_main_queue(), ^{
        [mapView removeOverlays:mapView.overlays];
    });

    
//    if(deviceId ){
//        secket.name = Settingmode_0;
//        NSString *clientid = [[NSUserDefaults standardUserDefaults]objectForKey:@"clientId"];
//        NSString *deviceid  = [[NSUserDefaults standardUserDefaults]objectForKey:@"deviceId"];
//        [secket sendDataToServer:deviceid AndClientId:clientid];
//    }

}

//获取个推返回的数据
-(void)data:(NSNotification *)center
{
//    [dogW closewindow];
//    [progressHUD hide:YES];
//    NSUserDefaults *usersd = [NSUserDefaults standardUserDefaults];
//    dataArray = center.object;
//    PostionPushg3Model *g3Model =  [[PostionPushg3Model alloc]init];
//    g3Model = center.object;
//    NSLog(@"地理位置：%@", g3Model.longitude);
//    lonNum = g3Model.longitude.doubleValue;
//    latNum = g3Model.latitude.doubleValue;
//    NSString *loLongStr = [NSString stringWithFormat:@"%f",lonNum];
//    [usersd setObject:loLongStr forKey:@"lolonitudeFind"];
//    NSString *loLatiStr = [NSString stringWithFormat:@"%f",latNum];
//    [usersd setObject:loLatiStr forKey:@"lolatitudeFind"];
//    NSLog(@"zuobiao1:%f, %f", latNum, lonNum );
//    CLLocation *location = [[CLLocation alloc]initWithLatitude:latNum longitude:lonNum];
//    location = [AppDelegate transformToMars:location];
//    CLLocationCoordinate2D position = CLLocationCoordinate2DMake(latNum, lonNum);
//    if (flag) {
//        flag = NO;
//        GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:latNum longitude:lonNum zoom:14];
//        _MapView = [GMSMapView mapWithFrame:self.view.frame camera:camera];
//        dogMarker = [GMSMarker markerWithPosition:position];
//        self.view = _MapView;
//        [self initRefreshBtn];
//        [self initFenceBtn];
//
//    }else{
//        NSLog(@"zuobiao2:%f, %f", location.coordinate.latitude, location.coordinate.longitude);
//
//        GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:latNum longitude:lonNum zoom:_MapView.camera.zoom];
//        _MapView.camera = camera;
//    }
//    
//    if (dogMarker.iconView) {
//        dogMarker.iconView = nil;
//    }
//    
//    dogMarker.position = position;
//    dogMarker.iconView = commonView;
//    dogMarker.map = _MapView;
//    [usersd synchronize];
    
}



-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"Hposttude" object:nil];
}


- (void)action{
    
    [UIView animateWithDuration:0.5 animations:^{
        refreshButton.imageView.transform = CGAffineTransformMakeRotation(0);
        [refreshButton.imageView.layer removeAllAnimations];
    } completion:^(BOOL finished) {
        [refreshButton setImage:[UIImage imageNamed:@"location"] forState:UIControlStateNormal];
        
    }];
}


- (void)refurbishAct:(id)sender {
//    [self initNetworkCommunication];
    [self requestLocation];

}

- (NSString*)getPreferredLanguage {
    NSUserDefaults* defs = [NSUserDefaults standardUserDefaults];
    NSArray* languages = [defs objectForKey:@"AppleLanguages"];
    NSString* preferredLang = [languages objectAtIndex:0];
    NSLog(@"Preferred Language:%@", preferredLang);
    return preferredLang;
}



- (BMKAnnotationView *)mapView:(BMKMapView *)mapView viewForAnnotation:(id <BMKAnnotation>)annotation
{
    //    NSUserDefaults * userD = [NSUserDefaults standardUserDefaults];
    //    NSString * imageUrl = [NSString stringWithFormat:@"%@",[userD objectForKey:AIMAGEPATH]];
    //    NSString * ownerUrl = [NSString stringWithFormat:@"%@",[userD objectForKey:IMAGEPATH]];
    //    NSLog(@"IMAGEPATHIMAGEPATHIMAGEPATH:%@", ownerUrl);
    
    //    if ([annotation isKindOfClass:[BMKUserLocation class]]) {
    //        return nil;
    //    }
    //            BMKPointAnnotation* ann = (BMKPointAnnotation*)annotation;
    dogMarker = [[BMKAnnotationView alloc]init];
    dogView.image = [UIImage imageNamed:@"1"];
//    dogMarker.annotation = annotation;
    [self createMaskView: dogView];
    return dogView;
}



//向服务器请求位置
-(void)requestLocation
{
//    NSString *latitudeStr  = [[NSUserDefaults standardUserDefaults] objectForKey:@"lolatitudeFind"];
//    NSString *longtitudeStr   = [[NSUserDefaults standardUserDefaults] objectForKey:@"lolonitudeFind"];
//    CGFloat latitude = latitudeStr.floatValue;
//    CGFloat longtitude = longtitudeStr.floatValue;
//    CLLocation *location = [[CLLocation alloc]initWithLatitude:latitude longitude:longtitude];
//    location = [AppDelegate transformToMars:location];
//    CLLocationCoordinate2D position = CLLocationCoordinate2DMake(latitude, longtitude);
//    GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:latitude longitude:longtitude zoom:_MapView.camera.zoom];
//    _MapView.camera = camera;
//
//    if (dogMarker.iconView) {
//        dogMarker.iconView = nil;
//    }
//    dogMarker.position = position;
//    dogMarker.iconView = commonView;
//    dogMarker.map = _MapView;
//    secket.name = Querypoint;
//    NSString *clientid = [[NSUserDefaults standardUserDefaults]objectForKey:@"clientId"];
//    NSString *deviceid  = [[NSUserDefaults standardUserDefaults]objectForKey:@"deviceId"];
//
//    
//    if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"contect"] isEqualToString:@"TRUE"]) {//deviceId.length > 8
//        [secket sendDataToServer:deviceid AndClientId:clientid];
//    }else if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"contect"] isEqualToString:@"FALSE"]){
//        [self popFailureShow:BGGetStringWithKeyFromTable(@"The device is not connected", @"BGLanguageSetting")];
//    }else{
//    
//     [self popFailureShow:BGGetStringWithKeyFromTable(@"The network can not be accessed, please check the network connection" , @"BGLanguageSetting")];
//    }
//    
//    timer = [NSTimer scheduledTimerWithTimeInterval:2.5 target:self selector:@selector(action) userInfo:nil repeats:NO];
//
}


@end
