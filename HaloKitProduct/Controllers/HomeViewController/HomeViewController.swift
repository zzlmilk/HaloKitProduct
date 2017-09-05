//
//  MainViewController.swift
//  HaloKitProduct
//
//  Created by zhou zhiling on 2017/6/29.
//  Copyright © 2017年 范博. All rights reserved.
//


import UIKit

import CocoaAsyncSocket



class HomeViewController: UIViewController,GCDAsyncSocketDelegate {
    
    override func loadView() {
        super.loadView()
        
    }
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
    
        
        let socketManager = SocketManager.instance
               
        print(socketManager)
        
        
        

//        var clientSocket:GCDAsyncSocket!
//        
//        clientSocket = GCDAsyncSocket()
//        clientSocket.delegate = self
//        clientSocket.delegateQueue = DispatchQueue.main
//        //creatSocketToConnectServer()
//        
//        do {
//            try clientSocket.connect(toHost: "api.halokit.cn", onPort: UInt16(3030))
//        } catch {
//            print("error")
//            
//            }
        
    

        
    }
    
    
    func socket(_ sock: GCDAsyncSocket, didConnectToHost host: String, port: UInt16) -> Void {
        print("连接成功")
       
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    


}
