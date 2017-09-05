//
//  BGAddPetVC.swift
//  HaloKitProduct
//
//  Created by 范博 on 2017/7/9.
//  Copyright © 2017年 范博. All rights reserved.
//

import UIKit

class BGAddPetVC: UITableViewController {
    var userID = ""
    var source = "2"
    class func initVC(param:String? = nil, source:String) -> BGAddPetVC{ //secCellView
        return BGAddPetVC.init(param: param, source:source)
    }
    
    init(param: String?, source:String) {
        super.init(nibName: nil, bundle: nil)
        self.userID = param!
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    class func push(_ parentVC:UIViewController?, param:String? = nil, source:String) {
        let vc = BGAddPetVC.initVC(param:param, source:source)
        parentVC?.navigationController?.pushViewController(vc, animated: true)
    }
    

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.register(firstCellView.classForCoder(), forCellReuseIdentifier: firstCellView.cell_id)
        self.tableView.register(secCellView.classForCoder(), forCellReuseIdentifier: secCellView.cell_id)
        let navBackImg = UIImage.init(color: UIColor.white, size: CGSize.init(width: 1, height:1))
        self.navigationController?.navigationBar.setBackgroundImage(navBackImg, for: UIBarMetrics.default)
        let backItem = UIBarButtonItem.init(image: navBackImg, style: .plain, target: self, action: #selector(backToPrevious))
        self.navigationItem.leftBarButtonItem = backItem
        self.title = "完善个人资料"

    }
    
    func backToPrevious(){
//        self.navigationController?.popViewController(animated: true)
    }

    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.tableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 2
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        
        return 1
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 0:
            return 250 * BGH
        default:
            return 341 * BGH
        }
        
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        switch section {
        case 0:
            return 0
        default:
            return 10
        }
    }


    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let cell = firstCellView.dequeueReusable(tableView, indexPath: indexPath)
            let userNumber = UserDefaults.standard.integer(forKey: "netNumber")
             debugPrint("netNumbernetNumber", userNumber)
            switch userNumber {
            case 0:
                cell.DescLabelFirst.textColor = UIColor.black
                cell.DescLabelSecond.textColor = UIColor.lightGray
                cell.DescLabelThree.textColor = UIColor.lightGray
                cell.DescLabelThird.textColor = UIColor.lightGray
                cell.DescLabelSeven.textColor = UIColor.lightGray
                
                cell.DescLabelFirst.font = UIFont.systemFont(ofSize: 14)
                cell.DescLabelSecond.font = UIFont.systemFont(ofSize: 16)
                cell.DescLabelThree.font = UIFont.systemFont(ofSize: 14)
                cell.DescLabelThird.font = UIFont.systemFont(ofSize: 14)
                cell.DescLabelSeven.font = UIFont.systemFont(ofSize: 14)
                
                cell.DescImageFirst.isHidden = false
                cell.DescImageSecond.isHidden = true
                cell.DescImageThree.isHidden = true
                cell.DescImageThird.isHidden = true
                cell.DescImageSeven.isHidden = true


            case 1:
                cell.DescLabelFirst.textColor = UIColor.lightGray
                
                cell.DescLabelSecond.textColor = UIColor.black
                cell.DescLabelThree.textColor = UIColor.lightGray
                cell.DescLabelThird.textColor = UIColor.lightGray
                cell.DescLabelSeven.textColor = UIColor.lightGray
                
                cell.DescLabelFirst.font = UIFont.systemFont(ofSize: 14)
                cell.DescLabelSecond.font = UIFont.systemFont(ofSize: 16)
                cell.DescLabelThree.font = UIFont.systemFont(ofSize: 14)
                cell.DescLabelThird.font = UIFont.systemFont(ofSize: 14)
                cell.DescLabelSeven.font = UIFont.systemFont(ofSize: 14)

                cell.DescImageFirst.isHidden = false
                cell.DescImageSecond.isHidden = true
                cell.DescImageThree.isHidden = true
                cell.DescImageThird.isHidden = true
                cell.DescImageSeven.isHidden = true

                
                
            case 2:
                cell.DescLabelFirst.textColor = UIColor.lightGray
                cell.DescLabelSecond.textColor = UIColor.lightGray
                cell.DescLabelThree.textColor = UIColor.black
                cell.DescLabelThird.textColor = UIColor.lightGray
                cell.DescLabelSeven.textColor = UIColor.lightGray
                
                cell.DescLabelFirst.font = UIFont.systemFont(ofSize: 14)
                cell.DescLabelSecond.font = UIFont.systemFont(ofSize: 14)
                cell.DescLabelThree.font = UIFont.systemFont(ofSize: 16)
                cell.DescLabelThird.font = UIFont.systemFont(ofSize: 14)
                cell.DescLabelSeven.font = UIFont.systemFont(ofSize: 14)

                cell.DescImageFirst.isHidden = false
                cell.DescImageSecond.isHidden = false
                cell.DescImageThree.isHidden = true
                cell.DescImageThird.isHidden = true
                cell.DescImageSeven.isHidden = true


            case 3:
                cell.DescLabelFirst.textColor = UIColor.lightGray
                cell.DescLabelSecond.textColor = UIColor.lightGray
                cell.DescLabelThree.textColor = UIColor.lightGray
                cell.DescLabelThird.textColor = UIColor.black
                cell.DescLabelSeven.textColor = UIColor.lightGray
                
                cell.DescLabelFirst.font = UIFont.systemFont(ofSize: 14)
                cell.DescLabelSecond.font = UIFont.systemFont(ofSize: 14)
                cell.DescLabelThree.font = UIFont.systemFont(ofSize: 14)
                cell.DescLabelThird.font = UIFont.systemFont(ofSize: 16)
                cell.DescLabelSeven.font = UIFont.systemFont(ofSize: 14)

                cell.DescImageFirst.isHidden = false
                cell.DescImageSecond.isHidden = false
                cell.DescImageThree.isHidden = false
                cell.DescImageThird.isHidden = true
                cell.DescImageSeven.isHidden = true


           case 4:
                cell.DescLabelFirst.textColor = UIColor.lightGray
                cell.DescLabelSecond.textColor = UIColor.lightGray
                cell.DescLabelThree.textColor = UIColor.lightGray
                cell.DescLabelThird.textColor = UIColor.lightGray
                cell.DescLabelSeven.textColor = UIColor.black
                
                cell.DescLabelFirst.font = UIFont.systemFont(ofSize: 14)
                cell.DescLabelSecond.font = UIFont.systemFont(ofSize: 14)
                cell.DescLabelThree.font = UIFont.systemFont(ofSize: 14)
                cell.DescLabelThird.font = UIFont.systemFont(ofSize: 14)
                cell.DescLabelSeven.font = UIFont.systemFont(ofSize: 16)
                
                
                cell.DescImageFirst.isHidden = false
                cell.DescImageSecond.isHidden = false
                cell.DescImageThree.isHidden = false
                cell.DescImageThird.isHidden = false
                cell.DescImageSeven.isHidden = true


                
            default:
                cell.DescLabelFirst.textColor = UIColor.lightGray
                cell.DescLabelSecond.textColor = UIColor.lightGray
                cell.DescLabelThree.textColor = UIColor.lightGray
                cell.DescLabelThird.textColor = UIColor.lightGray
                cell.DescLabelSeven.textColor = UIColor.lightGray
                
                cell.DescLabelFirst.font = UIFont.systemFont(ofSize: 14)
                cell.DescLabelSecond.font = UIFont.systemFont(ofSize: 14)
                cell.DescLabelThree.font = UIFont.systemFont(ofSize: 14)
                cell.DescLabelThird.font = UIFont.systemFont(ofSize: 14)
                cell.DescLabelSeven.font = UIFont.systemFont(ofSize: 14)

                
                cell.DescImageFirst.isHidden = false
                cell.DescImageSecond.isHidden = false
                cell.DescImageThree.isHidden = false
                cell.DescImageThird.isHidden = false
                cell.DescImageSeven.isHidden = false

                DebugTool.debugLog(item:"netNumbernetNumber")
            }
            return cell
            
        default:
            let cell = secCellView.dequeueReusable(tableView, indexPath: indexPath)
            let userNumber = UserDefaults.standard.integer(forKey: "netNumber")
             DebugTool.debugLog(item:"netNumbernetNumber", userNumber)
            switch userNumber {
            case 0:
                cell.sumbinButton.setTitle("注册账号", for: .normal)


            case 1:
                cell.sumbinButton.setTitle("完善个人资料", for: .normal)
                cell.personalView.fistLabel.text = "完善个人资料，可以让可点更了解你\n \n "
                cell.personalView.lastLabel.text = "点击下方的按钮行动吧"
                cell.personalView.img.image = BGImgView.image(withIcon: "\u{e648}", inFont: "iconfont", size: 300, color: UIColor.black)
            case 2:
                cell.sumbinButton.setTitle("绑定项圈", for: .normal)
                cell.personalView.fistLabel.text = "找到项圈只用说明书上的二维码，通过扫码完成绑定项圈\n如有疑问，请联系客服热线:4007759206"
                cell.personalView.lastLabel.text = "温馨提示：请确定可点职能项圈处于开机状态"
                cell.personalView.img.image = BGImgView.image(withIcon: "\u{e64c}", inFont: "iconfont", size: 300, color: UIColor.black)
            case 3:
                cell.sumbinButton.setTitle("添加宠物", for: .normal)
                cell.personalView.fistLabel.text = "完善宠物资料，可以让可点更好的服务你\n \n "
                cell.personalView.lastLabel.text = "您接下来添加的宠物将佩戴此项圈"
                cell.personalView.img.image = BGImgView.image(withIcon: "\u{e640}", inFont: "iconfont", size: 300, color: UIColor.black)
            default:
                cell.sumbinButton.setTitle("佩戴", for: .normal)
                cell.personalView.fistLabel.text = "主人，赶快为我佩戴项圈吧 \n \n "
                cell.personalView.lastLabel.text = "为爱宠将佩戴项圈后直接进入首页"
                cell.personalView.img.image = BGImgView.image(withIcon: "\u{e63c}", inFont: "iconfont", size: 300, color: UIColor.black)
            }
            cell.nextStepFunct = {
                switch userNumber {
                case 0:break
//                    BGPhoneRegistVC.push(self, param1: nil, category: Category)
                case 1:
                    BGPersonalInfoVC.push(self, userID: self.userID, source: self.source)
                case 2:
                    self.pushScan_VC()
                case 3:
                    BGEditpetVC.push(self,param:self.source, dogModel: nil)
                    
                default: //
                    FrameWorkViewController.push(self, param1: nil)
                }
            }
            return cell
            
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.tableView.reloadData()
    }
    
    func pushScan_VC() {
        let scanVc = Scan_VC.init()
        self.navigationController?.pushViewController(scanVc, animated: true)
    }


}

