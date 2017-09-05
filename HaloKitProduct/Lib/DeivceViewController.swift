//
//  DeivceViewController.swift
//  HaloKitProduct
//
//  Created by 范博 on 2017/7/10.
//  Copyright © 2017年 范博. All rights reserved.
//

import UIKit
import SwiftyJSON
import SnapKit
import SDWebImage
class DeivceViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    let netWork:HttpRequest = HttpRequest.sharedInstance()
    var token = ""
    var deviceId = ""
    var fllag = true
    var devicesArray = [BGDevices_devicesModel]()
    var tableView:UITableView = UITableView.init()
    lazy var navView:UIView = {
        let navView = UIView.init(frame: CGRect(x:0, y:0, width:self.view.bounds.width, height:64))
        navView.backgroundColor = UIColor.init(red: 249/255.0, green: 249/255.0, blue: 249/255.0, alpha: 1.0)
        return navView
        
    }()
    
    lazy var statusView:UIView = {
        let navView = UIView.init(frame: CGRect(x:0, y:0, width:self.view.bounds.width, height:64))
        navView.backgroundColor = UIColor.red
        let descLabel = UILabel.init(frame: CGRect(x:50, y:2, width:self.view.bounds.width - 10, height:40))
        descLabel.text = "项圈状态：未连接状态，点击请链接"
        let imgView = UIImageView.init(frame: CGRect(x:10, y:2, width:40, height:40))
        return navView
        
    }()
    
    var bigView = UIView.init(frame: CGRect(x:0, y:-64, width:UIScreen.main.bounds.width, height:128))

    override func viewDidLoad() {
        super.viewDidLoad()
        let btn = UIButton.init(frame: CGRect(x:16, y:22, width:30, height:40))
        btn.setImage(UIImage.init(named:"navBack"), for: .normal)
        let navLine = UIView.init(frame: CGRect(x:0,y:63.5,width:self.view.bounds.width,height:0.5))
        navLine.backgroundColor = UIColor.init(red: 175/255.0, green: 175/255.0,blue: 175/255.0,alpha: 1.0)
        tableView = UITableView.init(frame: CGRect(x:10 * BGW, y:10 * BGW, width:self.view.bounds.width - 20 * BGW, height: self.view.bounds.height))
        view.backgroundColor = UIColor.init(red: 247.0/255.0, green: 247.0/255.0, blue: 247.0/255.0, alpha: 1.0)
        tableView.dataSource = self
        tableView.delegate = self
        bigView.addSubview(statusView)
        bigView.addSubview(navView)
        navView.addSubview(btn)
        navView.addSubview(navLine)
        self.view.addSubview(tableView)
//      self.view.addSubview(bigView)
        self.title = "项圈"
        tableView.register(UINib.init(nibName: "BGCollarHeaderInfoCell", bundle: nil), forCellReuseIdentifier: "BGCollarHeaderInfoCell")
        tableView.register(UINib.init(nibName: "BGCollarsVInfoCell", bundle: nil), forCellReuseIdentifier: "BGCollarsVInfoCell")
        tableView.register(UINib.init(nibName: "BGDogInfoCell", bundle: nil), forCellReuseIdentifier: "BGDogInfoCell")
        tableView.register(UINib.init(nibName: "BGPeidaiCell", bundle: nil), forCellReuseIdentifier: "BGPeidaiCell")        
        tableView.register(UINib.init(nibName: "DeviceViewCell", bundle: nil), forCellReuseIdentifier: "DeviceViewCell")
        tableView.separatorStyle = .none
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(image: BGImgView .image(withIcon: "\u{e63a}", inFont: "iconfont", size: 30, color: UIColor.black), style: UIBarButtonItemStyle.plain, target: self, action: #selector(showxiangquanListfunction))
        if let _ = UserDefaults.standard.string(forKey: "token"){
            token = UserDefaults.standard.string(forKey: "token")!

        }
        
    }
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        if fllag  {
            tableView.snp.makeConstraints { (make) -> Void in
                make.top.equalTo(0)
                make.left.equalTo(10 * BGW)
                make.right.equalTo(-10 * BGW)
                make.bottom.equalTo(self.view.bounds.height - 10 * BGW)
            }

        }else{
//              tableView.topConstraint.uninstall()
                tableView.snp.makeConstraints { (make) -> Void in
                    make.top.equalTo(128)
                    make.left.right.equalTo(0)
                    make.bottom.equalTo(0)

                }
        }

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getDeviceList()

    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

    }
    
    
    func showxiangquanListfunction(){
        let scanVc = Scan_VC.init()
        scanVc.getSource("2")
        self.navigationController?.pushViewController(scanVc, animated: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    func numberOfSections(in tableView: UITableView) -> Int {
        return devicesArray.count + 2
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 350
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {

            return 30

    }


    var typeC = ""
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        debugPrint("devicesArray.count:",devicesArray.count, indexPath.section)
        
        
        switch indexPath.section  {
        case devicesArray.count + 1 :
            let cell = UITableViewCell.init()
            cell.backgroundColor = UIColor.init(red: 247.0/255.0, green: 247.0/255.0, blue: 247.0/255.0, alpha: 1.0)
            return cell
            
        case devicesArray.count :
            let cell = UITableViewCell.init()
            cell.backgroundColor = UIColor.init(red: 247.0/255.0, green: 247.0/255.0, blue: 247.0/255.0, alpha: 1.0)
            return cell

        default:
            typeC = devicesArray[indexPath.section].type
            let cell = tableView.dequeueReusableCell(withIdentifier: "DeviceViewCell", for: indexPath) as! DeviceViewCell
            if devicesArray.count > 0 {
                
                cell.deviceAct = {
                    let deviceID = self.devicesArray[indexPath.section].deviceID
                    //let deviceType = self.devicesArray[indexPath.section].type
                    BGCodeInfoVC.push(self, param:deviceID ,source: "2")
                    
                }
                
                cell.data = self.devicesArray[indexPath.section]
                if typeC == "1" {
                    
                    cell.shiyongBtn.setTitle("使用中", for: .normal)
                    cell.peidaiLabel.text = "佩戴宠物是：\(self.devicesArray[indexPath.section].nickname)"
                    cell.buttomshiyongBtn.isHidden = false
                    cell.dogHeadIcon.sd_setImage(with: URL(string:self.devicesArray[indexPath.section].imagePath))
                    
                }else if typeC == "0"{
                    cell.buttomshiyongBtn.isHidden = true
                    if cell.data.nickname == "" && cell.data.imagePath == "" {
                        cell.shiyongBtn.setTitle("未佩戴", for: .normal)
                        cell.peidaiLabel.text = "您还没有佩戴宠物，快去选择宠物吧"
                    }else{
                        cell.shiyongBtn.setTitle("待使用", for: .normal)
                        cell.peidaiLabel.text = "佩戴的宠物：\(self.devicesArray[indexPath.section].nickname)"
                    }
                }else{
                    cell.buttomshiyongBtn.isHidden = true
                    cell.shiyongBtn.setTitle("重新绑定", for: .normal)
                    cell.peidaiLabel.text = "等待重新使用的一天"
                    
                }
                
                cell.shiyongAct = {
                    if self.typeC == "1" {
                        
                        
                        
                    }else if self.typeC == "0"{
                        if cell.data.nickname == "" && cell.data.imagePath == "" {
                            debugPrint("未佩戴未佩戴未佩戴未佩戴未佩戴")
                            self.getGogList()
                        }else{
                            debugPrint("待使用待使用待使用待使用待使用")

                            self.boundingCollas(deviceIdStr: self.devicesArray[indexPath.section].deviceID)
                        }
                    }else{
                        debugPrint("重新绑定重新绑定重新绑定重新绑定重新绑定")

                        self.boundingCollas(deviceIdStr: self.devicesArray[indexPath.section].deviceID)
                    }
                }
                
                cell.deviceAct = {
                    let deviceID = self.devicesArray[indexPath.section].deviceID
                    //            let deviceType = self.devicesArray[indexPath.section].type
                    BGCodeInfoVC.push(self, param:deviceID ,source: "2")
                }
            }
            return cell
        }
    }

    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.tableView.reloadData()
        
    }
}

