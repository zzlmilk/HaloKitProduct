//
//  ViewController.swift
//  HaloKitProduct
//
//  Created by 范博 on 2017/6/28.
//  Copyright © 2017年 范博. All rights reserved.
//


import UIKit

//class BoGeStoryBoardSupport: NSObject {
//
//}

protocol BoGeStoryboardProtocol{

    //到达这个 VC Identifier
    static var SegueName: String {get}
    //到达这个 VC Identifier
    static var SceneName: String {get}
    
}

extension BoGeStoryboardProtocol{

    static var BaseStoryBoardId:String{
        return "com.halokitglobal.developer.HaloKitProduct"
    }
    
    static var StoryBoardSegueId:String{
    
        debugPrint("\(self.BaseStoryBoardId + "." + self.SegueName)")
        return self.BaseStoryBoardId + "." + self.SegueName
    }
    
    static var StoryBoardSceneId:String{
        debugPrint("\(self.BaseStoryBoardId + "." + self.SceneName)")
        return self.BaseStoryBoardId + "." + self.SceneName
    }
}


enum BoGeStoryboardIdentifier:String {
    case BoGeMain = "BoGeMain"
}

class BoGeStoryboard {
    private var needNew = false
    var new: BoGeStoryboard{
        needNew = true
        return self
    }
    
    
    static let shareSB:BoGeStoryboard = {
        return BoGeStoryboard()
    }()
    
    subscript(key:String) -> UIStoryboard?{
    
        if let identifier = BoGeStoryboardIdentifier(rawValue: key){
        
            return self[identifier.rawValue]
        }else{
            return nil
        }
    }
    
    subscript(key:BoGeStoryboardIdentifier) -> UIStoryboard{
    
        get{
            return newSB(forKey: key)
        }
        
        set{
        
        }
    }
    
    private func newSB(forKey key: BoGeStoryboardIdentifier) -> UIStoryboard{
    
        let sb = UIStoryboard(name:key.rawValue, bundle:nil)
        return sb
    }
    
    func clear(key: BoGeStoryboardIdentifier) -> UIStoryboard? {
        return self.clear(key: key.rawValue)
        
    }
    
    func clear(key: String) -> UIStoryboard? {
        return nil
    }
    
    func clearAll() -> [UIStoryboard] {
        
        return self.clear(keys:.BoGeMain)
        
    }
    
    func clear(keys: BoGeStoryboardIdentifier ...) -> [UIStoryboard] {
        
        var sbs = [UIStoryboard]()
        
        for key in keys {
            if let sb = self.clear(key: key.rawValue) {
                sbs.append(sb)
            }
        }
        
        return sbs
        
    }
}




