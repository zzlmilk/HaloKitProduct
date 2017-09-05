//
//  BGCollarsAddButtomCell.swift
//  HaloKitProduct
//
//  Created by 范博 on 2017/7/13.
//  Copyright © 2017年 范博. All rights reserved.
//

import UIKit

class BGCollarsAddButtomCell: UITableViewCell {
    
    var addPetsAct:(() -> ())?
    
    @IBOutlet weak var addPetsBtn: UIButton!
    @IBAction func addPetsAction(_ sender: UIButton) {
        self.addPetsAct?()
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        addPetsBtn.layer.cornerRadius = 5
        addPetsBtn.layer.masksToBounds = true
        addPetsBtn.setTitleColor(UIColor.white, for: UIControlState.normal)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