extension DeivceViewController{
    
    func getDeviceList(){
        let url = RBRequestFunction.User.获取用户设备列表.urlString
        netWork.getHeader(url, dict: nil, andHeader: token, succeed: { (respone) in
            debugPrint("获取用户设备列表获取用户设备列表:",JSON(respone!))
            let dataJson = JSON(respone!)
            if dataJson["code"] == 1{
                let datas = BGDevicesModel.init(fromJson:JSON(respone!)) as BGDevicesModel
                self.devicesArray = datas.devices_devicesModel
                self.tableView.reloadData()
            }

        }) { (error) in
            debugPrint("error:", error ?? "")
        }        
    }

    
    func getGogList(){
        let url = RBRequestFunction.User.获取宠物列表.urlString
        debugPrint("tokentoken:",token)
        netWork.getHeader(url, dict: nil, andHeader: token, succeed: { (respone) in
            let dataJson = JSON(respone!)
            if dataJson["code"] == 1{
                let datas = BGPetsModel.init(fromJson:JSON(respone!)) as BGPetsModel
                let bgDogVc = BGDogVC()
                bgDogVc.deviceId = self.deviceId
                bgDogVc.dogCatory = .showList
                bgDogVc.petsInfoList = datas.petsInfoModel
                self.navigationController?.pushViewController(bgDogVc, animated: true)
            }

        }) { (error) in
            debugPrint("error:",error ?? "NULL")
        }
    }
}

extension DeivceViewController{
    func boundingCollas(deviceIdStr:String){
        let url = RBRequestFunction.Device.项圈绑定.urlString
        debugPrint("deviceIddeviceIddeviceId:",deviceIdStr)
        netWork.postHeader(url, dict: ["deviceID":deviceIdStr], andHeader: token , succeed: { (respose) in
            debugPrint("respose:",respose ?? "NULL")
            self.getDeviceList()
        }) { (error) in
            debugPrint("error:",error ?? "NULL")
        }
        
    }
    
    
}

