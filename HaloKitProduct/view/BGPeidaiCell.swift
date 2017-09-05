//
//  BGPeidaiCell.swift
//  HaloKitProduct
//
//  Created by 范博 on 2017/7/20.
//  Copyright © 2017年 范博. All rights reserved.
//

import UIKit

class BGPeidaiCell: UITableViewCell {
    var peidaiBtnAction:(() -> ())?
    @IBOutlet weak var desprictionLabel: UILabel!
    @IBOutlet weak var peidaiBtn: UIButton!
    @IBAction func peidaiBtnAct(_ sender: Any) {
        self.peidaiBtnAction?()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
