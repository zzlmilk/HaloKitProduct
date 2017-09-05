//
//  BGDefaultBridge.swift
//  HaloKitProduct
//
//  Created by 范博 on 2017/6/28.
//  Copyright © 2017年 范博. All rights reserved.
//

import UIKit
import AFNetworking

protocol RBNetworkBridgeType {
    
    static func instance() -> RBNetworkBridgeType
    
    // Request Setting
    func setValue(value: String?, forHTTPHeaderField header: String)
    
    // POST 的形式进行请求
    func request_post(path: String, params: [String: AnyObject]?, completion: ((URLResponse, AnyObject?, Error?) -> Void)?)
    
    // GET 的形式进行请求
    func request_get(path: String, params: [String: AnyObject]?, completion: ((URLResponse, AnyObject?, Error?) -> Void)?)

    // 上传进行请求
    func upload(path: String, params: [String: AnyObject]?, progress uploadProgressBlock: ((Progress) -> Void)?, completion: ((URLResponse, AnyObject?, Error?) -> Void)?)
    
    // 下载进行请求
    func download(path: String, progress downloadProgressBlock: ((Progress) -> Void)?, destination: ((URL, URLResponse) -> URL)?, completion: ((URLResponse, URL?, Error?) -> Void)?)
    
    func downloadResume(resumeData: NSData, progress downloadProgressBlock: ((Progress) -> Void)?, destination: ((URL, URLResponse) -> URL)?, completion: ((URLResponse, URL?, Error?) -> Void)?)
    
}

protocol RBErrorTypeDescription {
    
    var errorDescription: String { get }
    
}


// 请求发送之前核查错误
enum RBNetworkRequestErrorType: Int, RBErrorTypeDescription {
    
    case UnknowError    = -999          // 未知错误
    case NetworkError   = 404           // 网络错误
    case ParamsError    = 9000          // 请求参数错误
    case ResponseError  = 9001          // 返回内容不正确(即后台返回数据与约定不匹配)
    
    var errorDescription: String {
        switch self {
        case .UnknowError:
            return "未知错误"
        case .NetworkError:
            return "网络错误"
        case .ParamsError:
            return "参数错误"
        case .ResponseError:
            return "返回值不正确"
        }
    }
    
}



let RBTimeoutInterval: TimeInterval = 15

class RBDefaultBridge: RBNetworkBridgeType {


    static func instance() -> RBNetworkBridgeType {
        return RBDefaultBridge()
    }
    
    lazy private var session: AFHTTPSessionManager = AFHTTPSessionManager()
    
    lazy private var HTTPHeaderFiled = [String: String]()
    func setValue(value: String?, forHTTPHeaderField header: String) {
        self.HTTPHeaderFiled[header] = value
    }
    
    init() {
        //BOOL enabled 是否开启？ 默认是不开启的
        AFNetworkActivityIndicatorManager.shared().isEnabled = true
        
        AFNetworkReachabilityManager.shared().startMonitoring()
        AFNetworkReachabilityManager.shared().setReachabilityStatusChange { (status) in
            print("Network Status Change: \(status,status.rawValue)")
            switch status {
            case .reachableViaWWAN:
                self.session = AFHTTPSessionManager()
                break
            case .reachableViaWiFi:
                self.session = AFHTTPSessionManager()
                break
                
            default:
                break
            }
        }
    }
    
    /**
     向指定URL发送GET请求
     
     - parameter path:       URL 地址
     * -see: struct RBRequestFunction
     - parameter params:     GET 参数
     - parameter completion: 完成回调
     */
    func request_get(path: String, params: [String : AnyObject]?, completion: ((URLResponse, AnyObject?, Error?) -> Void)?) {
        let urlString = path
        guard let url = NSURL(string: urlString) else {
            let error = NSError(domain: path, code: RBNetworkRequestErrorType.ParamsError.rawValue, userInfo: [NSLocalizedDescriptionKey: "url: \(urlString)\n请求地址错误"])
            completion?(URLResponse(), nil, error)
            return
        }
        
        let request = NSMutableURLRequest(url: url as URL)
        request.timeoutInterval = RBTimeoutInterval
        request.httpMethod = "GET"
        for (key, value) in self.HTTPHeaderFiled {
            request.setValue(value, forHTTPHeaderField: key)
        }
        
        if let parameters = params {
            let serializerStr = AFQueryStringFromParameters(parameters)
            let HTTPBody = serializerStr.data(using: String.Encoding.utf8)
            request.httpBody = HTTPBody
        }
        let task = self.session.dataTask(with: request as URLRequest, completionHandler: completion as? (URLResponse, Any?, Error?) -> Void)
        task.resume()

    }