class firstCellView: UITableViewCell {
    
    static let cell_id = "firstCell"
    
    fileprivate lazy var DescLabelFirst:UILabel = {
        let DescLabelFirst = UILabel.init()
        DescLabelFirst.text = "账号注册"
        DescLabelFirst.textColor = UIColor.black
        DescLabelFirst.font = UIFont.systemFont(ofSize: 14)
        DescLabelFirst.textAlignment = .left
        DescLabelFirst.textColor = UIColor.black
        return DescLabelFirst
    }()
    
    fileprivate lazy var DescLabelSecond:UILabel = {
        let DescLabelSecond = UILabel.init()
        DescLabelSecond.text = "完善个人资料"
        DescLabelSecond.textColor = UIColor.black
        DescLabelSecond.font = UIFont.systemFont(ofSize: 14)
        DescLabelSecond.textAlignment = .left
        DescLabelSecond.textColor = UIColor.lightGray

        return DescLabelSecond
    }()
    
    fileprivate lazy var DescLabelThree:UILabel = {
        let DescLabelThree = UILabel.init()
         DescLabelThree.text = "添加项圈"
        DescLabelThree.textColor = UIColor.black
        DescLabelThree.font = UIFont.systemFont(ofSize: 14)
        DescLabelThree.textAlignment = .left
        DescLabelThree.textColor = UIColor.lightGray

        return DescLabelThree
    }()
    
