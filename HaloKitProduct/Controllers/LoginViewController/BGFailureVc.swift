//
//  BGPeiDaiVc.swift
//  HaloKitProduct
//
//  Created by 范博 on 2017/7/26.
//  Copyright © 2017年 范博. All rights reserved.
//

import UIKit

enum failureCatory {
    case invild
    case used
}

class BGFailureVc: UIViewController{
    
    var bangdingView = BGyibangdingView()
    var failureView = BGFailScanView.init(frame:CGRect(x:0,y:0,width:100,height:100))

    var catory:failureCatory = .invild
    
    class func initVC(param:String? = nil) -> BGFailureVc{
        return BGFailureVc.init(param: param)
    }
    
    
    init(param: String?) {
        super.init(nibName: nil, bundle: nil)
        if param == "1" {//无效的设备号
        
            catory = .invild
        }else if param == "2" {
            catory = .used        
        }
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    class func push(_ parentVC:UIViewController?, param:String? = nil, param1:String?) {
        let vc = BGFailureVc.initVC(param:param)
        parentVC?.navigationController?.pushViewController(vc, animated: true)
    }


    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "绑定项圈"
        let leftBarBtn = UIBarButtonItem(title: "", style: .plain, target: self, action: #selector(backToPrevious))
        leftBarBtn.image = UIImage(named: "navBack")
        leftBarBtn.tintColor = UIColor.black
        self.navigationItem.leftBarButtonItem = leftBarBtn
        self.view.backgroundColor = UIColor.white
        switch catory {
        case .invild:
            
            failureView.nextStepAct = {
                for vc in (self.navigationController?.childViewControllers)!{
                    if vc.isKind(of: BGAddPetVC.classForCoder()){
                        debugPrint("Scan_VCScan_VC")
                        self.navigationController?.popToViewController(vc, animated: true)
                    }
                }
            }
            self.view.addSubview(failureView)

        default:
            self.view.addSubview(bangdingView)

        }
    }
    
    
    func backToPrevious() {
        for vc in (self.navigationController?.childViewControllers)!{
            if vc.isKind(of: BGAddPetVC.classForCoder()){
                debugPrint("Scan_VCScan_VC")
                self.navigationController?.popToViewController(vc, animated: true)
            }
        }
    }
    


    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        switch catory {
        case .invild:
            debugPrint("failureView:",failureView)
            failureView.snp.makeConstraints { (make) -> Void in
                make.top.bottom.left.right.equalTo(0)
            }
            
        default:
            debugPrint("bangdingView:",bangdingView)
            bangdingView.snp.makeConstraints { (make) -> Void in
                make.top.bottom.left.right.equalTo(0)
            }
        }

    }
}





class BGFailScanView:UIView{
  
   lazy var dogimg:UIImageView = {
        let imgView = UIImageView.init()
        let img = UIImage.init(named: "tabBar_4")
        imgView.backgroundColor = UIColor.red
        return imgView
    }()
    
   lazy var titleLabel:UILabel = {
        
        let label = UILabel.init()
        label.text = "扫码失败"
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = UIColor.black
        return label
    }()
    
   lazy var decLabel:UILabel = {
        let label = UILabel.init()
        label.text = "请扫描项圈使用说明书上的二维码"
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = UIColor.init(red: 180/255, green: 180/255, blue: 180/255, alpha: 1.0)
        return label
    
    }()

    lazy var sumbinButton:UIButton = {
        
        let sumbinButton = UIButton.init()
        sumbinButton.addTarget(self, action: #selector(nextStepFunction), for: UIControlEvents.touchUpInside)
        sumbinButton.setTitle("重新扫码", for: UIControlState.normal)
        sumbinButton.setTitleColor(UIColor.white, for: UIControlState.normal)
        sumbinButton.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        sumbinButton.backgroundColor = UIColor.black
        sumbinButton.layer.masksToBounds = true
        sumbinButton.layer.cornerRadius = 2
        return sumbinButton
        
    }()
    
    var nextStepAct:(() -> ())?
    func nextStepFunction(){
        self.nextStepAct?()
    }

    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        super.addSubview(dogimg)
        super.addSubview(titleLabel)
        super.addSubview(decLabel)
        super.addSubview(sumbinButton)
    }
    
