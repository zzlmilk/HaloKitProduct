////
////  BGElectFenceVc.m
////  HaloKitGlobal
////
////  Created by 范博 on 2017/5/7.
////  Copyright © 2017年 范博. All rights reserved.
//

#import "BGElectFenceVc.h"
//#import "UIViewController+PopMessage.h"
//#import "NSObject+YYModel.h"
//#import "GeTuiModel.h"
//#import "JSONKit.h"
//#import "MBProgressHUD.h"
//#import "HttpRequest_url.h"
#import "HttpRequest.h"
//#import "fenceModel.h"
//#import "lonlatModel.h"
#import "GCDSocketManager.h"
#import "CustomAnnotation.h"
//#import "DogWindow.h"
//#import "Reachability.h"
#import "Masonry.h"
#import "CZBottomMenu.h"
#import "CustomAnnotation.h"
#import "DogAnnotationView.h"
#import "OwnerAnnotationView.h"

//屏幕尺寸模块
#define kDeviceWidth  [UIScreen mainScreen].bounds.size.width
#define kDeviceHeight [UIScreen mainScreen].bounds.size.height
#define kScaleW kDeviceWidth/375
#define kScaleH kDeviceHeight/667

@interface BGElectFenceVc ()< NSStreamDelegate,UIGestureRecognizerDelegate,BMKMapViewDelegate,BMKLocationServiceDelegate,BMKGeoCodeSearchDelegate >
@property (nonatomic, strong) CustomAnnotation* ownerannotation;
@property (nonatomic, strong) CustomAnnotation* pointannotation;
@property (nonatomic, strong) BMKLocationService *locService;
@property (nonatomic, strong) DogAnnotationView *dogAnnotation;//宠物的头像
@property (nonatomic, strong) OwnerAnnotationView *ownerAnnotation;//宠物主人的头像

@end

@implementation BGElectFenceVc
{
    BMKPointAnnotation *cpointannotation;//宠物的大头针
    BMKCircle *circ;
    BMKAnnotationView *dogImgView;
    BOOL isShowOwner;
    
    
    
    BMKLocationService *_locService;
    UILabel *centerLabel;
    NSTimer *timer;
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
    int radiusOfFence;
    NSString *latitudeOfFenceCenter;
    NSString * longitudeOfFenceCenter;
    NSArray *titleArray;//这里直接创建一个装半径的数组，根据选择的index来取得对应的半径
    UIButton *fenceButton;
    UIButton *OKFenceBtn;
    UIButton *CancelFenceBtn;
    UIButton *initRefreshBtn ;
    BOOL flag;
//  MBProgressHUD *progressHUD;
    NSTimer *HUDtimer;
    UIButton *rightBtn;
//  GCDSocketManager *socket;
//  DogWindow * dogW;
    UIButton *OKFenceBtn1;
    UIImageView* commonView;
    UIView *centerView;
    BOOL centerViewFlag;
    UIView * statusView;
    BOOL statusFlag;
}

