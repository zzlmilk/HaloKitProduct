

import UIKit
import CocoaAsyncSocket


class SESocketManager:NSObject, GCDAsyncSocketDelegate  {

    static let instance = SESocketManager()
    
 	var clientSocket:GCDAsyncSocket!

    
    
	override init() {
        super.init()
        
                
        clientSocket = GCDAsyncSocket()
        clientSocket.delegate = self
        clientSocket.delegateQueue = DispatchQueue.main
        creatSocketToConnectServer()
        
    }

    func creatSocketToConnectServer() -> Void {
        do {
            print(kConnectorHost)
            try  clientSocket.connect(toHost: kConnectorHost, onPort: UInt16(kConnectorPort), withTimeout: TimeInterval(timeOut))
        } catch {
            print("conncet error")
        }
    }


    /**
     与服务器建立连接后根据业务需求发送登录请求、心跳包
     */
    func socket(_ sock: GCDAsyncSocket, didConnectToHost host: String, port: UInt16) -> Void {
        print("Successful")
    }
    
    
    func socket(_ sock: GCDAsyncSocket, didAcceptNewSocket newSocket: GCDAsyncSocket){
        
        print("1");
    }






}


