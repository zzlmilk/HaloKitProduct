//
//  BGLoginViewController.swift
//  HaloKitProduct
//
//  Created by 范博 on 2017/6/29.
//  Copyright © 2017年 范博. All rights reserved.
//

import UIKit
import SnapKit
import AVKit
import AVFoundation

class BGLoginViewController: UIViewController {
    
    //MARK:---变量
    var param:String? = nil
    var param1:String? = nil
    var parentVC:String? = nil
    
    //MARK:---跳转
    class func initVC(param:String? = nil) -> BGLoginViewController{
        return BGLoginViewController.init(param: param)
    }
    
    init(param: String?) {
        super.init(nibName: nil, bundle: nil)
        self.param = param
    }
    
    class func push(_ parentVC:UIViewController?, param:String? = nil, param1:String?) {
        let vc = BGLoginViewController.initVC(param:param)
        vc.param1 = param1
        parentVC?.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    
    //MARK:--- 控件
    var avPlayer = AVPlayerViewController()
    
    
    fileprivate lazy var headView:UIView = {
        let headView = UIView()
        headView.backgroundColor = UIColor.clear
        return headView
    }()
    

    
    fileprivate lazy var loginBtn:UIButton = {
        let loginBtn = UIButton.init()
        loginBtn.alpha = 0.8
        loginBtn.setTitle("登录", for: .normal)
        loginBtn.setTitleColor(UIColor.black, for: .normal)
        loginBtn.backgroundColor = UIColor(red: 237/255.0, green: 235/255.0, blue: 231/255.0, alpha: 1.0)
        loginBtn.addTarget(self, action: #selector(BGLoginViewController.loginClickAction), for: .touchUpInside)
        
        return loginBtn
    }()
    
    fileprivate lazy var registerBtn:UIButton = {
        let registerBtn = UIButton()
        registerBtn.alpha = 0.8
        registerBtn.setTitle("注册", for: .normal)
        registerBtn.setTitleColor(UIColor.black, for: .normal)
        registerBtn.backgroundColor = UIColor(red: 237/255.0, green: 235/255.0, blue: 231/255.0, alpha: 1.0)
        registerBtn.addTarget(self, action: #selector(BGLoginViewController.registerClickAction), for: .touchUpInside)
        return registerBtn
    }()

    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        //添加布局
        headView.snp.makeConstraints { (make) -> Void in
            make.bottom.top.left.right.equalTo(0)
        }
        
        
        loginBtn.snp.makeConstraints { (make) -> Void in
            make.left.equalTo(0)
            make.bottom.equalTo(0)
            make.width.equalTo(SCREENW/2)
            make.height.equalTo(80)
        }
        
        registerBtn.snp.makeConstraints { (make) -> Void in
            make.height.equalTo(80)
            make.left.equalTo(loginBtn.snp.right)
            make.right.equalTo(0)
            make.bottom.equalTo(0)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //添加控件
        view .addSubview(headView)
        view .addSubview(loginBtn)
        view .addSubview(registerBtn)

   
        
        
        self.createVideo()


    }
    
    //MARLK: 方法域
    func createVideo(){
        let path = Bundle.main.path(forResource: "HALOKIT7SEC", ofType: ".mp4")
        avPlayer.showsPlaybackControls = false
        avPlayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
        avPlayer.view.frame = self.headView.frame
        self.avPlayer.player = AVPlayer(url:URL.init(fileURLWithPath: path!))
        self.headView.addSubview(avPlayer.view)
        avPlayer.view.backgroundColor = UIColor.clear
        avPlayer.player?.play()
        NotificationCenter.default.addObserver(self, selector: #selector(BGLoginViewController.playVideo), name: .AVPlayerItemDidPlayToEndTime, object: nil)

    }
    
    func loginClickAction(){
        loginBtn.setTitleColor(UIColor.white, for: .normal)
        loginBtn.backgroundColor = UIColor(red: 31/255.0, green: 133/255.0, blue: 140/255.0, alpha: 1.0)
        

    }
    
    func registerClickAction(){
        registerBtn.setTitleColor(UIColor.white, for: .normal)
        registerBtn.backgroundColor = UIColor(red: 31/255.0, green: 133/255.0, blue: 140/255.0, alpha: 1.0)
        

    }
    
    func playVideo(){
        avPlayer.player?.seek(to: CMTimeMake(0, 1))
        avPlayer.player?.play()
    
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