- (void)viewDidLoad {
    [super viewDidLoad];
//    dogW = [DogWindow sharedInstance];
//    socket = [GCDSocketManager sharedSocketManager];
//    if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"contect"] isEqualToString:@"TRUE"]){
//        NSString *clientid = [[NSUserDefaults standardUserDefaults]objectForKey:@"clientId"];
//        deviceId  = [[NSUserDefaults standardUserDefaults]objectForKey:@"deviceId"];
//        socket.name = Positionpush;
//        NSLog(@"*****%@-----%@",deviceId, clientid);
//        [socket sendDataToServer:deviceId AndClientId:clientid];
//    }
    [self initData];
    [self initCenterView];
    [self creatOperationView];
    [self OKFenceBtn];
    [self CancelFenceBtn];
    [self OKFenceBtn1];
    [self createCaterView];
    centerViewFlag = YES;
    
    rightBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 50, 30)];
    [rightBtn setTitle: @"编辑" forState:UIControlStateNormal];
    [rightBtn addTarget:self  action:@selector(showAlertController) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * myButton = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
    rightBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [rightBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    self.navigationItem.rightBarButtonItem = myButton;
    [self.navigationController.navigationBar setTintColor:[UIColor blackColor]];
}



-(void)initData{
    self.view.userInteractionEnabled = YES;
    self.title  = @"电子围栏";
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(data:) name:@"posttude" object:nil];
    deviceId = [[NSUserDefaults standardUserDefaults] objectForKey:@"deviceId"];
    NSLog(@"deviceIddeviceIddeviceIddeviceIddeviceIddeviceIddeviceId:%@",deviceId);
    

    
    
    self.operationView = [[UIView alloc]init];
    self.operationView.frame = CGRectMake(0, kDeviceHeight, kDeviceWidth, 70);
    radiusOfFence = 500;
    statusView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, -64)];
    statusView.backgroundColor = [UIColor redColor];
    UILabel * descLabel = [[UILabel alloc]initWithFrame:CGRectMake(50, -40, self.view.bounds.size.width, 20)];
    descLabel.text = @"项圈状态：未连接状态，点击请链接";
    descLabel.backgroundColor = [UIColor yellowColor];
    UIImageView *imgView = [[UIImageView alloc]initWithFrame:CGRectMake(10, -50, 40, 40)];
    imgView.backgroundColor = [UIColor blueColor];
    [statusView addSubview:descLabel];
    [statusView addSubview:imgView];
//    //初始化BMKLocationService
//    _locService = [[BMKLocationService alloc]init];
//    _locService.delegate = self;
//    //启动LocationService
//    [_locService startUserLocationService];
}


- (void)createCaterView{

    centerView = [[UIView alloc]initWithFrame:CGRectMake(kDeviceWidth/2 - 50, kDeviceHeight/2 - 95, 100, 25)];
    centerView.backgroundColor = [[UIColor alloc]initWithRed:110/255.0 green:118/255.0 blue:155/255.0  alpha:1];
    centerView.layer.cornerRadius = 12.5;
    centerView.clipsToBounds = YES;
    
    UIImageView *icon = [[UIImageView alloc]initWithImage:[UIImage imageNamed: @"location" ]];
    icon.frame = CGRectMake(5, 2.5, 20, 20);
    icon.userInteractionEnabled = YES;
    [centerView addSubview:icon];

    
    UIImage *centerImg = [UIImage imageNamed:@"location@1x"];
    commonView = [[UIImageView alloc]initWithFrame:CGRectMake(kDeviceWidth/2 - 10, kDeviceHeight/2 - 45, 20, 30)];
    commonView.image = centerImg;
    commonView.userInteractionEnabled = NO;
    
    centerLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 2.5, 100, 20)];
    centerLabel.text = @"创建电子围栏";
    centerLabel.userInteractionEnabled = YES;
    centerLabel.textColor = [UIColor whiteColor];
    centerLabel.font = [UIFont systemFontOfSize:10] ;
    centerLabel.textAlignment = NSTextAlignmentCenter;
    [centerView addSubview:centerLabel];
    
    centerView.userInteractionEnabled = YES;
    UIButton * btn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 100, 30)];
    [btn addTarget:self action: @selector(appearView) forControlEvents:UIControlEventTouchUpInside];
    [centerView addSubview:btn];
    
    [self.view addSubview:commonView];
    [self.view addSubview:centerView];

    [self.view addSubview:centerView];
    [self.view addSubview:commonView];
    
    initRefreshBtn = [[UIButton alloc]init];
    
    [initRefreshBtn setImage:[UIImage imageNamed:@"location"] forState:UIControlStateNormal];
    [self.view addSubview:initRefreshBtn];
    [initRefreshBtn addTarget:self action:@selector(refurbishAct:) forControlEvents:UIControlEventTouchUpInside];
    
    [initRefreshBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(40, 40));
        make.bottom.equalTo(self.view).with.offset(-150);
        make.left.equalTo(self.view).with.offset(10);
    }];
    
}






