//
//  BGPersonalInfoCell.swift
//  HaloKitProduct
//
//  Created by 范博 on 2017/6/29.
//  Copyright © 2017年 范博. All rights reserved.
//

import UIKit

class BGPersonalInfoheadIconCell: UITableViewCell {

    static let cell_id = "PersonalInfoCell"

    
    lazy var heagImgView : UIImageView = {
        
        var imgView = UIImageView.init()
        imgView.image = UIImage(named: "beach")?.roundCornersToCircle()

        let tapGestureRecognizer = UIGestureRecognizer.init(target: self, action: #selector(BGPersonalInfoOthersCell.clickImgFunction))
        imgView.addGestureRecognizer(tapGestureRecognizer)
        return imgView
    
    }()
    
    lazy var titleLabel  : UILabel = {
        var titleLabel = UILabel()
        titleLabel.text = "TOUXIANG"
        return titleLabel
    }()
    
    class func  dequeueReusable(_ tableView:UITableView, indexPath:IndexPath) -> BGPersonalInfoheadIconCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: cell_id, for: indexPath) as? BGPersonalInfoheadIconCell
        if cell == nil{
            cell = BGPersonalInfoheadIconCell(style: UITableViewCellStyle.default, reuseIdentifier: cell_id)
        }

        cell?.accessoryType  = .disclosureIndicator
        return cell!
    }
    
    class func returnCell_hight() -> CGFloat{
        return 80
    }
    

    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
        self.contentView.addSubview(heagImgView)
        self.contentView.addSubview(titleLabel)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        heagImgView.snp.makeConstraints { (make) -> Void in
            make.left.equalTo(16)
            make.top.equalTo(10)
            make.width.height.equalTo(60)
        }
        
        titleLabel.snp.makeConstraints { (make) -> Void in
            make.left.equalTo(56)
            make.top.equalTo(35)
            make.width.height.equalTo(10)
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





class BGPersonalInfoOthersCell: UITableViewCell {
    
    static let OthersCell_id = "InfoOthersCell"

    lazy var heagImgView : UIImageView = {
        
        var imgView = UIImageView.init()
        return imgView
        
    }()

    lazy var titleLabel  : UILabel = {
        var titleLabel = UILabel()
        titleLabel.font = UIFont.systemFont(ofSize: 12)
        titleLabel.text = "titleLabel"

        return titleLabel
    }()
    
    lazy var cententLabel  : UILabel = {
        var cententLabel = UILabel()
        cententLabel.font = UIFont.systemFont(ofSize: 12)
        cententLabel.text = "NIHAO"
        return cententLabel
    }()

    
    class func  dequeueReusable(_ tableView:UITableView, indexPath:IndexPath) -> BGPersonalInfoOthersCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: OthersCell_id, for: indexPath) as? BGPersonalInfoOthersCell
        if cell == nil{
            cell = BGPersonalInfoOthersCell(style: UITableViewCellStyle.default, reuseIdentifier: OthersCell_id)

        }
        cell?.accessoryType  = .disclosureIndicator
        return cell!
    }
    
    class func returnCell_hight() -> CGFloat{
        return 44
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
        self.contentView.addSubview(heagImgView)
        self.contentView.addSubview(titleLabel)
        self.contentView.addSubview(cententLabel)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var model:BGUserModel = BGUserModel() {
        didSet{
            // heagImgView.image =
            // titleLabel.text =
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        heagImgView.snp.makeConstraints { (make) -> Void in
            make.left.equalTo(16)
            make.top.equalTo(20)
            make.width.height.equalTo(4)
            self.heagImgView.backgroundColor = UIColor.lightGray
            self.heagImgView.layer.borderWidth = 1
            self.heagImgView.layer.cornerRadius = 1
            self.heagImgView.layer.masksToBounds = true
            self.heagImgView.layer.borderColor = UIColor.lightGray.cgColor

        }
        
        titleLabel.snp.makeConstraints { (make) -> Void in
            make.left.equalTo(25)
            make.top.equalTo(12)
            make.width.equalTo(100)
            make.height.equalTo(20)

        }
        
        cententLabel.snp.makeConstraints { (make) -> Void in
            make.right.equalTo(-25)
            make.top.equalTo(12)
            make.width.equalTo(100)
            make.height.equalTo(20)
        }
        
    }

    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func clickImgFunction(){
        
    }
    
    
//    private func tapToShowAlert(){
//        let titleImage = NSLocalizedString("Waiting image", comment:"待机图片")
//        let titleTakepho = NSLocalizedString("Take photos", comment:"拍照")
//        let titleSelect = NSLocalizedString("Select from the album", comment:"从相册中选取")
//        let titleCancel = NSLocalizedString("Cancel", comment:"取消")
//        let message = ""
//        
//        let changeHoldImageAlert = UIAlertController.createAlertView(titleImage, message: message)
//        changeHoldImageAlert.addAlertAction(titleTakepho) { (alert) in
//            if UIImagePickerController.isSourceTypeAvailable(.Camera){
//                self.portraitImagePicker.sourceType = .Camera
//                self.portraitImagePicker.delegate = self
//                self.portraitImagePicker.mediaTypes = [kUTTypeImage as String]
//                self.portraitImagePicker.allowsEditing = false
//                self.portraitImagePicker.showsCameraControls = true
//                self.presentViewController(self.portraitImagePicker, animated: true, completion: nil)
//            }
//        }
//        
//        changeHoldImageAlert.addAlertAction(titleSelect) { (alert) in
//            if UIImagePickerController.isSourceTypeAvailable(.PhotoLibrary){
//                self.portraitImagePicker.sourceType = .PhotoLibrary
//                self.portraitImagePicker.delegate = self
//                self.portraitImagePicker.mediaTypes = [kUTTypeImage as String]
//                self.portraitImagePicker.allowsEditing = false
//                self.presentViewController(self.portraitImagePicker, animated: true, completion: nil)
//                
//            }
//        }
//        
//        changeHoldImageAlert.addCancelAlertAction(titleCancel, handler: nil)
//        presentViewController(changeHoldImageAlert, animated: true, completion: nil)
//        
//    }

    
}