    fileprivate lazy var DescLabelThird:UILabel = {
        let DescLabelThird = UILabel.init()
        DescLabelThird.text = "添加宠物"
        DescLabelThird.textColor = UIColor.white
        DescLabelThird.font = UIFont.systemFont(ofSize: 14)
        DescLabelThird.textAlignment = .left
        DescLabelThird.textColor = UIColor.lightGray
        return DescLabelThird
    }()
    
    fileprivate lazy var DescLabelSeven:UILabel = {
        let DescLabelThird = UILabel.init()
        DescLabelThird.text = "佩戴项圈"
        DescLabelThird.textColor = UIColor.white
        DescLabelThird.font = UIFont.systemFont(ofSize: 14)
        DescLabelThird.textAlignment = .left
        DescLabelThird.textColor = UIColor.lightGray
        
        return DescLabelThird
    }()
    
    lazy var DescImageFirst:UIImageView = {
    
        let DescImageFirst = UIImageView.init()
        DescImageFirst.image = BGImgView.image(withIcon: "\u{e647}", inFont: "iconfont", size: 50, color: UIColor.black)
        return DescImageFirst
    }()

    lazy var DescImageSecond:UIImageView = {
        
        let DescImageSecond = UIImageView.init()
        DescImageSecond.image = BGImgView.image(withIcon: "\u{e647}", inFont: "iconfont", size: 50, color: UIColor.black)
        return DescImageSecond
    }()