-(void)OKFenceBtn{
    OKFenceBtn = [[UIButton alloc]init];
    OKFenceBtn.hidden = YES;

    [OKFenceBtn setBackgroundImage:[UIImage imageNamed:@"done"] forState:UIControlStateNormal];
    [self.operationView addSubview:OKFenceBtn];
    [OKFenceBtn addTarget:self action:@selector(OKFenceBtnAct:) forControlEvents:UIControlEventTouchUpInside];
    [OKFenceBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(60, 60));
        make.bottom.equalTo(self.view).with.offset(-40);
        make.right.equalTo(self.view).with.offset(-kDeviceWidth/2 + 80 );
    }];
}


-(void)OKFenceBtn1{
    OKFenceBtn1 = [[UIButton alloc]init];
    OKFenceBtn1.hidden = YES;
    OKFenceBtn1.backgroundColor = [UIColor clearColor];
    OKFenceBtn1.enabled = YES;
    [self.view addSubview:OKFenceBtn1];
    [OKFenceBtn1 addTarget:self action:@selector(OKFenceBtnAct:) forControlEvents:UIControlEventTouchUpInside];
    [OKFenceBtn1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(60, 60));
        make.bottom.equalTo(self.view).with.offset(-40);
        make.right.equalTo(self.view).with.offset(-kDeviceWidth/2 + 60 );
    }];

}



-(void)CancelFenceBtn{
    CancelFenceBtn = [[UIButton alloc]init];
    CancelFenceBtn.hidden = YES;
    [CancelFenceBtn setBackgroundImage:[UIImage imageNamed:@"cancel1"]  forState:UIControlStateNormal];
    [self.operationView addSubview:CancelFenceBtn];
    [CancelFenceBtn addTarget:self action:@selector(CancelFenceBtnAct:) forControlEvents:UIControlEventTouchUpInside];
    [CancelFenceBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(60, 60));
        make.bottom.equalTo(self.view).with.offset(-40);
        make.left.equalTo(self.view).with.offset(kDeviceWidth/2 - 80 );
        
    }];

}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    if (deviceId){
        [self findDog];
    }


}

- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];


}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.mapView viewWillAppear];
    self.mapView.delegate = self;
    [self  init_mapView];
    statusFlag = YES;
//    [self.mapView addAnnotation:cpointannotation];


    self.tabBarController.tabBar.hidden=YES;
    NSString *latitudeStr   = [[NSUserDefaults standardUserDefaults] objectForKey:@"latitudeOfFenceCenter"];
    NSString *longtitudeStr = [[NSUserDefaults standardUserDefaults] objectForKey:@"longitudeOfFenceCenter"];
    commonView.hidden = NO;
    centerView.hidden = NO;
    double radius = [[NSUserDefaults standardUserDefaults] doubleForKey:@"radiusOfFence"];
    NSLog(@"^^^^^^^^^^^^^^^^^^^^^^^^^^:%@, %@", latitudeStr, longtitudeStr);
    if ([latitudeStr isEqualToString: @"0.0"] && [longtitudeStr isEqualToString: @"0.0"]) {
        rightBtn.hidden = YES;

    }else{
     
        NSLog(@"222222#22222#:%f, %f",latitudeStr.floatValue, longtitudeStr.floatValue);
        CLLocationCoordinate2D coor = CLLocationCoordinate2DMake(latitudeStr.floatValue, longtitudeStr.floatValue);
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.mapView removeOverlays:self.mapView.overlays];
        });
        circ = [BMKCircle circleWithCenterCoordinate:coor radius:radius];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.mapView addOverlay:circ];
        });
        commonView.hidden = YES;
        centerView.hidden = YES;
        rightBtn.hidden = NO;
    }
    
    CZBottomMenu *menu = [CZBottomMenu buttomMenu];
    CGFloat menuX = self.view.bounds.size.width - menu.bounds.size.width;
    CGFloat menuY = 100;
    CGFloat menuW = 43;
    CGFloat menuH = menu.bounds.size.height;
    menu.frame = CGRectMake(menuX, menuY, menuW, menuH);
    menu.backgroundColor = [UIColor clearColor];
    [self.view addSubview:menu];
    [self.view addSubview:statusView];

