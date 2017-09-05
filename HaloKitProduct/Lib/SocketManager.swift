//
//  SocketManager.swift
//  HaloKitProduct
//
//  Created by zhou zhiling on 2017/6/29.
//  Copyright © 2017年 范博. All rights reserved.
//


import UIKit
import CocoaAsyncSocket


let heartBeatTimeinterval = 40 // 发送心跳时间间隔
let kMaxReconnection_time = 6  // 重链接次数
let beatLimit = 5  // 心跳回调最大限度
let timeOut = 10

let kConnectorHost = "api.halokit.cn"
let kConnectorPort = 6060





enum SocketRequestType:Int {
    case CmdTypeNone = 0 // 未登录
    case CmdTypeConnectRequest = 1 // 连接请求
    case CmdTypeConnectSuccessBack = 2 // 连接请求 正确 回调
    case CmdTypeHeartBeatRequest   = 3 // 心跳请求][i6
    case CmdTypeHeartBeatSuccessBack     = 4 // 心跳请求 正确 回调
    case CmdTypeLocFuncRequest   = 5  //功能本地调用(相对于 7)
    case CmdTypeLocFuncSuccessBack      = 6 // 功能本地调用 正确 回调
    case CmdTypeLongDistanceFuncRequest  = 7 // 功能远程调用
    case CmdTypeLongDistanceFuncBack = 8 // 功能远程调用 正确 回调
    case CmdTypeEnterBackgroundRequest   = 9 // APP切到后台
    case CmdTypeNotify       = 10 // 消息更新提示
    case CmdTypeMessage      = 11 // 推送更新内容
    case CmdTypeSystemActionRequest = 12 // 系统操作消息
    case CmdTypeActionBack   = 13 // 系统操作确认
}




public protocol SocketManagerDelegate  {
    func reconnectionSuccess()
    func didReadData(data: Data, tag: Int)
}

typealias reconnetCompletionHandle = (Bool) ->()



class SocketManager:NSObject,GCDAsyncSocketDelegate{
   
    open var delegate: SocketManagerDelegate?
    
    var reconncetStatusHandle : reconnetCompletionHandle?
    
    static let instance = SocketManager()
    
    var connectStatus = 0 //connect status：1 connect，-1  disconnect，0 connecting
    var reconnectionCount = 0
    
    var beatTimer:Timer!
    var reconnectTimer:Timer!
    
    var clientSocket:GCDAsyncSocket!

    
    var agent: String?
    

    override init() {
       super.init()
        
        clientSocket = GCDAsyncSocket()
        clientSocket.delegate = self
        clientSocket.delegateQueue = DispatchQueue.main
        creatSocketToConnectServer()
        
       
    }
    
    
    
     /**
     用户主动重新连接
     */
    public func getReconncetHandle(handle: @escaping reconnetCompletionHandle)  {
        self.reconncetStatusHandle = handle
        reconnection()
    }
    
    
    
    
   
    
    
}


extension SocketManager{
     /**
     创建长连接
     */

	func creatSocketToConnectServer() -> Void {
        do {
            connectStatus = 0
            try  clientSocket.connect(toHost: kConnectorHost, onPort: UInt16(kConnectorPort), withTimeout: TimeInterval(timeOut))
        } catch {
            print("conncet error")
        }
    }


        

    
    
    /**
     长连接建立后 开始与服务器校验登录
     */
    func socketDidConnectCreatLogin() -> Void {
        
        let params = [
            "clientID" : "7bd0e060da44b6bd51def4fed73831a9" ,
            "deviceid" : "861933030028500",
            "func":"00"
        ];
        
        
        ///let login = ["c":"1","p":"ca5542d60da951afeb3a8bc5152211a7","d":"dev_"]
        socketWriteDataToServer(body: params)
        reconnectionCount = 0
        connectStatus = 1
        reconncetStatusHandle?(true)
        delegate?.reconnectionSuccess()
        guard let timer = self.reconnectTimer else {
            return
        }
        timer.invalidate()
    }
    
