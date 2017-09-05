//
//  BGSettingBttomCell.swift
//  HaloKitProduct
//
//  Created by 范博 on 2017/7/25.
//  Copyright © 2017年 范博. All rights reserved.
//

import UIKit

class BGSettingBttomCell: UITableViewCell {
    var exitenAct:(() ->())?
    @IBOutlet weak var exitBtn: UIButton!
    @IBAction func exitenAction(_ sender: UIButton) {
        self.exitenAct?()
        
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.exitBtn.layer.masksToBounds = true
        self.exitBtn.layer.cornerRadius = 5
        self.isHidden = true
        self.backgroundColor = UIColor.init(red: 234/255.0, green: 235/255.0, blue: 236/255.0, alpha: 1.0)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
