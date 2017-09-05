//
//  BGshouyeZiliaoVC.swift
//  HaloKitProduct
//
//  Created by 范博 on 2017/7/26.
//  Copyright © 2017年 范博. All rights reserved.
//

import UIKit

class BGshouyeZiliaoVC: UIViewController {
    
    lazy var headIcon:UIImageView = {
        let headIcon = UIImageView.init()
        headIcon.image = UIImage.init(named: "tabBar_1")
        return headIcon
    }()
    
    lazy var nakeNameFelid:UITextField = {
        let nakeNameFelid = UITextField.init()
        nakeNameFelid.placeholder = "您的昵称"
        nakeNameFelid.textAlignment = .center
        return nakeNameFelid
    }()
    
    lazy var line:UIView = {
        let line = UIView.init()
        line.backgroundColor = UIColor.black
        return line
    }()
    
    lazy var sexLabel:UILabel = {
        let sexLabel = UILabel.init()
        sexLabel.textColor = UIColor.black
        sexLabel.font = UIFont.systemFont(ofSize: 16)
        sexLabel.textAlignment = .center
        sexLabel.text = "请选择性别"
        return sexLabel
    }()
    
    lazy var sexManImgView:UIImageView = {
        let manImg = UIImageView.init()
        manImg.image = UIImage.init(named: "sex_man")
        return manImg
    }()
    
    lazy var sexWomanImgView:UIImageView = {
        let WomanImg = UIImageView.init()
        WomanImg.image = UIImage.init(named: "sex_woman")
        return WomanImg
    }()
    
    lazy var doneBtn:UIButton = {
        let doneBtn = UIButton.init()
        doneBtn.backgroundColor = UIColor.black
        doneBtn.setTitleColor(UIColor.white, for: .normal)
        doneBtn.setTitle("完成", for: .normal)
        doneBtn.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        doneBtn.layer.masksToBounds = true
        doneBtn.layer.cornerRadius = 2
        return doneBtn
    }()


    override func viewDidLoad() {
        super.viewDidLoad()
        self.createNav()
        self.view.addSubview(headIcon)
        self.view.addSubview(nakeNameFelid)
        self.view.addSubview(line)
        self.view.addSubview(sexLabel)
        self.view.addSubview(sexManImgView)
        self.view.addSubview(sexWomanImgView)
        self.view.addSubview(doneBtn)

    }
    
    func createNav() {
        let backItem = UIBarButtonItem.init(image: UIImage(named: "navBack"), style: .plain, target: self, action: #selector(backToPrevious))
        backItem.tintColor = UIColor.black
        self.title = "完善个人资料"
        self.navigationItem.leftBarButtonItem = backItem
//        let rightItem = UIBarButtonItem.init(title: "完成", style: UIBarButtonItemStyle.plain, target: self, action: #selector(finishEditedFunc))
//        self.navigationItem.rightBarButtonItem = rightItem
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        headIcon.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(56 * BGH)
            make.centerX.equalTo(self.view.center.x)
            make.height.width.equalTo(157)
            
        }
        
        nakeNameFelid.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(headIcon.snp.bottom).offset(20)
            make.centerX.equalTo(self.view.center.x)
            make.height.equalTo(14)
            make.width.equalTo(157)
        }
        
        line.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(nakeNameFelid.snp.bottom).offset(5)
            make.centerX.equalTo(self.view.center.x)
            make.height.equalTo(1)
            make.width.equalTo(157)
        }
        
        sexLabel.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(line.snp.bottom).offset(20)
            make.centerX.equalTo(self.view.center.x)
            make.height.equalTo(16)
            make.width.equalTo(157)
        }
        
        sexManImgView.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(sexLabel.snp.bottom).offset(20)
            make.right.equalTo(-self.view.center.x - 10)
            make.height.width.equalTo(25)
        }
        
        sexWomanImgView.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(sexLabel.snp.bottom).offset(20)
            make.left.equalTo(self.view.center.x + 10)
            make.height.width.equalTo(25)

        }
        
        doneBtn.snp.makeConstraints { (make) -> Void in
            make.left.equalTo(42)
            make.right.equalTo(-42)
            make.height.equalTo(40)
            make.bottom.equalTo(-188)
            make.centerX.equalTo(self.view.center.x)
        }

    }
    
    func backToPrevious(){
        self.navigationController?.popViewController(animated: true)
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
