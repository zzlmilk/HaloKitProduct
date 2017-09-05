//
//  BGPhoneLoginVC.swift
//  HaloKitProduct
//
//  Created by 范博 on 2017/7/4.
//  Copyright © 2017年 范博. All rights reserved.
//

import UIKit

class BGPhoneLoginVC: UIViewController {

    fileprivate lazy var phoneLabel:UITextField = {
        let phoneLabel = UITextField.init()
        phoneLabel.text = "手机号"
        phoneLabel.textAlignment = .left
        phoneLabel.font = UIFont.systemFont(ofSize: 15)
        return phoneLabel
    }()
    
    
    
    fileprivate lazy var secLabel:UITextField = {
        let phoneLabel = UITextField.init()
        phoneLabel.text = "密码"
        phoneLabel.textAlignment = .left
        phoneLabel.font = UIFont.systemFont(ofSize: 15)
        return phoneLabel
    }()
    
    fileprivate lazy var forgetSecBtn:UIButton = {
        let submitBtn = UIButton.init()
        submitBtn.setTitle("忘记密码", for: .normal)
        submitBtn.setTitleColor(UIColor.black, for: .normal)
        submitBtn.addTarget(self, action: #selector(BGPhoneLoginVC.foregetFaction), for: .touchUpInside)
        return submitBtn
    }()
    
    fileprivate lazy var loginBtn:UIButton = {
        let submitBtn = UIButton.init()
        submitBtn.setTitle("登录", for: .normal)
        submitBtn.setTitleColor(UIColor.black, for: .normal)
        submitBtn.titleLabel?.textAlignment = .center
        submitBtn.addTarget(self, action: #selector(BGPhoneLoginVC.loginFaction), for: .touchUpInside)
        return submitBtn
    }()
    
    
    fileprivate lazy var navBackBtn:UIButton = {
        let loginView = LoginView.init(descriptionStr: nil) {
            self.navigationController?.popViewController(animated: true)
        }
        var btn = loginView.navBackBtn
        return btn
    }()
    
    
    class func initVC(param:String? = nil) -> BGPhoneLoginVC{
        return BGPhoneLoginVC.init(param: param)
        
    }
    
    
    init(param: String?) {
        super.init(nibName: nil, bundle: nil)
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    class func push(_ parentVC:UIViewController?, param:String? = nil, param1:String?) {
        let vc = BGPhoneLoginVC.initVC(param:param)
        parentVC?.navigationController?.pushViewController(vc, animated: true)
    }
    

    
    override func viewDidLayoutSubviews() {
        super .viewDidLayoutSubviews()
        
        navBackBtn.snp.makeConstraints { (make) -> Void in
            make.left.equalTo(16)
            make.top.equalTo(10)
            make.width.equalTo(20)
            make.height.equalTo(44)
        }

        
        
        phoneLabel.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(74)
            make.left.equalTo(16)
            make.right.equalTo(16)
            make.height.equalTo(44)
        }

        secLabel.snp.makeConstraints { (make) -> Void in
            make.left.equalTo(16)
            make.top.equalTo(phoneLabel.snp.bottom).offset(10)
            make.right.equalTo(16)
            make.height.equalTo(80)
        }
        
        forgetSecBtn.snp.makeConstraints { (make) -> Void in
            make.right.equalTo(16)
            make.top.equalTo(secLabel.snp.bottom).offset(10)
            make.width.equalTo(150)
            make.height.equalTo(44)
        }

        loginBtn.snp.makeConstraints { (make) -> Void in
            make.center.equalTo(self.view.snp.center)
            make.width.equalTo(SCREENW/2)
            make.height.equalTo(44)
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(navBackBtn)
        self.view.addSubview(phoneLabel)
        self.view.addSubview(secLabel)
        self.view.addSubview(forgetSecBtn)
        self.view.addSubview(loginBtn)


    }
    
    func foregetFaction(){
    
    }
    
    func loginFaction(){
    
    }
 

}