    /**
     长连接建立后 开始发送心跳包
     */
    func socketDidConnectBeginSendBeat() -> Void {
        beatTimer = Timer.scheduledTimer(timeInterval: TimeInterval(heartBeatTimeinterval),
                                         target: self,
                                         selector: #selector(sendBeat),
                                         userInfo: nil,
                                         repeats: true)
        RunLoop.current.add(beatTimer, forMode: RunLoopMode.commonModes)
        
    }
    
    
    
    /**
     向服务器发送心跳包
     */
    func sendBeat() {
        let beat = ["c":"3"]
        socketWriteDataToServer(body:beat)
    }
    
    /**
     向服务器发送数据
     */
    func socketWriteDataToServer(body: Dictionary<String, Any>) {
        // 1: do   2: try?    3: try!
        guard let data:Data = try? Data(JSONSerialization.data(withJSONObject: body,
                                                               options: JSONSerialization.WritingOptions(rawValue: 1)))
            else {
                    return
        }
        print(body)
        clientSocket.write(data, withTimeout: -1, tag: 0)
        clientSocket.readData(to: GCDAsyncSocket.crlfData(), withTimeout: -1, tag: 0)
    }
    
    
     /**
     接收到服务器的数据
     */
    func socketDidReadData(data:Data, tag:Int) -> Void {
        let readClientDataString: NSString? = NSString(data: data as Data, encoding: String.Encoding.utf8.rawValue)
        
        print(readClientDataString!)

        
        
        delegate?.didReadData(data: data, tag: tag)
    }
    
    /**
     重新连接操作
     */
    func socketDidDisconectBeginSendReconnect() -> Void {
        
        connectStatus = -1
        
        if reconnectionCount >= 0 && reconnectionCount < beatLimit  {
            reconnectionCount = reconnectionCount + 1
            timerInvalidate(timer: reconnectTimer)
            let time:TimeInterval = pow(2, Double(reconnectionCount))
            
            reconnectTimer = Timer.scheduledTimer(timeInterval: time,
                                                  target: self,
                                                  selector: #selector(reconnection),
                                                  userInfo: nil,
                                                  repeats: true)
            RunLoop.current.add(reconnectTimer, forMode: RunLoopMode.commonModes)
            
        } else {
            reconnectionCount = -1
            reconncetStatusHandle?(false)
            
            timerInvalidate(timer: reconnectTimer)
        }
    }
    /**
     重新连接 在网络状态不佳或者断网情况下把具体情况抛出去处理
     */
    func reconnection() -> Void {
        
        /**
         在瞬间切换到后台再切回程序时状态某些时候不改变
         但是未连接，所以添加一个重新连接时先断开连接
         */
        if connectStatus != -1 {
            clientSocket.disconnect()
        }
        
        // 重新初始化连接
        creatSocketToConnectServer()
    }
    
    func timerInvalidate(timer: Timer!) -> Void {
        guard let inTimer = timer else {
            return
        }
        inTimer.invalidate()
    }
}


/**
 socket delegate
 */
 extension SocketManager {

	/**
     与服务器建立连接后根据业务需求发送登录请求、心跳包
     */

     func socket(_ sock: GCDAsyncSocket, didConnectToHost host: String, port: UInt16) -> Void {
        //print("Successful")
        clientSocket.readData(withTimeout: -1, tag: 0)
        socketDidConnectCreatLogin()
        //socketDidConnectBeginSendBeat()
    }

    /**
     服务器接收到数据 -->> 接收到数据后抛出去
     */
    func socket(_ sock: GCDAsyncSocket, didRead data: Data, withTag tag: Int) -> Void {
        
         clientSocket.write(data, withTimeout: -1, tag: 0)
         clientSocket.readData(to: GCDAsyncSocket.crlfData(), withTimeout: -1, tag: 0)
         socketDidReadData(data: data, tag: tag)
    }

    func socket(_ sock: GCDAsyncSocket, didWriteDataWithTag tag: Int) -> Void {
        clientSocket.readData(to: GCDAsyncSocket.crlfData(), withTimeout: -1, tag: 0)
        
    }

    /**
     断开连接
     */
    func socketDidDisconnect(_ sock: GCDAsyncSocket, withError err: Error?) -> Void {
    	print("断开连接")
        socketDidDisconectBeginSendReconnect()
    }



 }







