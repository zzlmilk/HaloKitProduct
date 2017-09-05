//
//  BGPersonalInfoVC.swift
//  HaloKitProduct
//
//  Created by 范博 on 2017/6/29.
//  Copyright © 2017年 范博. All rights reserved.
//

import UIKit

class BGPersonalInfoVC: UITableViewController {
    
    //MARK:---变量
    var param:String? = nil
    var param1:String? = nil
    var parentVC:String? = nil

    class func initVC(param:String? = nil) -> BGPersonalInfoVC{
        return BGPersonalInfoVC.init(param: param)
    }
    
    init(param: String?) {
        super.init(nibName: nil, bundle: nil)
        self.param = param
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    class func push(_ parentVC:UIViewController?, param:String? = nil, param1:String?) {
        let vc = BGPersonalInfoVC.initVC(param:param)
        vc.param1 = param1
        parentVC?.navigationController?.pushViewController(vc, animated: true)
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.register(BGPersonalInfoheadIconCell.classForCoder(), forCellReuseIdentifier: BGPersonalInfoheadIconCell.cell_id)
        self.tableView.register(BGPersonalInfoOthersCell.classForCoder(), forCellReuseIdentifier: BGPersonalInfoOthersCell.OthersCell_id)
    }



    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 2
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        switch section {
        case 0:
            
            return 1
        default:
            
            return 4
            
        }
        
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 0:
            
            return BGPersonalInfoheadIconCell.returnCell_hight()
        default:
            
            return BGPersonalInfoOthersCell.returnCell_hight()
            
        }
 
    }

    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 10
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let cell = BGPersonalInfoheadIconCell.dequeueReusable(tableView, indexPath: indexPath)

//            cell.model =
            return cell
        default:
            let cell = BGPersonalInfoOthersCell.dequeueReusable(tableView, indexPath: indexPath)
//            cell.model =

            return cell
            
        }
        
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.reloadData()
        
        switch indexPath.section {
        case 0:
            break
        default:
            switch indexPath.row {
            case 0:
                break
            case 1:
                break
            case 2:
                break
            default:
               break
            }
            break
        }

    }

}
