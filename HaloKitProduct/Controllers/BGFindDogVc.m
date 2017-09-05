//
//  BGFindDogVc.m
//  HaloKitProduct
//
//  Created by 范博 on 2017/7/28.
//  Copyright © 2017年 范博. All rights reserved.


#import "BGFindDogVc.h"
#import "CustomAnnotation.h"
#import "DogAnnotationView.h"
#import "OwnerAnnotationView.h"
#import "BGMapSettingVc.h"
#import "GCDSocketManager.h"
@interface BGFindDogVc ()<BMKMapViewDelegate,BMKLocationServiceDelegate,BMKGeoCodeSearchDelegate>

@property (nonatomic, strong)BMKMapView *mapView;

@property (nonatomic, strong) CustomAnnotation* ownerannotation;
@property (nonatomic, strong) CustomAnnotation* pointannotation;
@property (nonatomic, strong) BMKLocationService *locService;
@property (nonatomic, strong) DogAnnotationView *dogAnnotation;//宠物的头像
@property (nonatomic, strong) OwnerAnnotationView *ownerAnnotation;//宠物主人的头像

@property (nonatomic, assign) CGFloat longitude;  // 经度
@property (nonatomic, assign) CGFloat latitude; // 纬度

@end

@implementation BGFindDogVc
{
    BOOL isShowOwner;//是否显示主人
    UIButton * rightBtn;
//    GCDSocketManager *socketManager;

}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"找狗";
    self.mapView = [[BMKMapView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height)];
    self.mapView.userTrackingMode = BMKUserTrackingModeFollow;;//设置定位的状态（跟随模式）
    self.mapView.showsUserLocation = YES;//显示定位图层
    self.mapView.zoomLevel = 16;
    [self.view addSubview:self.mapView];
    [self startLocation];
    isShowOwner = YES;
    _pointannotation = [[CustomAnnotation alloc] init];
    _ownerannotation = [[CustomAnnotation alloc]init];
    _pointannotation.type = CREMATORY;
    _ownerannotation.type = SUPER_MARKET;    
    rightBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 50, 30)];
    [rightBtn setTitle: @"设置" forState:UIControlStateNormal];
    [rightBtn addTarget:self  action:@selector(showAlertController) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * myButton = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
    rightBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [rightBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    self.navigationItem.rightBarButtonItem = myButton;
    [self.navigationController.navigationBar setTintColor:[UIColor blackColor]];
    
//    socketManager = [GCDSocketManager sharedSocketManager];
//    NSString *token = [[NSUserDefaults standardUserDefaults] objectForKey:@"token"];
//    NSString *deviceId = [[NSUserDefaults standardUserDefaults] objectForKey:@"deviceId"];
//    [socketManager connectToServer:deviceId AndClientId:token];

}

- (void)showAlertController{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UINavigationController *deviceVc = [storyboard instantiateViewControllerWithIdentifier:@"BGMapSettingVc"];
    [self.navigationController pushViewController:deviceVc animated:YES];
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
        [self.mapView setCenterCoordinate:userLocation.location.coordinate];
    }
    _ownerannotation.coordinate = userLocation.location.coordinate;
//    isShowOwner = NO;
}



- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.mapView viewWillAppear];
    self.mapView.delegate = self;
 

}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.mapView.delegate = nil;

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
@end
