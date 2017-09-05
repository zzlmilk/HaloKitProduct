//
//  BGCityModel.swift
//  HaloKitProduct
//
//  Created by 范博 on 2017/7/6.
//  Copyright © 2017年 范博. All rights reserved.
//

import UIKit
import SwiftyJSON


struct BGCityGroupModel {
    var groupName : String!
    var arrayCitys : [BGCityModel]!
    init(fromJson dict: [String:AnyObject]){
        if dict.isEmpty{
            return
        }
        arrayCitys = [BGCityModel]()
        groupName = dict["initial"] as! String
        let listArray = dict["citys"] as! [[String:String]]
        for listDict in listArray{
            let value = BGCityModel(fromJson: listDict)
            arrayCitys.append(value)
        }
    }
    
    static func getModelFunction() -> ([BGCityGroupModel],[String]){
        let array = NSArray(contentsOfFile: Bundle.main.path(forResource: "DoctorList.plist", ofType: nil)!)!
        var dataArray = [BGCityGroupModel]()
        var dataNames = [String]()
        dataArray.removeAll()
        dataNames.removeAll()
        for GroupDic in array {
            let doctor = BGCityGroupModel(fromJson:GroupDic as! [String : AnyObject])
            dataNames.append(doctor.groupName)
            dataArray.append(doctor)
        }
        return (dataArray, dataNames)
    }
}


struct BGCityModel {
    var cityID : String!
    var cityName : String!
    var shortName:String!
    var pinyin : String!
    var initials : String!
    init (){}
    init(fromJson dict:[String:String]){
        if dict.isEmpty{
            return
        }
        cityID = dict["city_key"]
        cityName = dict["city_name"]
        shortName = dict["short_name"]
        pinyin = dict["pinyin"]
        initials = dict["initials"]
    }
}



