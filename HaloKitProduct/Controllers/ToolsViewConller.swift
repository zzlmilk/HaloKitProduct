//
//  ToolsViewConller.swift
//  HaloKitProduct
//
//  Created by 范博 on 2017/7/10.
//  Copyright © 2017年 范博. All rights reserved.
//

import UIKit
import SwiftyJSON
class ToolsViewConller: UITableViewController, LQPhotoPickerViewDelegate {
    var userID = ""
    let netWork:HttpRequest = HttpRequest.sharedInstance()
    var token = ""
    var headerImg:UIImage? = nil

    lazy var headerView:UIView = {
        let headerView = UIView(frame:CGRect(x:0, y:0, width:self.tableView.frame.size.width, height:10))
        let headerlabel:UILabel = UILabel(frame: headerView.bounds)
        headerlabel.textColor = UIColor.black
        headerlabel.backgroundColor = UIColor.init(red: 240/255.0, green: 240/255.0, blue: 240/255.0, alpha: 1.0)
        return headerView
    }()
    
    lazy var headerView2:UIView = {
        let headerView = UIView(frame:CGRect(x:0, y:0, width:self.tableView.frame.size.width, height:10))
        let headerlabel:UILabel = UILabel(frame: headerView.bounds)
        headerlabel.textColor = UIColor.black
        headerlabel.backgroundColor = UIColor.init(red: 240/255.0, green: 240/255.0, blue: 240/255.0, alpha: 1.0)
        headerlabel.font = UIFont.systemFont(ofSize: 15)
        headerlabel.text = ""
        headerView.addSubview(headerlabel)
        return headerView
    }()
    
    lazy var headerView3:UIView = {
        let headerView = UIView(frame:CGRect(x:0, y:0, width:self.tableView.frame.size.width, height:10))
        let headerlabel:UILabel = UILabel(frame: headerView.bounds)
        headerlabel.textColor = UIColor.black
        headerlabel.backgroundColor = UIColor.init(red: 240/255.0, green: 240/255.0, blue: 240/255.0, alpha: 1.0)
        headerlabel.font = UIFont.systemFont(ofSize: 15)
        headerlabel.text = ""
        headerView.addSubview(headerlabel)
        return headerView
    }()



    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "我的"
        
        userID = UserDefaults.standard.string(forKey: "userID")!
        self.tableView.separatorStyle = .none
        self.tableView.register(BGToolsInfoheadIconCell.classForCoder(), forCellReuseIdentifier: BGToolsInfoheadIconCell.cell_id)
        self.tableView.register(SecondToolsCellView.classForCoder(), forCellReuseIdentifier: SecondToolsCellView.cell_id)
        if let _ = UserDefaults.standard.string(forKey: "token"){
            token = UserDefaults.standard.string(forKey: "token")!
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let imgUrl = UserDefaults.standard.string(forKey: "profile_image_url")
        headerImg = UIImage.image(fromURL:imgUrl! , placeholder:UIImage.init(named:  "tabBar_1")!, closure: { (image) in
            self.headerImg = image
            self.tableView.reloadData()
        })

    }
    
    
    var cell_H:CGFloat = 100
  

    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 3
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        switch section {
        case 0:            return 1
        case 1:            return 1
        default:           return 2
        }
        
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        switch section {
        case 0:
            return headerView
        case 1:
            return headerView2
        default:
            
            return headerView3
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 0:
            return BGToolsInfoheadIconCell.returnCell_hight()
        case 1:
            return 50
        default:
            if indexPath.row == 0{
                return 50

            }else{
                return 200

            }
        }
        
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        switch section {
        case 0:
            return 10
        case 1:
            return 10
        default:
            return 10
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.tableView.reloadData()
        switch indexPath.section {
        case 0: BGPersonalInfoVC.push(self, userID: self.userID, source: "1")
        case 1:
            self.getGogList()
        default:
            if indexPath.row == 0{
                
                BGSettingVc.push(self, param:nil)
                
            }else{
                
            }
        }
    }

    private lazy var photoVC:LQPhotoPickerViewController = {
        let vc = LQPhotoPickerViewController()
        self.addChildViewController(vc)
        return vc
    }()
    
    func lqPhotoPicker_pickerViewFrameChanged() {
        guard photoVC.lqPhotoPicker_getSmallImageArray().count > 0 else {
            return
        }
        let num = photoVC.lqPhotoPicker_getSmallImageArray().count + 1
        let hh = CGFloat(num/4 + (num%4==0 ? 0 : 1)) * ((SCREENW-64)/4 + 16)
        cell_H = hh
        self.tableView.beginUpdates()
        self.tableView.endUpdates()
    }
    
    

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {

        case 0:
            let cell = BGToolsInfoheadIconCell.dequeueReusable(tableView, indexPath: indexPath)
            cell.heagImgView.image = headerImg?.roundCornersToCircle()
            if let name = UserDefaults.standard.string(forKey: "nickname"){
                cell.titleLabel.text = name
            }
            return cell

        case 1:
            let cell = UITableViewCell.init(style: .default, reuseIdentifier: "124")
            cell.textLabel?.text = "我的宠物"
            cell.accessoryType = .disclosureIndicator
            return cell
        default:
            
            if indexPath.row == 0{
                
                let cell = UITableViewCell.init(style: .default, reuseIdentifier: "123")
                cell.textLabel?.text = "设置"
                cell.accessoryType = .disclosureIndicator
                return cell
                
            }else{
                
                let cell = UITableViewCell.init(style: .default, reuseIdentifier: "123")
                cell.backgroundColor = UIColor.init(red: 240/255.0, green: 240/255.0, blue: 240/255.0, alpha: 1.0)
                return cell
 
                
            }
            
        }
    }

}

