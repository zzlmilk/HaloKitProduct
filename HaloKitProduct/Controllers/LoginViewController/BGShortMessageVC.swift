//
//  ShortMessageVC.swift
//  HaloKitProduct
//
//  Created by 范博 on 2017/7/4.
//  Copyright © 2017年 范博. All rights reserved.
//

import UIKit




class BGShortMessageVC: UIViewController {
    var loginView = LoginView.newView(descriptionStr: nil, finishBlock: nil)
    let margin = 16
    let sercetSpace = (SCREENW - 16 * 2 - BGW * 30)/6.0
    
    
    fileprivate lazy var navBackBtn:UIButton = {
        self.loginView.finished = {
            self.navigationController?.popViewController(animated: true)
        }
        var btn = self.loginView.navBackBtn
        return btn
        
    }()
    
    fileprivate lazy var phoneLabel:UILabel = {
        self.loginView.finished = nil
        self.loginView.descriptionStr = "输入手机号"
        var phoneLabel = self.loginView.titleLabel
        return phoneLabel
    }()
    
    
    fileprivate lazy var phoneDescLabel:UILabel = {
        self.loginView.finished = nil
        self.loginView.descriptionStr = "我们已给手机号码 15251531328 发送了一个6位数验证码。"
        var phoneLabel = self.loginView.titleDescLabel
        return phoneLabel
    }()
    
    fileprivate lazy var sercInputfir:UITextField = {
        self.loginView.finished = nil
        var sercInputfir = self.loginView.secreTextField
        return sercInputfir
    }()
    
    fileprivate lazy var sercInputSec:UITextField = {
        self.loginView.finished = nil
        var sercInputfir = self.loginView.secreTextField
        return sercInputfir
    }()

    fileprivate lazy var sercInputTre:UITextField = {
        self.loginView.finished = nil
        var sercInputfir = self.loginView.secreTextField
        return sercInputfir
    }()
    
    fileprivate lazy var sercInputTir:UITextField = {
        self.loginView.finished = nil
        var sercInputfir = self.loginView.secreTextField
        return sercInputfir
    }()
    
    fileprivate lazy var sercInputFiv:UITextField = {
        self.loginView.finished = nil
        var sercInputfir = self.loginView.secreTextField
        return sercInputfir
    }()
    
    fileprivate lazy var sercInputSix:UITextField = {
        self.loginView.finished = nil
        var sercInputfir = self.loginView.secreTextField
        return sercInputfir
    }()
    
    fileprivate lazy var textLabel:UILabel = {
        self.loginView.finished = nil
        self.loginView.descriptionStr = "90s后 重新发送信息"
        var phoneLabel = self.loginView.titleLabel
        return phoneLabel
    }()


    class func initVC(param:String? = nil) -> BGShortMessageVC{
        return BGShortMessageVC.init(param: param)
    }
    
    
    init(param: String?) {
        super.init(nibName: nil, bundle: nil)
        
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    class func push(_ parentVC:UIViewController?, param:String? = nil, param1:String?) {
        let vc = BGShortMessageVC.initVC(param:param)
        parentVC?.navigationController?.pushViewController(vc, animated: true)
    }


    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(navBackBtn)
        self.view.addSubview(phoneLabel)
        self.view.addSubview(phoneDescLabel)
        
        self.view.addSubview(sercInputfir)
        self.view.addSubview(sercInputSec)
        self.view.addSubview(sercInputTre)
        self.view.addSubview(sercInputTir)
        self.view.addSubview(sercInputFiv)
        self.view.addSubview(sercInputSix)
        self.view.addSubview(textLabel)

    }
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        navBackBtn.snp.makeConstraints { (make) -> Void in
            make.left.equalTo(16)
            make.top.equalTo(10)
            make.width.equalTo(20)
            make.height.equalTo(44)
        }
        
        phoneLabel.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(74)
            make.left.equalTo(16)
            make.right.equalTo(-16)
            make.height.equalTo(44)
        }
        
        phoneDescLabel.snp.makeConstraints { (make) -> Void in
            make.left.equalTo(16)
            make.top.equalTo(phoneLabel.snp.bottom).offset(10)
            make.right.equalTo(-16)
            make.height.equalTo(44)
            
        }
        
        sercInputfir.snp.makeConstraints { (make) -> Void in
            make.left.equalTo(margin)
            make.top.equalTo(phoneDescLabel.snp.bottom).offset(10)
            make.width.equalTo(BGW * 30)
            make.height.equalTo(44)
        }
        
        sercInputSec.snp.makeConstraints { (make) -> Void in
            make.left.equalTo(sercInputfir.snp.right).offset(sercetSpace)
            make.top.equalTo(phoneDescLabel.snp.bottom).offset(10)
            make.width.equalTo(BGW * 30)
            make.height.equalTo(44)
        }
        
        sercInputTre.snp.makeConstraints { (make) -> Void in
            make.left.equalTo(sercInputSec.snp.right).offset(sercetSpace)
            make.top.equalTo(phoneDescLabel.snp.bottom).offset(10)
            make.width.equalTo(BGW * 30)
            make.height.equalTo(44)
        }

        
        sercInputTir.snp.makeConstraints { (make) -> Void in
            make.left.equalTo(sercInputTre.snp.right).offset(sercetSpace)
            make.top.equalTo(phoneDescLabel.snp.bottom).offset(10)
            make.width.equalTo(BGW * 30)
            make.height.equalTo(44)
        }
        
        sercInputFiv.snp.makeConstraints { (make) -> Void in
            make.left.equalTo(sercInputTir.snp.right).offset(sercetSpace)
            make.top.equalTo(phoneDescLabel.snp.bottom).offset(10)
            make.width.equalTo(BGW * 30)
            make.height.equalTo(44)
        }
        
        sercInputSix.snp.makeConstraints { (make) -> Void in
            make.left.equalTo(sercInputFiv.snp.right).offset(sercetSpace)
            make.top.equalTo(phoneDescLabel.snp.bottom).offset(10)
            make.width.equalTo(BGW * 30)
            make.height.equalTo(44)
        }


        textLabel.snp.makeConstraints { (make) -> Void in
            make.left.equalTo(16)
            make.top.equalTo(sercInputFiv.snp.bottom).offset(10)
            make.width.equalTo(BGW * 300)
            make.height.equalTo(44)

        }
        
        
    }


    
}
