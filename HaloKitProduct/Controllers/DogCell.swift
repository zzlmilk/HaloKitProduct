//
//  DogCell.swift
//  HaloKitProduct
//
//  Created by 范博 on 2017/7/31.
//  Copyright © 2017年 范博. All rights reserved.
//

import UIKit

class DogCell: UITableViewCell {
    @IBOutlet weak var dogIcon: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var sexImg: UIImageView!
    
    @IBOutlet weak var dogLabel: UILabel!
    
    @IBOutlet weak var weightLabel: UILabel!
    
    @IBOutlet weak var ageLabel: UILabel!
    var cellHeight:CGFloat = 350
    var descLabel:UILabel = {
        var descLabel = UILabel.init()
        descLabel.font = UIFont.systemFont(ofSize: 14)
        descLabel.numberOfLines = 0;
        descLabel.lineBreakMode = NSLineBreakMode.byWordWrapping
        descLabel.textColor = UIColor.lightGray
        return descLabel
    }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.addSubview(descLabel)
        let img = UIImage.init(named: "tabBar_1")
        dogIcon.image = img?.roundCornersToCircle()
        self.contentView.layer.masksToBounds = true
        self.contentView.layer.cornerRadius = 5

        self.layer.masksToBounds = true
        self.layer.cornerRadius = 5

    }
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    var data:BGPetsInfoModel = BGPetsInfoModel(){
        didSet{
            descLabel.text = "        " + data.introduced
            nameLabel.text = data.nickname
            let imageUrl = URL.init(string:data.imagePath)
            dogIcon.sd_setImage(with: imageUrl, placeholderImage: UIImage(named:"tabBar_1"))
            dogIcon.layer.masksToBounds = true
            dogIcon.layer.cornerRadius = 50
            dogLabel.text = data.breed
            weightLabel.text = data.weight
            ageLabel.text = "5岁"
            if data.sex == "1" {
                sexImg.image = UIImage.init(named: "sex_man")
            }else{
                sexImg.image = UIImage.init(named: "sex_woman")
            }
            
        }
    }
    

    
}
