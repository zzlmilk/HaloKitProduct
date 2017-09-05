//
//  BGCollarHeaderInfoCell.swift
//  HaloKitProduct
//
//  Created by 范博 on 2017/7/12.
//  Copyright © 2017年 范博. All rights reserved.
//

import UIKit

class BGCollarHeaderInfoCell: UITableViewCell {
    @IBOutlet weak var callorsIdString: UILabel!
    var usingAct:((_ type:String) -> ())?
    
    @IBAction func usingAction(_ sender: Any) {
        if data.type == "1"{
            self.usingAct?("1")

        }else if data.type == "0"{
            self.usingAct?("0")

            
        }else{
            self.usingAct?("-1")

        }
    }
    
    @IBOutlet weak var usingBtn: UIButton!

    var data:BGDevices_devicesModel = BGDevices_devicesModel(){
        didSet{
            callorsIdString.text = data.deviceID
            
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        usingBtn.layer.masksToBounds = true
        usingBtn.layer.cornerRadius = 2
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
        // Configure the view for the selected state
    }
    
}
