//
//  BGDogInfoCell.swift
//  HaloKitProduct
//
//  Created by 范博 on 2017/7/12.
//  Copyright © 2017年 范博. All rights reserved.
//

import UIKit

class BGDogInfoCell: UITableViewCell {
    
    let imgView = UIImageView.init()

    var dogBoundAct:(() -> ())?

    @IBOutlet weak var dogNameLabel: UILabel!
    
    @IBOutlet weak var DogIconView: UIImageView!

    @IBOutlet weak var dogBoundingBtn: UIButton!
    
    @IBAction func dogBoundAction(_ sender: UIButton) {
        self.dogBoundAct?()
    }
    var data:BGDevices_devicesModel = BGDevices_devicesModel(){
        didSet{
        
            dogNameLabel.text = data.nickname
            debugPrint("data.nickname:", data.nickname)
            imgView.sd_setImage(with: URL(string:self.data.imagePath ), placeholderImage: UIImage.init(named: "tabBar_1")!)
            self.DogIconView.image = imgView.image?.roundCornersToCircle()

            
        }
    
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        let img = UIImage.init(named: "tabBar_1")
        DogIconView.image = img?.roundCornersToCircle()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