    lazy var DescImageThree:UIImageView = {
        
        let DescImageThree = UIImageView.init()
        DescImageThree.image = BGImgView.image(withIcon: "\u{e647}", inFont: "iconfont", size: 50, color: UIColor.black)
        return DescImageThree
    }()

    lazy var DescImageThird:UIImageView = {
        
        let DescImageThird = UIImageView.init()
        DescImageThird.image = BGImgView.image(withIcon: "\u{e647}", inFont: "iconfont", size: 50, color: UIColor.black)
        return DescImageThird
    }()

    lazy var DescImageSeven:UIImageView = {
        
        let DescImageSeven = UIImageView.init()
        DescImageSeven.image = BGImgView.image(withIcon: "\u{e647}", inFont: "iconfont", size: 50, color: UIColor.black)
        return DescImageSeven
    }()

    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
        self.addSubview(DescLabelFirst)
        self.addSubview(DescLabelSecond)
        self.addSubview(DescLabelThree)
        self.addSubview(DescLabelThird)
        self.addSubview(DescLabelSeven)
        self.addSubview(DescImageFirst)
        self.addSubview(DescImageSecond)
        self.addSubview(DescImageThree)
        self.addSubview(DescImageThird)
        self.addSubview(DescImageSeven)

    }
    
    class func  dequeueReusable(_ tableView:UITableView, indexPath:IndexPath) -> firstCellView {
        var cell = tableView.dequeueReusableCell(withIdentifier: cell_id, for: indexPath) as? firstCellView
        if cell == nil{
            cell = firstCellView(style: UITableViewCellStyle.default, reuseIdentifier: cell_id)
        }
        return cell!
    }

    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        DescLabelFirst.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(self.snp.top).offset(32 * BGH)
            make.left.equalTo(32)
            make.height.equalTo(16 * BGH)
            make.width.equalTo(200)
        }
        
        DescImageFirst.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(self.snp.top).offset(32 * BGH)
            make.right.equalTo(-32)
            make.height.equalTo(16 * BGH)
            make.width.equalTo(16 * BGH)
        }
        
        DescLabelSecond.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(DescLabelFirst.snp.bottom).offset(26 * BGH)
            make.left.equalTo(32)
            make.height.equalTo(16 * BGH)
            make.width.equalTo(200)
        }

        DescImageSecond.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(DescLabelFirst.snp.bottom).offset(26 * BGH)
            make.right.equalTo(-32)
            make.height.equalTo(16 * BGH)
            make.width.equalTo(16 * BGH)
        }



        DescLabelThree.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(DescLabelSecond.snp.bottom).offset(26 * BGH)
            make.left.equalTo(32)
            make.height.equalTo(16 * BGH)
            make.width.equalTo(200)
        }
        
        DescImageThree.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(DescLabelSecond.snp.bottom).offset(26 * BGH)
            make.right.equalTo(-32)
            make.height.equalTo(16 * BGH)
            make.width.equalTo(16 * BGH)
        }


        DescLabelThird.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(DescLabelThree.snp.bottom).offset(26 * BGH)
            make.left.equalTo(32)
            make.height.equalTo(20 * BGH)
            make.width.equalTo(200)
        }
        
        
        
        DescImageThird.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(DescLabelThree.snp.bottom).offset(26 * BGH)
            make.right.equalTo(-32)
            make.height.equalTo(20 * BGH)
            make.width.equalTo(16 * BGH)
        }
        
        
        DescLabelSeven.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(DescLabelThird.snp.bottom).offset(26 * BGH)
            make.left.equalTo(32)
            make.height.equalTo(16 * BGH)
            make.width.equalTo(200)
        }
        
        
        DescImageSeven.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(DescLabelThird.snp.bottom).offset(26 * BGH)
            make.right.equalTo(-32)
            make.height.equalTo(16 * BGH)
            make.width.equalTo(16 * BGH)
        }


    }

}



