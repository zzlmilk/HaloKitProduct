//
//  DeviceViewCell.swift
//  HaloKitProduct
//
//  Created by 范博 on 2017/7/31.
//  Copyright © 2017年 范博. All rights reserved.
//

import UIKit

class DeviceViewCell: UITableViewCell {
    var shiyongAct:(() -> ())?
    var deviceAct:(() -> ())?

    @IBOutlet weak var deviceIcon: UIImageView!
    @IBOutlet weak var deviceIdLabel: UILabel!
    @IBOutlet weak var shiyongBtn: UIButton!
    @IBAction func shiyongAction(_ sender: Any) {
        self.shiyongAct?()
    }
    @IBOutlet weak var deviceBtn: UIButton!
    @IBAction func deviceAction(_ sender: Any) {
        self.deviceAct?()
    }
    @IBOutlet weak var dogHeadIcon: UIImageView!
    
    @IBOutlet weak var buttomshiyongBtn: UIView!
    @IBOutlet weak var peidaiLabel: UILabel!
    
    
    var data:BGDevices_devicesModel = BGDevices_devicesModel(){
        didSet{
            deviceIdLabel.text = "项圈ID：" + data.deviceID
            
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        self.contentView.layer.masksToBounds = true
        self.contentView.layer.cornerRadius = 10
        deviceIcon.image = BGImgView.image(withIcon: "\u{e656}", inFont: "iconfont", size: 300, color: UIColor.black)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func draw(_ rect: CGRect) {
        //切左上右上圆角
        let maskPath = UIBezierPath(roundedRect:self.bounds, byRoundingCorners: [.topLeft,.topRight,.bottomLeft,.bottomRight], cornerRadii: CGSize(width: 10.0, height: 10.0))
        let maskLayer = CAShapeLayer()
        maskLayer.frame = self.bounds
        maskLayer.path = maskPath.cgPath
        self.layer.mask = maskLayer
        
        //添加border
        let borderLayer = CAShapeLayer()
        borderLayer.frame = self.bounds
        borderLayer.path = maskPath.cgPath
        borderLayer.lineWidth = 1.0
        borderLayer.strokeColor = UIColor.lightGray.cgColor
        borderLayer.fillColor = UIColor.clear.cgColor
        
        let layers:NSArray = self.layer.sublayers! as NSArray
        
        if (((layers.lastObject! as AnyObject).isKind(of: CAShapeLayer.classForCoder()))){
            (layers.lastObject as AnyObject).removeFromSuperlayer()
        }
        self.layer.addSublayer(borderLayer)
        
    }
    
    
}
