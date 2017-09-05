//
//  BCCollarsHeaderInfoView.swift
//  HaloKitProduct
//
//  Created by 范博 on 2017/7/12.
//  Copyright © 2017年 范博. All rights reserved.
//

import UIKit

class BCCollarsHeaderInfoView: UIView {
    var usingAct:(() -> ())?
    @IBOutlet weak var usingBtn: UIButton!
    @IBAction func usingAction(_ sender: Any) {
        self.usingAct?()
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        usingBtn.layer.masksToBounds = true
        usingBtn.layer.cornerRadius = 2
    }

}