class secCellView: UITableViewCell {
    
    static let cell_id = "secCell"
    
    fileprivate lazy var DescTitleLabel:UILabel = {
        let DescTitleLabel = UILabel.init()
        DescTitleLabel.text = "个人资料："
        DescTitleLabel.textColor = UIColor.black
        DescTitleLabel.textAlignment = .left
        DescTitleLabel.font = UIFont.systemFont(ofSize: 16 )
        return DescTitleLabel
    }()
    
    
    fileprivate lazy var DescLabelFirst:UILabel = {
        let DescLabelFirst = UILabel.init()
        DescLabelFirst.text = " "
        DescLabelFirst.textColor = UIColor.white
        DescLabelFirst.font = UIFont.systemFont(ofSize: 12 )
        DescLabelFirst.backgroundColor = UIColor.brown
        DescLabelFirst.layer.masksToBounds = true
        DescLabelFirst.textAlignment = .center
        DescLabelFirst.layer.cornerRadius = 2
        return DescLabelFirst
    }()
    
    fileprivate lazy var DescLabelSecond:UILabel = {
        let DescLabelSecond = UILabel.init()
        DescLabelSecond.text = ""
        DescLabelSecond.textColor = UIColor.white
        DescLabelSecond.font = UIFont.systemFont(ofSize: 12)
        DescLabelSecond.backgroundColor = UIColor.brown
        DescLabelSecond.layer.masksToBounds = true
        DescLabelSecond.textAlignment = .center
        DescLabelSecond.layer.cornerRadius = 10
        
        return DescLabelSecond
    }()
    
    fileprivate lazy var DescLabelThree:UILabel = {
        let DescLabelThree = UILabel.init()
        DescLabelThree.text = ""
        DescLabelThree.textColor = UIColor.white
        DescLabelThree.font = UIFont.systemFont(ofSize: 12)
        DescLabelThree.backgroundColor = UIColor.brown
        DescLabelThree.layer.masksToBounds = true
        DescLabelThree.textAlignment = .center
        DescLabelThree.layer.cornerRadius = 10
        return DescLabelThree
    }()
    
