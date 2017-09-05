//
//  LoginView.swift
//  HaloKitProduct
//
//  Created by 范博 on 2017/7/4.
//  Copyright © 2017年 范博. All rights reserved.
//

import UIKit

let SCREENW = UIScreen.main.bounds.width
let SCREENH = UIScreen.main.bounds.height

let BGW = SCREENW/375
let BGH = SCREENH/667

enum BTNCOLOR {
    case Color1
    case Color2
    case Color3
    
    func selectedColor() -> UIColor {
        switch self {
        case .Color1:
            return UIColor.blue
        case .Color2:
            return UIColor.white
        case .Color3:
            return UIColor.black
        }
        
    }
}



class LoginView: UIView {
    
    var descriptionStr: String? = nil
    var finished:(() -> ())? = nil
    
    class func newView(descriptionStr:String? = nil,finishBlock:(() -> ())? = nil) -> LoginView {
        return LoginView.init(descriptionStr:descriptionStr, finishBlock: finishBlock)
    }

    convenience init(descriptionStr:String? = nil, finishBlock:(() -> ())? = nil) {
        self.init(frame: CGRect.zero)
        self.finished = finishBlock
        self.descriptionStr = descriptionStr
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    var navBackBtn:UIButton {
        let navBackBtn = UIButton.init()
        navBackBtn.setImage(UIImage(named:"navBack"), for: UIControlState.normal)
        navBackBtn.addTarget(superview, action: #selector(backFunction), for: .touchUpInside)
        return navBackBtn
    }
    
    func backFunction(){
        self.finished?()
    }
    
    var titleLabel:UILabel {
        let titleLabel = UILabel.init()
        titleLabel.text = self.descriptionStr
        titleLabel.textAlignment = .left
        titleLabel.font = UIFont.systemFont(ofSize: 15)
        return titleLabel
    }
    
    
    var titleDescLabel:UILabel  {
        let titleDescLabel = UILabel.init()
        titleDescLabel.text = self.descriptionStr
        titleDescLabel.textAlignment = .left
        titleDescLabel.font = UIFont.systemFont(ofSize: 12)
        return titleDescLabel
    }
    

    
    var submitBtn:UIButton  {
        let submitBtn = UIButton.init()
        submitBtn.setTitle(self.descriptionStr, for: .normal)
        submitBtn.setTitleColor(UIColor.black, for: .normal)
        submitBtn.backgroundColor = UIColor(red: 237/255.0, green: 235/255.0, blue: 231/255.0, alpha: 1.0)
        submitBtn.addTarget(self, action: #selector(submitFaction), for: .touchUpInside)
        return submitBtn
    }
    
    var inputTextField:UITextField  {
        let phoneInput = UITextField.init()
        phoneInput.placeholder = self.descriptionStr
        phoneInput.layer.borderWidth = 2
        phoneInput.layer.cornerRadius = 5
        phoneInput.layer.masksToBounds = true
        phoneInput.layer.borderColor = UIColor.brown.cgColor
        phoneInput.leftView?.backgroundColor = UIColor.red
        let NameLeftView:UIView=UIView(frame: CGRect(x:0, y:0, width:40, height:40));
        phoneInput.clearButtonMode=UITextFieldViewMode.whileEditing
        phoneInput.leftViewMode = UITextFieldViewMode.always
        let namePic:UIImageView=UIImageView(frame: CGRect(x:5, y:5, width:20,height: 30));
        namePic.image=UIImage(named: "phone");
        NameLeftView.addSubview(namePic);
        phoneInput.leftView = NameLeftView;
        return phoneInput
    }
    
    
    var secreTextField : UITextField{
        let phoneInput = UITextField.init()
        phoneInput.layer.borderWidth = 2
        phoneInput.layer.cornerRadius = 5
        phoneInput.layer.masksToBounds = true
        phoneInput.layer.borderColor = UIColor.brown.cgColor
        phoneInput.leftView?.backgroundColor = UIColor.red
        return phoneInput
    }
    
    
    func submitFaction(){
        self.finished?()
    }

    
}