//    progressHUD = [[MBProgressHUD alloc] initWithView:self.view];
//    [self.view addSubview:progressHUD];
//    [self.view bringSubviewToFront:progressHUD];
//    progressHUD.delegate = self;    
//    NSLog(@"8888888888888888888888");
}

//初始化地图的一些东西
-(void)init_mapView
{

    NSUserDefaults *usersd = [NSUserDefaults standardUserDefaults];

    if ([usersd objectForKey:@"Elolongtude"] &&[usersd objectForKey:@"Elolatitude"]) {
//        lonNum = [[usersd objectForKey:@"Elolongtude"] doubleValue];
//        latNum = [[usersd objectForKey:@"Elolatitude"] doubleValue];
//        NSLog(@"***********, %f,%f",lonNum ,latNum);
//        
//        cpointannotation = [[BMKPointAnnotation alloc] init];
//        CLLocationCoordinate2D position = CLLocationCoordinate2DMake(latNum,lonNum);
//        NSLog(@"testcoortestcoor%f%f",latNum, lonNum);
//        self.mapView.centerCoordinate = position;
//        cpointannotation.coordinate = position;
    }else{
        // 设置地图类型
        
//        cpointannotation = [[BMKPointAnnotation alloc] init];
//        self.mapView.centerCoordinate = CLLocationCoordinate2DMake(31.170785, 121.397421);
//        cpointannotation.coordinate = CLLocationCoordinate2DMake(31.170785, 121.397421);

    }

}




- (void)HUDTimeraction1{
    [HUDtimer invalidate];
//    [dogW closewindow];  Your collar is in a weak position
//    [progressHUD hide:NO];
//    [self popSuccessShow:BGGetStringWithKeyFromTable(@"Your collar is in a weak position", @"BGLanguageSetting")];

}

- (void)initCenterView{
    
    self.mapView = [[BMKMapView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height)];
    self.mapView.userTrackingMode = BMKUserTrackingModeFollow;;//设置定位的状态（跟随模式）
    self.mapView.showsUserLocation = YES;//显示定位图层
    self.mapView.zoomLevel = 16;
    [self.view addSubview:self.mapView];
    [self startLocation];
    isShowOwner = NO;
    _pointannotation = [[CustomAnnotation alloc] init];
    _ownerannotation = [[CustomAnnotation alloc]init];
    _pointannotation.type = CREMATORY;
    _ownerannotation.type = SUPER_MARKET;
    
//    [self.commonView bringSubviewToFront:self.view];
//    [self.centerView bringSubviewToFront:self.view];


}


- (void)startLocation
{
    NSLog(@"进入普通定位态");
    
    // 初始化BMKLocationService
    _locService = [[BMKLocationService alloc]init];
    _locService.delegate = self;
    //启动LocationService
    [_locService startUserLocationService];
}


//处理方向变更信息
- (void)didUpdateUserHeading:(BMKUserLocation *)userLocation
{
    NSLog(@"heading is %@",userLocation.heading);
}

//处理位置坐标更新
- (void)didUpdateBMKUserLocation:(BMKUserLocation *)userLocation
{
    NSLog(@"当前位置信息：didUpdateUserLocation lat %f,long %f",userLocation.location.coordinate.latitude,userLocation.location.coordinate.longitude);
    
    if (isShowOwner) {
        [self.mapView addAnnotation:_ownerannotation];
        _ownerannotation.coordinate = userLocation.location.coordinate;

    }
    [self.mapView setCenterCoordinate:userLocation.location.coordinate];

}





