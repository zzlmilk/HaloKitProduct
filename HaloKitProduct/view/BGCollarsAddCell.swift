//
//  BGCollarsAddCell.swift
//  HaloKitProduct
//
//  Created by 范博 on 2017/7/12.
//  Copyright © 2017年 范博. All rights reserved.
//

import UIKit
import SDWebImage
class BGCollarsAddCell: UITableViewCell {

    @IBOutlet weak var DogIconView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var cateryLabel: UILabel!
    @IBOutlet weak var ageLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        let img = UIImage.init(named: "beach")
        DogIconView.image = img?.roundCornersToCircle()

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    var data:BGPetsInfoModel = BGPetsInfoModel(){
        
        didSet{
            nameLabel.text = data.nickname
            let imageUrl = URL.init(string:data.imagePath)
            DogIconView.sd_setImage(with: imageUrl, placeholderImage: UIImage(named:"tabBar_1"))
            let start1 = data.birthday.index(data.birthday.startIndex, offsetBy: 10)

            cateryLabel.text = data.birthday.substring(to: start1)
            ageLabel.text = data.breedId
        }
    }

    
}
