//
//  BGSetsecertLabel.swift
//  HaloKitProduct
//
//  Created by 范博 on 2017/7/4.
//  Copyright © 2017年 范博. All rights reserved.
//

import UIKit

class BGSetsecertVC: UIViewController {
    
    var loginView = LoginView.newView(descriptionStr: nil, finishBlock: nil)
    
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
        self.loginView.descriptionStr = "我们将发送验证码到您的手机"
        var phoneLabel = self.loginView.titleDescLabel
        return phoneLabel
    }()
    
    
    fileprivate lazy var phoneInput:UITextField = {
        self.loginView.finished = nil
        self.loginView.descriptionStr = "手机号"
        var phoneInput = self.loginView.inputTextField
        return phoneInput
    }()
    
    
    fileprivate lazy var descLabel:UILabel = {
        let descLabel = UILabel.init()
        descLabel.textAlignment = .left
        descLabel.text = "注册即视为您阅读并同意了《可点服务协议》"
        descLabel.font = UIFont.systemFont(ofSize: 12)
        return descLabel
    }()
    
    
    fileprivate lazy var registBtn:UIButton = {
        self.loginView.finished = {
            print("注册傻逼，你咋不上天")
        }
        self.loginView.descriptionStr = "注册"
        var btn = self.loginView.submitBtn
        return btn
    }()
    
    
    class func initVC(param:String? = nil) -> BGSetsecertVC{
        return BGSetsecertVC.init(param: param)
        
    }
    
    
    init(param: String?) {
        super.init(nibName: nil, bundle: nil)
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    class func push(_ parentVC:UIViewController?, param:String? = nil, param1:String?) {
        let vc = BGSetsecertVC.initVC(param:param)
        parentVC?.navigationController?.pushViewController(vc, animated: true)
    }
    



    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(navBackBtn)
        self.view.addSubview(phoneLabel)
        self.view.addSubview(phoneDescLabel)
        self.view.addSubview(phoneInput)
        self.view.addSubview(descLabel)
        self.view.addSubview(registBtn)
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
        
        phoneInput.snp.makeConstraints { (make) -> Void in
            make.left.equalTo(16)
            make.top.equalTo(phoneDescLabel.snp.bottom).offset(10)
            make.right.equalTo(-16)
            make.height.equalTo(44)
            
        }
        
        descLabel.snp.makeConstraints { (make) -> Void in
            make.left.equalTo(16)
            make.top.equalTo(phoneInput.snp.bottom).offset(10)
            make.width.equalTo(250)
            make.height.equalTo(44)
            
        }

        
        registBtn.snp.makeConstraints { (make) -> Void in
            make.centerX.equalTo(self.view.center.x)
            make.top.equalTo(descLabel.snp.bottom).offset(10)
            make.width.equalTo(100)
            make.height.equalTo(30)
            
        }


    }
    
    

}