- (BMKAnnotationView *)mapView:(BMKMapView *)mapView viewForAnnotation:(id <BMKAnnotation>)annotation
{
    if ([annotation isKindOfClass:[BMKUserLocation class]]) {
        return nil;
    }
    if ([annotation isKindOfClass:[CustomAnnotation class]]) {
        CustomAnnotation* ann = (CustomAnnotation*)annotation;
        if (ann.type == SUPER_MARKET) {
            _ownerAnnotation = [[[NSBundle mainBundle] loadNibNamed:@"OwnerAnnotationView" owner:nil options:nil] lastObject];
            _ownerAnnotation.headview.layer.cornerRadius = 21;
            _ownerAnnotation.headview.layer.masksToBounds = YES;
            _ownerAnnotation.headview.contentMode = UIViewContentModeScaleAspectFit;
            _ownerAnnotation.draggable = YES;
            //            if (ownerUrl.length > 8) {
            //                [_ownerAnnotation.headview sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",ownerUrl]]];
            //            }
            return _ownerAnnotation;
        }
        if (ann.type == CREMATORY) {
            _dogAnnotation = [[[NSBundle mainBundle] loadNibNamed:@"DogAnnotationView" owner:nil options:nil] lastObject];
            _dogAnnotation.headview.layer.cornerRadius = 24;
            _dogAnnotation.headview.layer.masksToBounds = YES;
            _dogAnnotation.headview.contentMode = UIViewContentModeScaleAspectFit;
            _dogAnnotation.draggable = YES;
            //            if (imageUrl.length > 8) {
            //                [dogAnnotation.headview sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",imageUrl]]];
            //            }
            return _dogAnnotation;
        }
    }
    _dogAnnotation.annotation = annotation;
    return nil;
}


-(void)showAlertController {
    commonView.hidden = NO;
    centerView.hidden = NO;
}



-(void)creatOperationView
{
    [_operationView removeFromSuperview];
    [self.view addSubview:self.operationView];

    [self.operationView bringSubviewToFront:self.view];
    self.operationView.backgroundColor = [UIColor whiteColor];
    //创建前面的title视图close
    _tilbl = [[UILabel alloc] init];
    _tilbl.textColor = [UIColor blackColor];
    [self.operationView addSubview:_tilbl];
    _tilbl.text =  @"范围大小";//
    _tilbl.font = [UIFont systemFontOfSize:12*kScaleW];
    _tilbl.textAlignment = NSTextAlignmentCenter;
    [_tilbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.operationView.mas_left).offset(10*kScaleW - 5);
        make.top.mas_equalTo(self.operationView.mas_top).offset(50*kScaleH - 15);
        make.width.mas_equalTo(80*kScaleW);
        make.height.mas_equalTo(30*kScaleH);
    }];
    
    //创建后面的进度条
    _pointSlider = [[ZTSlider alloc] initWithFrame:CGRectMake(90*kScaleW - 10, 50*kScaleH -20, kDeviceWidth - 100*kScaleW, 30*kScaleH) titles:@[] firstAndLastTitles:@[@"100m",@"2000m"] defaultIndex:40 sliderImage:[UIImage imageNamed:@"椭圆-1"]];
    [self.operationView addSubview:_pointSlider];
    //在这里对进度条进行操作(需要使用block回调)
    __weak __typeof__ (self) wself = self;
    _pointSlider.block = ^(int index)
    {
        radiusOfFence = index;
        [wself addOverlayView];
    };
}

-(void)createMaskView:(BMKAnnotationView *)maskImage
{
    UIImage *image1 = [UIImage imageNamed:@"3"];
    UIImage *image2 = [UIImage imageNamed:@"2"];
    UIImage *image3 = [UIImage imageNamed:@"1"];
    maskImage.image = [UIImage animatedImageWithImages:@[image1,image2,image3] duration:0.7];
}