    convenience init() {
        self.init(frame:CGRect.init(x: 0, y: 0, width: 100, height: 100))
        
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        dogimg.snp.makeConstraints { (make) -> Void in
            make.centerX.equalTo(self.snp.centerX)
            make.top.equalTo(102)
            make.height.equalTo(105 * BGW)
            make.width.equalTo(105 * BGW)
        }
        
        titleLabel.snp.makeConstraints { (make) -> Void in
            make.centerX.equalTo(self.snp.centerX)
            make.top.equalTo(dogimg.snp.bottom).offset(19)
            make.height.equalTo(16 * BGW)
            make.width.equalTo(270 * BGW)
        }
        
        decLabel.snp.makeConstraints { (make) -> Void in
            make.centerX.equalTo(self.snp.centerX)
            make.top.equalTo(titleLabel.snp.bottom).offset(65)
            make.height.equalTo(16 * BGW)
            make.width.equalTo(270 * BGW)
        }

        sumbinButton.snp.makeConstraints { (make) -> Void in
            make.centerX.equalTo(self.snp.centerX)
            make.bottom.equalTo(-17 * BGH)
            make.height.equalTo(40 * BGH)
            make.width.equalTo(270 * BGW)
        }

    }

}


class BGyibangdingView:UIView{
    lazy var dogimg:UIImageView = {
        let imgView = UIImageView.init()
        let img = UIImage.init(named: "tabBar_4")
        imgView.backgroundColor = UIColor.red
        return imgView
    }()
    
    lazy var titleLabel:UILabel = {
        
        let label = UILabel.init()
        label.text = "温馨提示"
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = UIColor.black
        return label
    }()
    
    lazy var decLabel:UILabel = {
        let label = UILabel.init()
        label.text = "项圈ID为 12345623443221"
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = UIColor.black
        return label
    }()
    
    lazy var secdecLabel:UILabel = {
        let label = UILabel.init()
        label.text = "已被别的用户绑定"
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = UIColor.black
        return label
    }()
    

    
    var secLabel:UILabel = {
        let label = UILabel.init()
        label.text = "如有疑问，请联系客服热线:"
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = UIColor.black
        return label
    }()
    
    var phoneLabel:UILabel = {
        
        let label = UILabel.init()
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = UIColor.black
        label.lineBreakMode = .byWordWrapping
        var attrs = [NSUnderlineStyleAttributeName : 1]
        var String = NSMutableAttributedString(string:"4007759206", attributes:attrs)
        label.attributedText = String
        return label
    }()

    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        super.addSubview(dogimg)
        super.addSubview(titleLabel)
        super.addSubview(decLabel)
        super.addSubview(secLabel)
        super.addSubview(phoneLabel)

    }
    
    convenience init() {
        self.init(frame:CGRect.init(x: 0, y: 0, width: 100, height: 100))
        
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        dogimg.snp.makeConstraints { (make) -> Void in
            make.centerX.equalTo(self.snp.centerX)
            make.top.equalTo(102)
            make.height.equalTo(105 * BGW)
            make.width.equalTo(105 * BGW)
        }
        
        titleLabel.snp.makeConstraints { (make) -> Void in
            make.centerX.equalTo(self.snp.centerX)
            make.top.equalTo(dogimg.snp.bottom).offset(19)
            make.height.equalTo(16 * BGW)
            make.width.equalTo(270 * BGW)
        }
        
        decLabel.snp.makeConstraints { (make) -> Void in
            make.centerX.equalTo(self.snp.centerX)
            make.top.equalTo(titleLabel.snp.bottom).offset(8)
            make.height.equalTo(16 * BGW)
            make.width.equalTo(270 * BGW)
        }
        
        
        secLabel.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(decLabel.snp.bottom).offset(33 * BGH)
            make.left.equalTo(45 * BGW)
            make.height.equalTo(16)
            make.width.equalTo(180)
        }
        
        
        phoneLabel.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(decLabel.snp.bottom).offset(33 * BGH)
            make.left.equalTo(secLabel.snp.right).offset(0)
            make.height.equalTo(16)
            make.width.equalTo(100)
            
        }
        
    }



}


