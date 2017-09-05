//
//  BGCodeInfoVC.swift
//  HaloKitProduct
//
//  Created by 范博 on 2017/7/9.
//  Copyright © 2017年 范博. All rights reserved.
//

import UIKit
import SwiftyJSON

enum BGSOURE {
    case edit
    case add
}

class BGCodeInfoVC: UIViewController,UITableViewDelegate, UITableViewDataSource {
    var source:BGSOURE = .add
    var codeStr:String = ""
    var token = ""
    let netWork:HttpRequest = HttpRequest.sharedInstance()
    var color = ""
    var lastOfflineTime = ""
    var boxid = ""
    var id = ""
    var btnFlag = true
    var tableView:UITableView!
    
    class func initVC(param:String, source:String,type:String? = nil) -> BGCodeInfoVC{
        if source == "2"{
            return BGCodeInfoVC.init(param: param, source:.edit, type: type)

        }else{
            return BGCodeInfoVC.init(param: param, source:.add, type: type)
        }

    }
    
    init(param: String, source:BGSOURE, type:String? = nil) {
        super.init(nibName: nil, bundle: nil)
        self.source = source
        token = UserDefaults.standard.object(forKey: "token") as! String
        codeStr = param
        if let _ = type {
            if type == "1" {
                btnFlag = false
                
            }else if type == "0"{
                btnFlag = false

            }else{
                btnFlag = true
            }
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    class func push(_ parentVC:UIViewController?, param:String, source:String, type:String? = nil) {
        let vc = BGCodeInfoVC.initVC(param:param, source:source,type: type)
        parentVC?.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    fileprivate lazy var sumbinButton:UIButton = {
        
        let sumbinButton = UIButton.init()
        sumbinButton.addTarget(self, action: #selector(nextStepFunction), for: UIControlEvents.touchUpInside)
        sumbinButton.setTitle("确认绑定", for: UIControlState.normal)
        sumbinButton.setTitleColor(UIColor.white, for: UIControlState.normal)
        sumbinButton.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        sumbinButton.backgroundColor = UIColor.black
        sumbinButton.layer.masksToBounds = true
        sumbinButton.layer.cornerRadius = 2
        return sumbinButton
        
    }()
    
    var nextStepFunct:(()->())?
    
    
    func nextStepFunction() {
        self.nextStepFunct?()
    }
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "项圈信息"
        tableView = UITableView.init(frame: CGRect(x:10 * BGW, y:10 * BGW, width:self.view.bounds.width - 20 * BGW, height:self.view.bounds.height - 109 * BGH - 64 * BGH - 35 * BGH ))
        self.view.backgroundColor = UIColor.init(red: 238/255.0, green: 239/255.0, blue: 240/255.0, alpha: 1.0)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.layer.masksToBounds = true
        tableView.layer.cornerRadius = 10
        tableView.separatorInset = UIEdgeInsetsMake(0,0, 0, 0);
        tableView.isScrollEnabled = false
        tableView.isEditing = false
        self.view.addSubview(tableView)
        token = UserDefaults.standard.object(forKey: "token") as! String
        let navBackImg = UIImage.init(color: UIColor.white, size: CGSize.init(width: SCREENW, height:43))
        
        self.navigationController?.navigationBar.setBackgroundImage(navBackImg, for: UIBarMetrics.default)
        let backItem = UIBarButtonItem.init(image: UIImage(named: "navBack"), style: .plain, target: self, action: #selector(backToPrevious))
        backItem.tintColor = UIColor.black
        self.navigationItem.leftBarButtonItem = backItem
        getDeviceInfo(code:codeStr, finished: nil)
        self.tableView.register(UINib.init(nibName: "BGSecCodeView", bundle: nil), forCellReuseIdentifier: "BGSecCodeView")
        
        if self.source == .edit{
            self.view.addSubview(sumbinButton)



        }else{
            let rightItem = UIBarButtonItem.init(title: "完成", style: UIBarButtonItemStyle.plain, target: self, action: #selector(finishEditedFunc))
            self.navigationItem.rightBarButtonItem = rightItem
        }

    }
    
    func backToPrevious(){
        self.navigationController?.popViewController(animated: true)
    }
    
    func finishEditedFunc(){
        gaddDeviceInfo()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tableView.reloadData()
    }

    // MARK: - Table view data source

    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
            return 8
    }

    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        if indexPath.row == 5 {
//            let cell = BGCodeBottomCell.mm_dequeueStaticCell(tableView: tableView, indexPath: indexPath)
//            cell.delegateBoundingAct = {(btn) -> () in
//                
//                if self.btnFlag{
//                    btn.setTitle("重新绑定", for: .normal)
//                    self.btnFlag = false
//                    self.boundingCollas()
//
//                }else{
//                    btn.setTitle("解除绑定", for: .normal)
//                    self.btnFlag = true
//                    self.delegateBoundeCallors()
//
//                }
//
//            }
//            
//            return cell
//
//        }
        
     
            let cell = BGCodeInfoCell.mm_dequeueStaticCell(tableView: tableView, indexPath: indexPath)
            
            if indexPath.row == 0{
                
                cell.DescTitleTextField.text = id
                cell.DescTitleLabel.text = "项圈ID：" + codeStr
            }else if indexPath.row == 1{
                cell.DescTitleTextField.text = codeStr
                cell.DescTitleLabel.text = "SIM卡：" + codeStr

            }else if indexPath.row == 2{
                cell.DescTitleLabel.text = "流量卡时效：1年"

            }else if indexPath.row == 3{
                cell.DescTitleLabel.text = "待机时间：2到5天（根据实际情况可能会有偏差）"

            }else if indexPath.row == 4{
                cell.DescTitleLabel.text = "定位模式：GPS，基站"

            }else if indexPath.row == 5{
                cell.DescTitleLabel.text = "工作温度：-20℃至50℃"
                
            }else if indexPath.row == 6{
                cell.DescTitleLabel.text = "通讯网络：GSM900/1800"
                
            }else{
                
                 let cell = tableView.dequeueReusableCell(withIdentifier: "BGSecCodeView", for: indexPath)  as! BGSecCodeView
                cell.imageViewIcon2.frame = CGRect(x:(self.view.bounds.width - 160 * BGW)/2,y:30 * BGH, width:140 * BGH, height:140 * BGH)
                return cell
            }
            return cell

            }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 7 {
            return 220
        }
        return 36 * BGH
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.tableView.reloadData()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.sumbinButton.snp.makeConstraints { (make) -> Void in
            make.left.equalTo(42 * BGW)
            make.right.equalTo(-42 * BGW)
            make.top.equalTo(tableView.snp.bottom).offset(10)
            make.height.equalTo(40 * BGH)
        }
    }
}


class BGCodeInfoCell: UITableViewCell {
    fileprivate lazy var DescTitleLabel:UILabel = {
        let DescTitleLabel = UILabel.init()
        DescTitleLabel.text = "项圈ID："
        DescTitleLabel.textColor = UIColor.black
        DescTitleLabel.textAlignment = .left
        DescTitleLabel.font = UIFont.systemFont(ofSize: 14)
        return DescTitleLabel
    }()
    
    fileprivate lazy var DescTitleTextField:UITextField = {
        let DescTitleLabel = UITextField.init()
        DescTitleLabel.textColor = UIColor.black
        DescTitleLabel.textAlignment = .left
        DescTitleLabel.font = UIFont.systemFont(ofSize: 14)
        return DescTitleLabel
    }()

    static func mm_dequeueStaticCell(tableView:UITableView, indexPath: IndexPath) -> BGCodeInfoCell {
        let reuseIdentifier = "staticCellReuseIdentifier - \(indexPath.description)"
        if let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier) as? BGCodeInfoCell {
            return cell
        }else {
            let cell = BGCodeInfoCell(style: .default, reuseIdentifier: reuseIdentifier)
            return cell
        }
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.addSubview(DescTitleLabel)

    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
       DescTitleLabel.snp.makeConstraints { (make) -> Void in
            make.centerY.equalTo(self.snp.centerY)
            make.left.equalTo(10 * BGH)
            make.height.equalTo(35 * BGH)
            make.width.equalTo(SCREENW - 20 * BGW)
        }


    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

extension BGCodeInfoVC{
    
    func boundingCollas(){
        let url = "http://api.halokit.cn:7070/halokit/v2/Device/bind"
        guard codeStr != "" else {
            self.popSuccessShow("还没有链接项圈")
            return
        }
        debugPrint("项圈绑定项圈绑定项圈绑定respose:")

        debugPrint("deviceIddeviceIddeviceId:",codeStr)
        netWork.postHeader(url, dict: ["deviceID":codeStr], andHeader: token , succeed: { (respose) in
            debugPrint("项圈绑定项圈绑定项圈绑定respose:",respose ?? "NULL")
            
        }) { (error) in
            debugPrint("error:",error ?? "NULL")
        }
        
    }

    
    
    func getDeviceInfo(code:String,finished:((_ netCode:Int) -> ())?){
        let url = RBRequestFunction.Device.获取项圈信息.urlString
        let params = ["deviceID":code]
        debugPrint(params)

        netWork.getHeader(url, dict: params, andHeader: token, succeed: { (respone) in
            debugPrint("json:",JSON(respone!))
            var datas = BGDeviceModel.init()
            let json = JSON(respone!)
            debugPrint("json[]:",json["code"])
            if json["code"] == 1{
                                    
                    datas = BGDeviceModel.init(fromJson:JSON(respone!)) as BGDeviceModel
                    self.color = datas.deviceModel.color
                    self.lastOfflineTime = datas.deviceModel.lastOfflineTime
                    self.boxid = datas.deviceModel.boxid
                    self.id = datas.deviceModel.deviceID
                    UserDefaults.standard.set(self.id, forKey: "deviceID")
                    self.tableView.reloadData()
            }else if json["code"] == 2000019{
                
                finished?(2000019 )
            }else{
            
                finished?(1000017 )

            }
            
        }) { (error) in
            debugPrint("error:",error ?? "")
            
        }
    }
    
    
    func gaddDeviceInfo(){
        let url = RBRequestFunction.Device.添加项圈.urlString
        let params = ["deviceID":codeStr]
        debugPrint(params, token)
        
        netWork.postHeader(url, dict: params, andHeader: token, succeed: { (respone) in
            debugPrint("respone successfully:",respone!)
            if let json = respone as? [String : AnyObject]{
                let code:Int = json["code"] as! Int
                if code == 1{
                    if self.source == .edit{
                        self.navigationController?.popViewController(animated: true)
                    }else{
                        UserDefaults.standard.set(3, forKey: "netNumber")
                        self.navigationController?.popToViewController(self.navigationController!.viewControllers[4], animated: true)
                    }

                }else{
                    self.popSuccessShow("此项圈已绑定")
                }
            }

        }) { (error) in
            debugPrint("error:",error ?? "")
        }
    }
    
    
    func delegateBoundeCallors(){
    
            let url = RBRequestFunction.Device.项圈解绑.urlString
            let params = ["deviceID":codeStr]
            debugPrint(url)
            netWork.postHeader(url, dict: params, andHeader: token, succeed: { (respone) in
                debugPrint("json:",JSON(respone!))
                
                
                if let json = respone as? [String : AnyObject]{
                    let code:Int = json["code"] as! Int
                    if code == 1{
//                        let datas = BGDeviceModel.init(fromJson:JSON(respone!)) as BGDeviceModel
                        debugPrint("*********************************************************")
                    }
                }
                
            }) { (error) in
                debugPrint("error:",error ?? "")
                
            }
    }


}


class BGCodeBottomCell: UITableViewCell{

    fileprivate lazy var buttomBtn:UIButton = {
        let buttomBtn = UIButton.init()
        buttomBtn.setTitle("重新绑定", for: .normal)
        buttomBtn.setTitleColor(UIColor.blue, for: .normal)
        buttomBtn.addTarget(self, action: #selector(BGCodeBottomCell.delegateBounding), for: .touchUpInside)
        buttomBtn.backgroundColor = UIColor.lightGray
        return buttomBtn
    }()
    
    static func mm_dequeueStaticCell(tableView:UITableView, indexPath: IndexPath) -> BGCodeBottomCell {
        
        let reuseIdentifier = "BGCodeBottomCell"
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier) as? BGCodeBottomCell {
            return cell
        }else {
            let cell = BGCodeBottomCell(style: .default, reuseIdentifier: reuseIdentifier)
            return cell
        }
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.addSubview(buttomBtn)
        
    }
    
    var delegateBoundingAct:((_ buttomBtn:UIButton) -> ())?
    func delegateBounding(){
    self.delegateBoundingAct?(buttomBtn)
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        buttomBtn.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(2)
            make.centerX.equalTo(self.center.x)
            make.height.equalTo(40)
            make.width.equalTo(80)
            
        }
        
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


}