//添加圆形地理围栏
- (void)addOverlayView {
    NSLog(@"radiusOfFence:%d", radiusOfFence);
    CGPoint point = CGPointMake(kDeviceWidth/2, kDeviceHeight/2);
    //将手势在地图上的位置转换为经纬度
    CLLocationCoordinate2D coor = [self.mapView convertPoint:point toCoordinateFromView:self.mapView];
    latitudeOfFenceCenter = [NSString stringWithFormat:@"%f", coor.latitude];
    longitudeOfFenceCenter = [NSString stringWithFormat:@"%f", coor.longitude];
    [self.mapView removeOverlays:self.mapView.overlays];
    circ  = [BMKCircle circleWithCenterCoordinate:coor radius:radiusOfFence];
    [self.mapView addOverlay:circ];
}

    
    //在地图上显示出来
    -(BMKOverlayView *)mapView:(BMKMapView *)mapView viewForOverlay:(id<BMKOverlay>)overlay
    {
        if (overlay == circ) {
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



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.mapView viewWillDisappear];
    self.mapView.delegate = nil;
    
    
    self.tabBarController.tabBar.hidden=NO;
    [timer invalidate];
//    socket.name = Settingmode_0;
    NSString *clientid = [[NSUserDefaults standardUserDefaults]objectForKey:@"clientId"];
    NSString *deviceid  = [[NSUserDefaults standardUserDefaults]objectForKey:@"deviceId"];
    if(clientid &&  deviceid){

//    [socket sendDataToServer:deviceid AndClientId:clientid];
    }
//    [dogW closewindow];
//    [progressHUD hide:YES];

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
//    NSLog(@"电子围栏地理位置：%@", g3Model.longitude);
//    lonNum = g3Model.longitude.doubleValue;
//    latNum = g3Model.latitude.doubleValue;
//    //经度
//    NSString *loLongStr = [NSString stringWithFormat:@"%f",lonNum];
//    [usersd setObject:loLongStr forKey:@"Elolongtude"];
//    //纬度
//    NSString *loLatiStr = [NSString stringWithFormat:@"%f",latNum];
//    [usersd setObject:loLatiStr forKey:@"Elolatitude"];
//    [usersd synchronize];
//    NSLog(@"dianzaiweilanzuobiao1:%f, %f", latNum,lonNum );
//    testcoor = CLLocationCoordinate2DMake(latNum, lonNum);
//    NSLog(@"testcoortestcoor%f%f",latNum, lonNum);
//    mapVieww.centerCoordinate = testcoor;
//    pointannotation.coordinate = testcoor;
//    [mapVieww addAnnotation:pointannotation];
}


-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"posttude" object:nil];
}



- (void)electicFenceAct:(id)sender {
    [self showAlertController];
}

- (void)refurbishAct:(id)sender {
    [self requestLocation];
    if (statusFlag) {
        statusFlag =  false;
        [self.navigationController setNavigationBarHidden:true];
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:1.0];
        statusView.transform = CGAffineTransformTranslate(statusView.transform, 0, 64);
        [UIView commitAnimations];

    }else{
        
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:1.0];
        statusView.transform = CGAffineTransformTranslate(statusView.transform, 0, -64);
        [UIView commitAnimations];
        [self.navigationController setNavigationBarHidden:false];
        statusFlag =  true;
    }

    
    
    
    [initRefreshBtn setImage:[UIImage imageNamed:@"refeshLocation"] forState:UIControlStateNormal];
    CABasicAnimation *animation =  [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
    //默认是顺时针效果，若将fromValue和toValue的值互换，则为逆时针效果
    animation.fromValue =   [NSNumber numberWithFloat: 0.f];;
    animation.toValue =  [NSNumber numberWithFloat: M_PI *2];
    animation.duration  = 1.5;
    animation.autoreverses = NO;
    animation.fillMode =kCAFillModeForwards;
    animation.repeatCount = MAXFLOAT; //如果这里想设置成一直自旋转，可以设置为MAXFLOAT，否则设置具体的数值则代表执行多少次
    [initRefreshBtn.imageView.layer addAnimation:animation forKey:nil];
    timer = [NSTimer scheduledTimerWithTimeInterval:2.5 target:self selector:@selector(action) userInfo:nil repeats:NO];
}

