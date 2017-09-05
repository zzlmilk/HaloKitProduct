//
//  BGNoPetsView.swift
//  HaloKitProduct
//
//  Created by 范博 on 2017/7/13.
//  Copyright © 2017年 范博. All rights reserved.
//

import UIKit

class BGNoPetsView: UIView {
    var addPetAct:(() -> ())?

    @IBOutlet weak var petBtn: UIButton!

    
    @IBAction func addPetAction(_ sender: Any) {
        self.addPetAct?()
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        petBtn.layer.masksToBounds = true
        petBtn.layer.cornerRadius = 5

    }

}