extension ToolsViewConller{
    
    func getGogList(){
        let url = RBRequestFunction.User.获取宠物列表.urlString
        
        netWork.getHeader(url, dict: nil, andHeader: token, succeed: { (respone) in
            
            let dataJson = JSON(respone!)
            if dataJson["code"] == 1{
                let datas = BGPetsModel.init(fromJson:JSON(respone!)) as BGPetsModel
                let bgDogVc = BGDogVC()
                bgDogVc.dogCatory = .editList
                bgDogVc.petsInfoList = datas.petsInfoModel
                self.navigationController?.pushViewController(bgDogVc, animated: true)
            }
            
            
        }) { (error) in
            debugPrint("error:",error ?? "NULL")
            
        }
        
        
    }
}

extension UITableViewCell {
    
    class func nullCell(_ tableView:UITableView, indexPath:IndexPath, cellId:String = "CellID_null", removeSubViews:Bool = true, bottomLineHidden:Bool = false) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: cellId)
        if (cell == nil)
        {
            cell = UITableViewCell(style: .subtitle, reuseIdentifier: cellId)

        }
        
        if removeSubViews {
            for  view in cell!.contentView.subviews {
                view.removeFromSuperview()
            }
        }
        cell!.selectionStyle = .none
        cell?.backgroundColor = UIColor.white
        if !bottomLineHidden {
            //UIView.xzSetLineView(cell!, placeType: .bottom)
        }
        return cell!
    }
    
}


class BGToolsInfoheadIconCell: UITableViewCell{
    
    static let cell_id = "PersonalInfoCell"
    
    lazy var heagImgView : UIImageView = {
        var imgView = UIImageView.init()
        let tapGestureRecognizer = UIGestureRecognizer.init(target: self, action: #selector(BGToolsInfoheadIconCell.clickImgFunction))
        imgView.addGestureRecognizer(tapGestureRecognizer)
        return imgView
        
    }()
    
    
    func clickImgFunction(){
    }
    
    lazy var titleLabel  : UILabel = {
        var titleLabel = UILabel()
        titleLabel.text = "可点"
        titleLabel.font = UIFont.systemFont(ofSize: 14)
        titleLabel.textAlignment = .center
        return titleLabel
    }()
    
    lazy var lineView:UIView = {
    
        var lineView = UIView.init()
        lineView.backgroundColor = UIColor.black
        return lineView
    }()
    
    
    class func  dequeueReusable(_ tableView:UITableView, indexPath:IndexPath) -> BGToolsInfoheadIconCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: cell_id, for: indexPath) as? BGToolsInfoheadIconCell
        if cell == nil{
            cell = BGToolsInfoheadIconCell(style: UITableViewCellStyle.default, reuseIdentifier: cell_id)
        }
        
        return cell!
    }
    
    class func returnCell_hight() -> CGFloat{
        return 230
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
        self.contentView.addSubview(heagImgView)
        self.contentView.addSubview(titleLabel)
        self.contentView.addSubview(lineView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        heagImgView.snp.makeConstraints { (make) -> Void in
            make.centerX.equalTo(self.center.x)
            make.top.equalTo(38)
            make.height.width.equalTo(100 * BGW)
        }
        
        titleLabel.snp.makeConstraints { (make) -> Void in
            make.centerX.equalTo(self.center.x)
            make.top.equalTo(heagImgView.snp.bottom).offset(30)
            make.height.equalTo(10)
            make.width.equalTo(200)
        }
        
        lineView.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(titleLabel.snp.bottom).offset(8)
            make.height.equalTo(1)
            make.centerX.equalTo(self.center.x)
            make.width.equalTo(160 * BGW)
        }
        
        
    }
    
    
    
    
    var model:BGUserModel = BGUserModel() {
        didSet{
            //            heagImgView.image =
            //            titleLabel.text =
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    
}



class SecondToolsCellView:UITableViewCell{
    
    lazy var lightView:UIImageView = {
        let lightView = UIImageView()
        lightView.image = UIImage.init(named: "openLight")
        return lightView
    }()
    
    lazy var moreView:UIImageView = {
        let lightView = UIImageView()
        lightView.image = UIImage.init(named: "more")
        return lightView
    }()

    
    static let cell_id = "SecondToolsCell"
    
    lazy var lightLabel:UILabel = {
        let lightLabel = UILabel()
        lightLabel.text = "意见反馈"
        lightLabel.font = UIFont.systemFont(ofSize: 14)
        return lightLabel
    }()
    
    class func cellHeight() -> CGFloat {
        return 44
    }
    
    class func  dequeueReusable(_ tableView:UITableView, indexPath:IndexPath) -> SecondToolsCellView {
   
       let  cell = SecondToolsCellView(style: UITableViewCellStyle.default, reuseIdentifier: cell_id)
        cell.accessoryType = .disclosureIndicator
        return cell
    }
    
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.addSubview(lightView)
        self.addSubview(lightLabel)
        self.addSubview(moreView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        lightView.snp.makeConstraints { (make) -> Void in
            make.width.equalTo(25 * BGW)
            make.height.equalTo(25 * BGH)
            make.top.equalTo(13)
            make.left.equalTo(16)
        }
        
        lightLabel.snp.makeConstraints { (make) -> Void in
            make.height.equalTo(30 * BGH)
            make.width.equalTo(80 * BGW)
            make.top.equalTo(13)
            make.left.equalTo(lightView.snp.right).offset(10)
        }
        
        self.moreView.frame = CGRect(x: self.bounds.width - 16 ,y:17.5, width:8, height:15)
    }
    
 
    
}