- (void)action{
    [UIView animateWithDuration:0.5 animations:^{
        initRefreshBtn.imageView.transform = CGAffineTransformMakeRotation(0);
        [initRefreshBtn.imageView.layer removeAllAnimations];
    } completion:^(BOOL finished) {
        [initRefreshBtn setImage:[UIImage imageNamed:@"location"] forState:UIControlStateNormal];
        
    }];
}

//发送电子围栏
-(void)OKFenceBtnAct:(id)sender{
    [self createFence_network];
    
}

- (void)createFence_network{
    //异步请求数据
    NSString * radius  = [NSString stringWithFormat:@"%d", radiusOfFence ];
    [[NSUserDefaults standardUserDefaults] setObject:latitudeOfFenceCenter forKey:@"latitudeOfFenceCenter"];
    [[NSUserDefaults standardUserDefaults] setObject:longitudeOfFenceCenter forKey:@"longitudeOfFenceCenter"];
    NSString * latitude = latitudeOfFenceCenter;
    NSString * longtitude = longitudeOfFenceCenter;
    [[NSUserDefaults standardUserDefaults] setDouble:radiusOfFence forKey:@"radiusOfFence"];
    NSString * token = [[NSUserDefaults standardUserDefaults]objectForKey:@"token"];

    [[HttpRequest sharedInstance] POSTHeader:@"http://api.halokit.cn:7070/halokit/v2/user/rail" dict:@{@"longitude" : latitude, @"latitude" : longtitude, @"radius" : radius, @"status" :@"1"} AndHeader:token succeed:^(id data) {
        NSLog(@"datadatadatadatadatadata:%@",data);
        [HttpRequest sharedInstance];
        NSNumber *code = [data objectForKey:@"code"];
        NSLog(@"da1tadatadatadatadatadata:%@",code);
        if ([code isEqual:@30000019]) {
            
        }else{
        }
        
        rightBtn.hidden = NO;
        OKFenceBtn.hidden = YES;
        OKFenceBtn1.hidden = YES;
        CancelFenceBtn.hidden = YES;
        commonView.hidden = YES;
        centerLabel.hidden = YES;
        centerView.hidden = YES;
        [self dismissView];

        
    } failure:^(NSError *error) {
        NSLog(@"createFence_networkeeroe3:%@",error);
    }];
}

- (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString {
    
    if (jsonString == nil) {
        
        return nil;
        
    }
    
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                         
                                                        options:NSJSONReadingMutableContainers
                         
                                                          error:&err];
    if(err) {
        
        NSLog(@"json解析失败：%@",err);
        
        return nil;
        
    }
    
    return dic;
    
}




//取消电子围栏设置
-(void)CancelFenceBtnAct:(id)sender{
    commonView.hidden = NO;
    centerView.hidden = NO;
    OKFenceBtn.hidden = YES;
    OKFenceBtn1.hidden = YES;
    CancelFenceBtn.hidden = YES;
    [self dismissView];
    [self.mapView removeOverlays:self.mapView.overlays];

}


//向服务器请求位置
-(void)requestLocation
{
//    [self isNetwork];
//    if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"contect"] isEqualToString:@"TRUE"]) {//deviceId.length > 8
//        socket.name = Querypoint;
//        NSString *clientid = [[NSUserDefaults standardUserDefaults]objectForKey:@"clientId"];
//        NSString *deviceid  = [[NSUserDefaults standardUserDefaults]objectForKey:@"deviceId"];
//        [socket sendDataToServer:deviceid AndClientId:clientid];
//    }else if([[[NSUserDefaults standardUserDefaults] objectForKey:@"contect"] isEqualToString:@"FALSE"]){
//        [self popFailureShow:BGGetStringWithKeyFromTable(@"Please connect the collar first", @"BGLanguageSetting")];
//    }
}


