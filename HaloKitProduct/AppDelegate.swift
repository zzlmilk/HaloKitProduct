//  AppDelegate.swift
//  HaloKitProduct
//
//  Created by 范博 on 2017/6/28.
//  Copyright © 2017年 范博. All rights reserved.
//

import UIKit
import UserNotifications

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate,UNUserNotificationCenterDelegate,GeTuiSdkDelegate {

    var window: UIWindow?
    static let kGtAppId     =  "yw6pQJJJ3t8iY5K4BQSKP2"
    static let kGtAppkey    =  "e3GTtzhDPWAvxQ53QpsSl1"
    static let kGtAppSecret = "O1WsRptOfZ70u5sE6GqV74"


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        
        
         self.window = UIWindow(frame: UIScreen.main.bounds)
         self.window?.backgroundColor = UIColor.white;
         self.window?.makeKeyAndVisible();
        
        
        
//         let main = FrameWorkViewController();
        
    
         self.window?.rootViewController = BGPersonalInfoVC.initVC();
        
        
        
        return true
    }

    
    
    func applicationWillResignActive(_ application: UIApplication) {

    }

    func applicationDidEnterBackground(_ application: UIApplication) {
    }

    func applicationWillEnterForeground(_ application: UIApplication) {

    }

    func applicationDidBecomeActive(_ application: UIApplication) {

    }

    func applicationWillTerminate(_ application: UIApplication) {
    }
}



extension AppDelegate {
    
    func registerGeTui(){
//        [GeTuiSdk startSdkWithAppId:kGtAppId appKey:kGtAppkey appSecret:kGtAppSecret delegate:self];
        self.registerUserNotification()
    }
    //注册远程通知
    func registerUserNotification(){
        
        if #available(iOS 10.0, *) {
            UIApplication.shared.registerForRemoteNotifications()
            let center = UNUserNotificationCenter.current()
            center.delegate = self //DID NOT WORK WHEN self WAS MyOtherDelegateClass()
            center.requestAuthorization(options: [.alert, .sound, .badge]) {
                (granted, error) in
                // Enable or disable features based on authorization.
                if granted {
                    // update application settings
                }
            }
        
        }else if #available(iOS 8.0, *) {
            
            let settings = UIUserNotificationSettings(types: [.alert, .badge, .sound], categories: nil)
            UIApplication.shared.registerUserNotificationSettings(settings)
            

        }else{
            let type = UIRemoteNotificationType.init(rawValue: 0 | 1 | 2)
            UIApplication.shared.registerForRemoteNotifications(matching: type)
        }
        
    }
    

    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        
        let nsdataStr = NSData.init(data: deviceToken)
        let datastr = nsdataStr.description.replacingOccurrences(of: "<", with: "").replacingOccurrences(of: ">", with: "").replacingOccurrences(of: " ", with: "")
        print("deviceToken:\(datastr)")
        // 向个推服务器注册deviceToken
        GeTuiSdk.registerDeviceToken(datastr)
    }
    
    func application(_ application: UIApplication, performFetchWithCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        GeTuiSdk.resume()
        completionHandler(UIBackgroundFetchResult.newData)

    }
    
    
    //统计APNs通知的点击数 ios 10 一下
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        GeTuiSdk.handleRemoteNotification(userInfo)
        completionHandler(UIBackgroundFetchResult.newData)


    }
    
    //统计APNs通知的点击数 ios 10 以上
    @available(iOS 10.0, *)
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        
    }
    
    @available(iOS 10.0, *)
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        GeTuiSdk.handleRemoteNotification(response.notification.request.content.userInfo)
        completionHandler();

    }
    
    
    func geTuiSdkDidRegisterClient(_ clientId: String!) {
        print(">>>[GeTuiSdk RegisterClient]:", clientId)
        
    }
    
    func geTuiSdkDidOccurError(_ error: Error!) {
        print(">>>[GexinSdk error]:",error.localizedDescription)
    }
    
    func geTuiSdkDidReceivePayloadData(_ payloadData: Data!, andTaskId taskId: String!, andMsgId msgId: String!, andOffLine offLine: Bool, fromGtAppId appId: String!) {
        var _:String? = nil
        guard let _ = payloadData else {
            return
        }
    
    }
    
}