    fileprivate lazy var DescLabelThird:UILabel = {
        let DescLabelThird = UILabel.init()
        DescLabelThird.text = ""
        DescLabelThird.textColor = UIColor.white
        DescLabelThird.font = UIFont.systemFont(ofSize: 12 )
        DescLabelThird.backgroundColor = UIColor.brown
        DescLabelThird.layer.masksToBounds = true
        DescLabelThird.textAlignment = .center
        DescLabelThird.layer.cornerRadius = 10
        return DescLabelThird
    }()
    
    fileprivate lazy var sumbinButton:UIButton = {
        
        let sumbinButton = UIButton.init()
        sumbinButton.addTarget(self, action: #selector(nextStepFunction), for: UIControlEvents.touchUpInside)
        sumbinButton.setTitle("完善个人资料", for: UIControlState.normal)
        sumbinButton.setTitleColor(UIColor.white, for: UIControlState.normal)
        sumbinButton.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        sumbinButton.backgroundColor = UIColor.black
        sumbinButton.layer.masksToBounds = true
        sumbinButton.layer.cornerRadius = 2
        return sumbinButton
        
    }()
    
    
    var personalView:BGPersonalView = BGPersonalView.init()
    var addCollarsView:BGAddCollarsView = BGAddCollarsView.init()
    
    var peiDaiView:BGPeiDaiView = BGPeiDaiView.init()
    var addPetView:BGPeiDaiView = BGPeiDaiView.init()
    
    var nextStepFunct:(()->())?
    
    
    func nextStepFunction() {
        self.nextStepFunct?()
    }
    
    

    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
        
        self.addSubview(DescTitleLabel)
        self.addSubview(personalView)
        self.addSubview(sumbinButton)
        self.addSubview(personalView)

        let userNumber = UserDefaults.standard.integer(forKey: "netNumber")
        switch userNumber {
        case 0:break
        case 1:
        personalView.fistLabel.text = "完善个人资料，可以让可点更了解你"
        personalView.lastLabel.text = "点击下方的按钮行动吧"
        personalView.img.image = BGImgView.image(withIcon: "\u{e648}", inFont: "iconfont", size: 300, color: UIColor.black)
        case 2:
            personalView.fistLabel.text = "找到项圈只用说明书上的二维码，通过扫码完成绑定项圈\n如有疑问，请联系客服热线:4007759206"
            personalView.lastLabel.text = "温馨提示：请确定可点职能项圈处于开机状态"
            personalView.img.image = BGImgView.image(withIcon: "\u{e64c}", inFont: "iconfont", size: 300, color: UIColor.black)

        case 3:
      
            personalView.fistLabel.text = "完善宠物资料，可以让可点更好的服务你"
            personalView.lastLabel.text = "您接下来添加的宠物将佩戴此项圈"
            personalView.img.image = BGImgView.image(withIcon: "\u{e640}", inFont: "iconfont", size: 300, color: UIColor.black)


        default:
            personalView.fistLabel.text = "主人，赶快为我佩戴项圈吧"
            personalView.lastLabel.text = "为爱宠将佩戴项圈后直接进入首页"
            personalView.img.image = BGImgView.image(withIcon: "\u{e63c}", inFont: "iconfont", size: 300, color: UIColor.black)



        }

        
//        personalView.dogimg.layer.masksToBounds = true
//        personalView.dogimg.layer.cornerRadius = 33 * BGW
//        personalView.collarsimg.layer.masksToBounds = true
//        personalView.collarsimg.layer.cornerRadius = 40 * BGW

        
    }
    
    class func  dequeueReusable(_ tableView:UITableView, indexPath:IndexPath) -> secCellView {
        var cell = tableView.dequeueReusableCell(withIdentifier: cell_id, for: indexPath) as? secCellView
        if cell == nil{
            cell = secCellView(style: UITableViewCellStyle.default, reuseIdentifier: cell_id)
        }
        return cell!
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        DescTitleLabel.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(self.snp.top).offset(37 * BGH)
            make.left.equalTo(32 * BGW)
            make.height.equalTo(16 * BGH)
            make.width.equalTo(200)
        }
        