//- (BOOL)isNetwork{
//    BOOL isExistenceNetwork = YES;
//    Reachability *reach = [Reachability reachabilityWithHostName:@"www.baidu.com"];
//    switch ([reach currentReachabilityStatus])
//    {
//        case NotReachable:
//            isExistenceNetwork = NO;
//            [[NSUserDefaults standardUserDefaults] setObject:@"FALSE" forKey:@"contect"];
//            break;
//        case ReachableViaWiFi:
//            isExistenceNetwork = YES;
//            
//            
//            break;
//        case ReachableViaWWAN:
//            isExistenceNetwork = YES;
//            
//            break;
//    }
//    return isExistenceNetwork;
//}


//向服务器请求位置
-(void)findDog
{
//    if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"contect"] isEqualToString:@"TRUE"]) {//deviceId.length > 8
//        socket.name = Settingmode;
//        NSString *clientid = [[NSUserDefaults standardUserDefaults]objectForKey:@"clientId"];
//        NSString *deviceid  = [[NSUserDefaults standardUserDefaults]objectForKey:@"deviceId"];
//        [socket sendDataToServer:deviceid AndClientId:clientid];
    
//    }else{
//        
//    }
}





- (void)updateFence_network{
//    [dogW show];
    //异步请求数据
//    NSString *clientid = [[NSUserDefaults standardUserDefaults]objectForKey:@"clientId"];
//    NSString *deviceid  = [[NSUserDefaults standardUserDefaults]objectForKey:@"deviceId"];
//    [[HttpRequest sharedInstance] POST:@"http://api.halokit.cn:6061/halokit/v1/user/rail/update"  dict:@{@"clientid" : clientid, @"deviceid" : deviceid, @"longitude" :  @"0.0", @"latitude" : @"0.0", @"radius" : @"0", @"status": @"0"} succeed:^(id data) {
//        commonView.hidden = NO;
//        centerView.hidden = NO;
//        OKFenceBtn.hidden = YES;
//        OKFenceBtn1.hidden = YES;
//
//        centerLabel.hidden = NO;
//        CancelFenceBtn.hidden = YES;
//        circ.map = nil;
//        [dogW closewindow];
//        [self dismissView];
//    } failure:^(NSError *error) {
//        NSLog(@"errorerror:%@",error);
//        [dogW closewindow];
//
//    }];
}




-(void)appearView
{
    [UIView animateWithDuration:1.5 animations:^{
        //选择半径的视图出现
        self.operationView.frame = CGRectMake(0, kDeviceHeight - 70, kDeviceWidth, 70);
        commonView.hidden = YES;
        centerView.hidden = YES;
        [self addOverlayView];
        OKFenceBtn.hidden = NO;
        OKFenceBtn1.hidden = NO;
        CancelFenceBtn.hidden = NO;
    }];
}




- (void)mapView:(BMKMapView *)mapView regionDidChangeAnimated:(BOOL)animated
{
    NSString *longtitudeStr   = [[NSUserDefaults standardUserDefaults] objectForKey:@"latitudeOfFenceCenter"];
    NSString *latitudeStr   = [[NSUserDefaults standardUserDefaults] objectForKey:@"longitudeOfFenceCenter"];
    if ([latitudeStr isEqualToString: @"0.0"] && [longtitudeStr isEqualToString: @"0.0"]) {
        if (circ != nil) {
            [self.mapView removeOverlay:circ];
        }
        
        [UIView animateWithDuration:1.5 animations:^{
            //选择半径的视图出现
            OKFenceBtn.hidden = YES;
            OKFenceBtn1.hidden = YES;
            CancelFenceBtn.hidden = YES;
            commonView.hidden = NO;
            centerView.hidden = NO;
        }];

    }else{
            commonView.hidden = YES;
            centerView.hidden = YES;
    }
    
    [self dismissView];

}



-(void)dismissView
{
    [UIView animateWithDuration:1.5 animations:^{
        self.operationView.frame = CGRectMake(0, kDeviceHeight + 5, kDeviceWidth, 70);
        OKFenceBtn.hidden = YES;
        OKFenceBtn1.hidden = YES;
        CancelFenceBtn.hidden = YES;
    }];
}



@end
