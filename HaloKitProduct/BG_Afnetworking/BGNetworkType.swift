//
//  BGNetworkType.swift
//  HaloKitProduct
//
//  Created by 范博 on 2017/6/28.
//  Copyright © 2017年 范博. All rights reserved.
//

import UIKit


struct BGEnviroment {
    let requestUrl     : String
    let imageUrl       : String
    let uploadImageUrl : String
    // 当前环境
    static var Current: BGEnviroment{
        return .deBug
    }
    
    // 测试环境
    static let deBug: BGEnviroment = {//  http://api.halokit.cn:7070/halokit/v2/user/devicelist
        return BGEnviroment(requestUrl: " http://api.halokit.cn:7070/halokit/v2/",
                             imageUrl: "http://",
                             uploadImageUrl: "http://")
    } ()
    
    // 生产环境
    static let Beta: BGEnviroment = {
        return BGEnviroment(requestUrl: " http://api.halokit.cn:7070/halokit/v2/",
                             imageUrl: "https://",
                             uploadImageUrl: "https://")
    } ()
    
}

//方法域
struct BGRequestFunction {
//    static let login =
}

protocol BGRequestFunctionType {
    
    var base: String { get }
    
    var domain: String { get }
    var function: String { get }
    
    var urlString: String { get }
    
}

extension BGRequestFunctionType {
    
    var base: String {
        return BGEnviroment.Current.requestUrl
    }
    
    var urlString: String {
        return "\(self.base)/\(self.domain)/\(self.function)"
    }
    
}

struct BGRequestDomainLogType: BGRequestFunctionType {
    
    private(set) var domain = "Logs"
    private(set) var function: String
    
    
    static let LogsList: BGRequestDomainLogType = {
        return BGRequestDomainLogType(function: " LogsList ")
    } ()
    
    
    init(function: String) {
        self.function = function
    }
    
}