        sumbinButton.snp.makeConstraints { (make) -> Void in
            make.bottom.equalTo(self.snp.bottom).offset(-60 * BGH)
            make.height.equalTo(40 * BGH)
            make.right.equalTo(-32 * BGW)
            make.left.equalTo(32 * BGW)
        }
        personalView.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(DescTitleLabel.snp.bottom).offset(0)
            make.bottom.equalTo(sumbinButton.snp.top).offset(0)
            make.left.equalTo(0)
            make.right.equalTo(0)
            
        }
    }
    
}


class BGPersonalView:UIView{
    var fistLabel:UILabel = {
        let label = UILabel.init()
        label.text = "完善个人资料，可以让可点更加了解你"
        label.font = UIFont.systemFont(ofSize: 14)
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping

        label.textColor = UIColor.init(red: 180/255, green: 180/255, blue: 180/255, alpha: 1.0)
        return label
    }()
    
    var lastLabel:UILabel = {
    
        let label = UILabel.init()
        label.text = "点击下方的按钮行动吧"
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = UIColor.init(red: 180/255, green: 180/255, blue: 180/255, alpha: 1.0)
        return label
    }()
    
    var img:UIImageView = {
        let img = UIImageView.init()
        img.image = UIImage.init(named: "tabBar_4")
        return img
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        super.addSubview(fistLabel)
        super.addSubview(img)
        super.addSubview(lastLabel)

    }
    
    convenience init() {
        self.init(frame:CGRect.init(x: 0, y: 0, width: 100, height: 100))
        
    }

    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        super.addSubview(fistLabel)
        super.addSubview(img)
        super.addSubview(lastLabel)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        fistLabel.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(self.snp.top).offset(10 * BGH)
            make.left.equalTo(32 * BGW)
            make.height.equalTo(60 * BGH)
            make.right.equalTo(-32 * BGW)
        }
        
        lastLabel.snp.makeConstraints { (make) -> Void in
            make.bottom.equalTo(self.snp.bottom).offset(-10 * BGH)
            make.center.centerX.equalTo(self.center.x)
            make.height.equalTo(60 * BGH)
            make.right.equalTo(-32 * BGW)
        }//
        
        img.snp.makeConstraints { (make) -> Void in
            make.centerY.equalTo(self.snp.centerY)
            make.centerX.equalTo(self.center.x)
            make.height.equalTo(68 * BGH)
            make.width.equalTo(68 * BGW)
        }


    }
    

}


class BGPeiDaiView:UIView{
    var fistLabel:UILabel = {
        let label = UILabel.init()
        label.text = "主人，赶快为我佩戴项圈吧"
        label.font = UIFont.systemFont(ofSize: 14)
        label.textAlignment = .center
        label.textColor = UIColor.init(red: 180/255, green: 180/255, blue: 180/255, alpha: 1.0)
        return label
    }()
    
    var lastLabel:UILabel = {
        
        let label = UILabel.init()
        label.text = "点击下方的按钮行动吧"
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = UIColor.init(red: 180/255, green: 180/255, blue: 180/255, alpha: 1.0)
        return label
    }()
    
    var dogimg:UIImageView = {
        let imgView = UIImageView.init()
        let img = UIImage.init(named: "tabBar_4")
        imgView.backgroundColor = UIColor.red
        return imgView
    }()
    

    
    override init(frame: CGRect) {
        super.init(frame: frame)
        super.addSubview(fistLabel)
        super.addSubview(lastLabel)
        super.addSubview(dogimg)

        
    }
    
    convenience init() {
        self.init(frame:CGRect.init(x: 0, y: 0, width: 100, height: 100))
        
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        fistLabel.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(self.snp.top).offset(10 * BGH)
            make.left.equalTo(32 * BGW)
            make.height.equalTo(16 * BGH)
            make.width.equalTo(250)
        }
        
