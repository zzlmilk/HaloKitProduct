//
//  BGDogVC.swift
//  HaloKitProduct
//
//  Created by 范博 on 2017/7/13.
//  Copyright © 2017年 范博. All rights reserved.
//

import UIKit
import SwiftyJSON
enum DOGCATORY {
    case showList
    case editList
}

class BGDogVC: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var petsInfoList:[BGPetsInfoModel]!
    var cellHight:CGFloat = 350
    let netWork:HttpRequest = HttpRequest.sharedInstance()
    var token = ""
    var deviceId = ""
    var petID = ""
    var isgotabBarFlag = false
    var dogCatory:DOGCATORY = .showList
    var tableView:UITableView!
    override func loadView() {
        self.title = "宠物列表"
        if let _ = petsInfoList {
            if petsInfoList.count > 0 {
                
                super.loadView()

            }else{
                let noPetsView = Bundle.main.loadNibNamed("BGNoPetsView", owner: self, options: nil)?.first as! BGNoPetsView
                view = noPetsView
                noPetsView.addPetAct = {
                    BGEditpetVC.push(self, param: "2", dogModel: nil)

                }

            }
        }else{
                view = Bundle.main.loadNibNamed("BGNoPetsView", owner: self, options: nil)?.first as! BGNoPetsView
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }


    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBarController?.tabBar.isHidden = true
//        debugPrint("petsInfoList:",petsInfoList)
//        debugPrint("petsInfoListCount:", petsInfoList.count)

        if let _ = UserDefaults.standard.string(forKey: "token"){
            token = UserDefaults.standard.string(forKey: "token")!
        }
        
        if let _ = UserDefaults.standard.string(forKey: "deviceID"){
            deviceId = UserDefaults.standard.string(forKey: "deviceID")!
        }

        
        if let _ = petsInfoList {
            if petsInfoList.count > 0 {
                tableView = UITableView.init(frame: CGRect(x:10 * BGW, y:10 * BGW, width:self.view.bounds.width - 20 * BGW, height: self.view.bounds.height))
                tableView.delegate = self
                tableView.dataSource = self
                view.backgroundColor = UIColor.init(red: 247.0/255.0, green: 247.0/255.0, blue: 247.0/255.0, alpha: 1.0)
                tableView.register(UINib.init(nibName: "DogCell", bundle: nil), forCellReuseIdentifier: "DogCell")
                tableView.separatorStyle = .none
                self.view.addSubview(tableView)
            }else{
                
                
            }
        }else{
        
        
        }
        self.createNav()
    }
    
    func createNav() {
        
        let backItem = UIBarButtonItem.init(image: UIImage(named: "navBack"), style: .plain, target: self, action: #selector(backToPrevious))
        backItem.tintColor = UIColor.black
        self.navigationItem.leftBarButtonItem = backItem
        
        switch dogCatory {
        case .showList: break
      
        default:
            self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(image: BGImgView .image(withIcon: "\u{e63a}", inFont: "iconfont", size: 30, color: UIColor.black), style: UIBarButtonItemStyle.plain, target: self, action: #selector(BGDogVC.addcallorsfunction))
        }
        

    }
    
    func addcallorsfunction(){
        let addPetVC = BGEditpetVC.initVC(param: "2")
        self.navigationController?.pushViewController(addPetVC, animated: true)

    
    }
    
    func backToPrevious(){
        isgotabBarFlag = false
        self.navigationController?.popViewController(animated: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        self.getGogList()

    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super .viewWillDisappear(animated)
        if isgotabBarFlag {
            self.tabBarController?.tabBar.isHidden = true
        }else{
            self.tabBarController?.tabBar.isHidden = false

        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source
    func numberOfSections(in tableView: UITableView) -> Int {
        debugPrint("_______________:",petsInfoList.count )

        return  petsInfoList == nil ? 0 : self.petsInfoList.count

    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
  
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {

        if petsInfoList.count > 0{
            
            var model = BGPetsInfoModel()
            model = petsInfoList[indexPath.section]
            let string:String = model.introduced
            let attributedString = NSAttributedString(string: string, attributes: [NSFontAttributeName : UIFont.systemFont(ofSize: 14)])
            let rect = attributedString.boundingRect(with: CGSize(width: self.view.bounds.width - 32 * BGW, height: CGFloat.greatestFiniteMagnitude), options: .usesLineFragmentOrigin, context: nil)
            return rect.height + 350
        }else{
            return  350

        }

    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DogCell", for: indexPath) as! DogCell
        if let _ = petsInfoList {
            cell.data = petsInfoList[indexPath.section]
            let string:String = cell.descLabel.text!
            let attributedString = NSAttributedString(string: string, attributes: [NSFontAttributeName : UIFont.systemFont(ofSize: 14)])
            let rect = attributedString.boundingRect(with: CGSize(width: self.view.bounds.width - 32 * BGW, height: CGFloat.greatestFiniteMagnitude), options: .usesLineFragmentOrigin, context: nil)
            cell.descLabel.frame = CGRect(x:8 * BGW, y:250, width:SCREENW - 16 * BGW, height: rect.height)
        }
        
        return cell

    }

    

    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch dogCatory {
        case .showList:
            let alert = UIAlertController.init(title: "您确定选择此宠物佩戴项圈吗?", message: nil, preferredStyle: UIAlertControllerStyle.alert)
            let _ = alert.addAlertAction(title: "确认",handler:  { (alert) in
                self.petID = self.petsInfoList[indexPath.row]._id
                self.peidaiCollas(petID: self.petID)
                
            })
            let _ = alert.addCancelAlertAction(title: "取消", handler: nil)
            self.present(alert, animated: true, completion: nil)
        default:
            if self.petsInfoList.count > 0 {
                debugPrint("self.petsInfoList[indexPath.section]:",self.petsInfoList[indexPath.section])
                BGEditpetVC.push(self, param: "1", dogModel: self.petsInfoList[indexPath.section])
            }
        }
        self.tableView.reloadData()
    }
}

extension BGDogVC{

    func peidaiCollas(petID: String){
        guard deviceId != "" else {
            self.popSuccessShow("还没有链接项圈")
            return
        }
        debugPrint("petIDpetIDpetID:",petID, "deviceIddeviceId:",deviceId)
        let url = RBRequestFunction.Device.项圈关联宠物.urlString
        netWork.postHeader(url, dict: ["deviceID":deviceId,"petID" : petID ], andHeader: token , succeed: { (respose) in
            debugPrint("respose:",respose ?? "NULL")
            self.navigationController?.popViewController(animated: true)

        }) { (error) in
            debugPrint("error:",error ?? "NULL")
        }
        
    }
    
    
    func getGogList(){
        let url = RBRequestFunction.User.获取宠物列表.urlString
        debugPrint("tokentoken:",token)
        netWork.getHeader(url, dict: nil, andHeader: token, succeed: { (respone) in
            let dataJson = JSON(respone!)
            debugPrint("获取宠物列表获取宠物列表获取宠物列表:",dataJson)
            if dataJson["code"] == 1{
                let datas = BGPetsModel.init(fromJson:JSON(respone!)) as BGPetsModel
                self.petsInfoList = datas.petsInfoModel
                debugPrint("获取宠物列表获取宠物列表获取宠物列表:",self.petsInfoList)
                self.tableView.reloadData()
            }
            
            
        }) { (error) in
            debugPrint("error:",error ?? "NULL")
            
        }
        
        
    }


}