    /**
     向指定URL发送POST请求
     
     - parameter path:       URL 地址
     * -see: struct RBRequestFunction
     - parameter params:     POST 参数
     - parameter completion: 完成回调
     */

    func request_post(path: String, params: [String : AnyObject]?, completion: ((URLResponse, AnyObject?, Error?) -> Void)?) {
        let urlString = path
        guard let url = NSURL(string: urlString) else {
            let error = NSError(domain: path, code: RBNetworkRequestErrorType.ParamsError.rawValue, userInfo: [NSLocalizedDescriptionKey: "url: \(urlString)\n请求地址错误"])
            completion?(URLResponse(), nil, error)
            return
        }
        
        let request = NSMutableURLRequest(url: url as URL)
        request.timeoutInterval = RBTimeoutInterval
        request.httpMethod = "POST"
        for (key, value) in self.HTTPHeaderFiled {
            request.setValue(value, forHTTPHeaderField: key)
        }
        
        if let parameters = params {
            let serializerStr = AFQueryStringFromParameters(parameters)
            let HTTPBody = serializerStr.data(using: String.Encoding.utf8)
            request.httpBody = HTTPBody
        }
        let task = self.session.dataTask(with: request as URLRequest, completionHandler: completion as? (URLResponse, Any?, Error?) -> Void)
        task.resume()

    }
    
    /**
     向指定URL上传文件
     
     - parameter path:                指定URL
     * -see: struct RBRequestFunction
     - parameter data:                上传文件数据
     - parameter uploadProgressBlock: Progress Handler
     - parameter completion:          完成回调
     */
    func upload(path: String, params: [String: AnyObject]?, progress uploadProgressBlock: ((Progress) -> Void)?, completion: ((URLResponse, AnyObject?, Error?) -> Void)?) {
        
        let parameters = params
        let request = AFHTTPRequestSerializer().multipartFormRequest(withMethod: "GET", urlString: path, parameters: parameters, constructingBodyWith:nil, error: nil)
        request.timeoutInterval = RBTimeoutInterval
        for (key, value) in self.HTTPHeaderFiled {
            
            request.setValue(value, forHTTPHeaderField: key)
            
        }
        let task = self.session.uploadTask(withStreamedRequest: request as URLRequest, progress: uploadProgressBlock, completionHandler: completion as? (URLResponse, Any?, Error?) -> Void)
        task.resume()
    }
    
    func downloadResume(resumeData: NSData, progress downloadProgressBlock: ((Progress) -> Void)?, destination: ((URL, URLResponse) -> URL)?, completion: ((URLResponse, URL?, Error?) -> Void)?) {
        let downloader = self.session.downloadTask(withResumeData: resumeData as Data, progress: downloadProgressBlock, destination: destination, completionHandler: completion)
        downloader.resume()

    }
    
    func download(path: String, progress downloadProgressBlock: ((Progress) -> Void)?, destination: ((URL, URLResponse) -> URL)?, completion: ((URLResponse, URL?, Error?) -> Void)?) {
        let urlString = path
        guard let url = NSURL(string: urlString) else {
            let error = NSError(domain: path, code: RBNetworkRequestErrorType.ParamsError.rawValue, userInfo: [NSLocalizedDescriptionKey: "url: \(urlString)\n请求地址错误"])
            completion?(URLResponse(), nil, error)
            return
        }
        let request = NSMutableURLRequest(url: url as URL)
        request.timeoutInterval = RBTimeoutInterval
        for (key, value) in self.HTTPHeaderFiled {
            request.setValue(value, forHTTPHeaderField: key)
        }
        let downloader = self.session.downloadTask(with: request as URLRequest, progress: downloadProgressBlock, destination: destination, completionHandler: completion)
        downloader.resume()

    }

    


    
}