        lastLabel.snp.makeConstraints { (make) -> Void in
            make.bottom.equalTo(self.snp.bottom).offset(-10 * BGH)
            make.center.centerX.equalTo(self.center.x)
            make.height.equalTo(16 * BGH)
            make.width.equalTo(200)
        }//img
        
        dogimg.snp.makeConstraints { (make) -> Void in
            make.centerX.equalTo(self.snp.centerX)
            make.centerY.equalTo(self.snp.centerY)
            make.height.equalTo(80 * BGH)
            make.width.equalTo(80 * BGH)
        }
        
        
    }
    
    
}

class BGAddCollarsView:UIView{
    var fistLabel:UILabel = {
        let label = UILabel.init()
        label.text = "找到项圈只用说明书上的二维码，通过扫码完成绑定项圈"
        label.font = UIFont.systemFont(ofSize: 14)
        label.textAlignment = .left
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.numberOfLines = 0
        
        label.textColor = UIColor.init(red: 180/255, green: 180/255, blue: 180/255, alpha: 1.0)
        return label
    }()
    

    
    
    var secLabel:UILabel = {
        let label = UILabel.init()
        label.text = "如有疑问，请联系客服热线:"
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = UIColor.init(red: 180/255, green: 180/255, blue: 180/255, alpha: 1.0)
        return label
    }()
    
    var phoneLabel:UILabel = {
        
        let label = UILabel.init()
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = UIColor.black
        label.lineBreakMode = .byWordWrapping
        var attrs = [NSUnderlineStyleAttributeName : 1]
        var String = NSMutableAttributedString(string:"4007759206", attributes:attrs)
        label.attributedText = String
        return label
    }()
    
    var dogimg:UIImageView = {
        let imgView = UIImageView.init()
        let img = UIImage.init(named: "tabBar_4")
        imgView.backgroundColor = UIColor.red
        return imgView
    }()
    
    var lastLabel:UILabel = {
        
        let label = UILabel.init()
        label.text = "温馨提示：请确定可点智能宠物项圈处于开机状态"
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = UIColor.init(red: 180/255, green: 180/255, blue: 180/255, alpha: 1.0)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        super.addSubview(fistLabel)
        super.addSubview(secLabel)
        super.addSubview(phoneLabel)
        super.addSubview(dogimg)
        super.addSubview(lastLabel)
    }
    
    convenience init() {
        self.init(frame:CGRect.init(x: 0, y: 0, width: SCREENW, height: 341 * BGH))
        
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        fistLabel.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(8 * BGH)
            make.left.equalTo(32 * BGW)
            make.height.equalTo(16 * BGH)
            make.width.equalTo(SCREENW - 64 * BGW)
        }
        
        secLabel.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(fistLabel.snp.bottom).offset(8 * BGH)
            make.left.equalTo(32 * BGW)
            make.height.equalTo(16 * BGH)
            make.width.equalTo(180)
        }
        
//        
//        phoneLabel.snp.makeConstraints { (make) -> Void in
//            make.top.equalTo(fistLabel.snp.bottom).offset(8 * BGH)
//            make.left.equalTo(secLabel.snp.right).offset(0)
//            make.height.equalTo(16 * BGH)
//            make.width.equalTo(100)
//            
//        }
//        
//        dogimg.snp.makeConstraints { (make) -> Void in
//            make.centerX.equalTo(self.snp.centerX)
//            make.top.equalTo(secLabel.snp.bottom).offset(18 * BGH)
//            make.height.equalTo(66 * BGW)
//            make.width.equalTo(66 * BGW)
//        }
//        
//        lastLabel.snp.makeConstraints { (make) -> Void in
//            make.centerX.equalTo(self.snp.centerX)
//            make.top.equalTo(dogimg.snp.bottom).offset(17 * BGH)
//            make.height.equalTo(16 * BGW)
//            make.width.equalTo(270)
//        }
    }
}



