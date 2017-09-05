
//
//  UserViewController.swift
//  HaloKitProduct
//
//  Created by zhou zhiling on 2017/6/29.
//  Copyright © 2017年 范博. All rights reserved.
//

import UIKit

class UserViewController: UIViewController {


    override func viewDidLoad() {
        super.viewDidLoad()
        

        let socketManager = SocketManager.init();
        //socketManager.creatSocketToConnectServer();
        //print(socketManager.log())

        
        
        
        

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}


extension UserViewController:SocketManagerDelegate{
    /**
     重连成功 请求队列重新处理
     */
    func reconnectionSuccess() {
            print("重连成功")
    }
    
      func didReadData(data: Data, tag: Int) {
         print("didReadData")
        
    }
}
