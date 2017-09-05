//
//  BGSettingVc.swift
//  HaloKitProduct
//
//  Created by 范博 on 2017/7/25.
//  Copyright © 2017年 范博. All rights reserved.
//

import UIKit

class BGSettingVc: UITableViewController {
    var token = ""
    var noExit = true
    var progressHUD: MBProgressHUD!


    class func initVC(param:String? = nil) -> BGSettingVc{
        return BGSettingVc.init(param: param)
    }
    
    init(param: String?) {
        super.init(nibName: nil, bundle: nil)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    class func push(_ parentVC:UIViewController?, param:String? = nil) {
        let vc = BGSettingVc.initVC(param:param)
        parentVC?.navigationController?.pushViewController(vc, animated: true)

    }


    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "设置"
        tableView.separatorInset = UIEdgeInsetsMake(0,0, 0, 0);
        self.tabBarController?.tabBar.isHidden = true
        self.tableView.register(SecondToolsCellView.classForCoder(), forCellReuseIdentifier: SecondToolsCellView.cell_id)
        if let _ = UserDefaults.standard.string(forKey: "token"){
            token = UserDefaults.standard.string(forKey: "token")!
        }
        self.tableView.register(UINib.init(nibName: "BGSettingBttomCell", bundle: nil), forCellReuseIdentifier: "SettingBttomCell")
        progressHUD = MBProgressHUD.init(view: self.view)
        UIApplication.shared.keyWindow?.addSubview(progressHUD)

    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if noExit {
            self.tabBarController?.tabBar.isHidden = false
        }else{
            self.tabBarController?.tabBar.isHidden = true

        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 5
        }else if section == 1 {
            return 1
        }else{
            return 1

        }
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return 10
        }else if section == 1 {
            return 20
        }else{
            return 20
            
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 50
        }else if indexPath.section == 1 {
            return 50
        }else{
            return 300
            
        }

    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell.init(style: .value1, reuseIdentifier: "12345")
        cell.accessoryType = .disclosureIndicator
        switch indexPath.section {
        case 0:
            switch indexPath.row {
            case 0:
                cell.textLabel?.text = "意见反馈"
            case 1:
                cell.textLabel?.text = "帮助中心"
            case 2:
                cell.textLabel?.text = "关于我们"
            case 3:
                cell.textLabel?.text = "客服热线"
                cell.detailTextLabel?.text = "4007759206"
            default:
                cell.textLabel?.text = "清除缓存"
                cell.detailTextLabel?.text = "\(fileSizeOfCache())" + "MB"
 
            }
            
        case 1:
            cell.textLabel?.text = "退出登录"

        default:
            
            
            cell.accessoryType = .none

            cell.backgroundColor = UIColor.init(red: 247/255.0, green: 247/255.0, blue: 247/255.0, alpha: 1.0)
            return cell
            
        }
        return cell

    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if indexPath.section == 0 {
            switch indexPath.row {
                case 0:
                   let vc = UIStoryboard.init(name: "BGTools", bundle: nil).instantiateViewController(withIdentifier: "BGFeedbackVC") as UIViewController
                    self.navigationController?.pushViewController(vc, animated: true)
                case 1:
                    let vc = UIStoryboard.init(name: "BGTools", bundle: nil).instantiateViewController(withIdentifier: "AboutUsViewController") as UIViewController
                    self.navigationController?.pushViewController(vc, animated: true)
                case 2:
                    let vc = UIStoryboard.init(name: "BGTools", bundle: nil).instantiateViewController(withIdentifier: "BGFAQVC") as! UITableViewController
                    self.navigationController?.pushViewController(vc, animated: true)
                case 3:
                    UIApplication.shared.openURL(URL.init(string:"tel://4007759206" )!)

                default:
                    
                    let alertVC = UIAlertController(title: "提示", message: "您确定要清除缓存吗？", preferredStyle: UIAlertControllerStyle.alert)
                    let acSure = UIAlertAction(title: "确定", style: UIAlertActionStyle.default) { (UIAlertAction) -> Void in
                        self.clearCache()
                        self.progressHUD.show(true)
                    }
                    let acCancel = UIAlertAction(title: "取消", style: UIAlertActionStyle.cancel) { (UIAlertAction) -> Void in
                        print("click Cancel")
                    }
                    alertVC.addAction(acSure)
                    alertVC.addAction(acCancel)
                    self.present(alertVC, animated: true, completion: nil)
                    
                
            }
            
        }else if indexPath.section == 1{
            let alert = UIAlertController.init(title: "您确定选择此宠物佩戴项圈吗?", message: nil, preferredStyle: UIAlertControllerStyle.alert)
            let _ = alert.addAlertAction(title: "确认",handler:  { (alert) in
                
                BGPhoneLoginVC.push(self, param1: nil)
                self.noExit = false
                
            })
            let _ = alert.addCancelAlertAction(title: "取消", handler: nil)
            self.present(alert, animated: true, completion: nil)

        
        }else{
            
        }
    }
    
    func fileSizeOfCache()-> Int {
        
        // 取出cache文件夹目录 缓存文件都在这个目录下
        let cachePath = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.cachesDirectory, FileManager.SearchPathDomainMask.userDomainMask, true).first
        //缓存目录路径
        print(cachePath ?? "")
        
        // 取出文件夹下所有文件数组
        let fileArr = FileManager.default.subpaths(atPath: cachePath!)
        //快速枚举出所有文件名 计算文件大小
        var size = 0
        for file in fileArr! {
            
            // 把文件名拼接到路径中
            let path = cachePath! + ("/\(file)")
            // 取出文件属性
            let floder = try! FileManager.default.attributesOfItem(atPath: path)
            // 用元组取出文件大小属性
            for (abc, bcd) in floder {
                // 累加文件大小
                if abc == FileAttributeKey.size {
                    size += (bcd as AnyObject).integerValue
                }
            }
        }
        
        let mm = size / 1024 / 1024
        if let _ = progressHUD{
            self.perform(#selector(hiddenHud), with: nil, afterDelay: 3.0)
        }

        return mm
    }
    
    func hiddenHud(){
        
     progressHUD.hide(true)
    }
    
    func clearCache() {
        // 取出cache文件夹目录 缓存文件都在这个目录下
        let cachePath = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.cachesDirectory, FileManager.SearchPathDomainMask.userDomainMask, true).first
        
        // 取出文件夹下所有文件数组
        let fileArr = FileManager.default.subpaths(atPath: cachePath!)
        
        // 遍历删除
        for file in fileArr! {
            
            let path = (cachePath)! + "/\(file)"
            if FileManager.default.fileExists(atPath: path) {
                
                do {
                    try FileManager.default.removeItem(atPath: path)
                } catch {
                    
                }
            }
        }
        
        self.tableView.reloadData()
    }
    



}



