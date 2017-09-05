//
//  BGEditpetVC.swift
//  HaloKitProduct
//
//  Created by 范博 on 2017/7/9.
//  Copyright © 2017年 范博. All rights reserved.
//

import UIKit
import Qiniu    
import SwiftyJSON
import SDWebImage
class BGEditpetVC: UITableViewController,UIImagePickerControllerDelegate, UINavigationControllerDelegate, TLCityPickerDelegate ,UITextFieldDelegate {
    var pickView:UIPickerView!
    var headerImg:UIImage? = nil
    var source = ""
    var QiniuToken = ""
    var imagePath = ""
    var sex = ""
    var sexing = ""
    var sexyue = ""

    var nickname = ""
    var pinZhong = ""
    var ggWstr = ""
    var mmWstr = ""
    var weightlbl = ""
    var birthday = ""
    var homeDate = "2017-07-19"
    var breedId = "1122"
    var deviceID = ""
    var token = ""
    var dogModel:BGPetsInfoModel? = nil
    var netWork:HttpRequest = HttpRequest.sharedInstance()
    var promptlist = [InputStruct("生日:","",false,"",.default),
                      InputStruct("生日：","",false,"",.default)]
    
    lazy var  lyjdatePick01:LYJDatePicker01 = {
        let datePick = LYJDatePicker01.init(frame: CGRect(x:0,y:0,width:self.view.bounds.width,height:250))
        
        return datePick
        
    }()//时间选择器02
    
    
    lazy var  lyjweightPick:weightPicker = {
       
        let weightpicker = weightPicker.init()
        
        weightpicker.canButtonReturnB = {
            debugPrint("我要消失了哈哈哈哈哈哈3")
            self.view.ttDismissPopupViewControllerWithanimationType(TTFramePopupViewAnimationFade)
        }
        
        weightpicker.weightBack = { (weight) -> Void in
            self.view.ttDismissPopupViewControllerWithanimationType(TTFramePopupViewAnimationFade)
            debugPrint("我要消失了哈哈哈哈哈哈4",weight)
            self.weightlbl = weight
            self.tableView.reloadData()
        }

        return weightpicker
        
    }()//时间选择器02

    
    class func initVC(param:String? = nil, dogModel:BGPetsInfoModel? = nil) -> BGEditpetVC{
        return BGEditpetVC.init(param: param, dogModel:dogModel)
    }
    
    init(param: String?, dogModel:BGPetsInfoModel? = nil) {
        super.init(nibName: nil, bundle: nil)
        self.source = param!
        if self.source == "1"{
            self.dogModel = dogModel
            self.nickname = self.dogModel!.nickname
            self.sex = self.dogModel!.sex
            self.sexing = self.dogModel!.sex
            self.sexyue = self.dogModel!.sex
            self.pinZhong = self.dogModel!.breed
            self.homeDate = self.dogModel!.homeDate
            self.birthday  = self.dogModel!.birthday
            self.imagePath = self.dogModel!.imagePath
            self.weightlbl = (self.dogModel?.weight)!
            let imgView = UIImageView.init()
            imgView.sd_setImage(with: URL(string:self.imagePath), placeholderImage: UIImage.init(named: "tabBar_1")!)
            self.headerImg = imgView.image
        }else{

            self.headerImg = UIImage.init(named: "tabBar_1")!
        
        }
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    class func push(_ parentVC:UIViewController?, param:String? = nil, dogModel:BGPetsInfoModel? = nil) {
        let vc = BGEditpetVC.initVC(param:param, dogModel:dogModel)
        parentVC?.navigationController?.pushViewController(vc, animated: true)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.separatorInset = UIEdgeInsetsMake(0,32 * BGW, 0, 0);
        token = UserDefaults.standard.object(forKey: "token") as! String
        if source == "1"{
            self.title = "编辑宠物"
        }else{
            self.title = "添加宠物"
        }
        
        self.tableView.register(BGPersonalInfoheadIconCell.classForCoder(), forCellReuseIdentifier: BGPersonalInfoheadIconCell.cell_id)
        self.tableView.register(BGPersonalInfoOthersCell.classForCoder(), forCellReuseIdentifier: BGPersonalInfoOthersCell.OthersCell_id)
        self.tableView.register(BGTextPersonalInfoOthersCell.classForCoder(), forCellReuseIdentifier: BGTextPersonalInfoOthersCell.OthersCell_id)
        tableView.register(OutRegisterSubmitMainTableViewCell.classForCoder(), forCellReuseIdentifier: OutRegisterSubmitMainTableViewCell.cellId)
        getQiniuToken()
        self.createNav()
    }
    
    
    func createNav() {
        let backItem = UIBarButtonItem.init(image: UIImage(named: "navBack"), style: .plain, target: self, action: #selector(backToPrevious))
        backItem.tintColor = UIColor.black
        self.navigationItem.leftBarButtonItem = backItem
        let rightItem = UIBarButtonItem.init(title: "完成", style: UIBarButtonItemStyle.plain, target: self, action: #selector(finishEditedFunc))
        rightItem.tintColor = UIColor.black
        self.navigationItem.rightBarButtonItem = rightItem
        
    }
    
    func backToPrevious(){
        self.navigationController?.popViewController(animated: true)
    }
    
    func finishEditedFunc(){
        
        if self.source == "1" {
            editPersonalInfo_NetWork()

        }else{
            addPersonalInfo_NetWork()


        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    fileprivate lazy var portraitImagePicker:UIImagePickerController = {
        let portraitImagePicker = UIImagePickerController()
        return portraitImagePicker
    }()

    private func tapToShowAlert(titleImage:String, titleTakepho:String,titleSelect:String, titleCancel:String){
        
        let message = ""
        let changeHoldImageAlert = UIAlertController.createAlertView(title: titleImage, message: message)
        let _ = changeHoldImageAlert.addAlertAction(title: titleTakepho,handler:  { (alert) in
            if UIImagePickerController.isSourceTypeAvailable(.camera){
                self.portraitImagePicker.sourceType = .camera
                self.portraitImagePicker.delegate = self
                self.portraitImagePicker.allowsEditing = false
                self.portraitImagePicker.showsCameraControls = true
                self.present(self.portraitImagePicker, animated: true, completion: nil)
            }
        })
        
        let _ = changeHoldImageAlert.addAlertAction(title: titleSelect) { (alert) in
            if UIImagePickerController.isSourceTypeAvailable(.photoLibrary){
                self.portraitImagePicker.sourceType = .photoLibrary
                self.portraitImagePicker.delegate = self
                self.portraitImagePicker.allowsEditing = false
                self.present(self.portraitImagePicker, animated: true, completion: nil)
                
            }
        }
        
        let _ = changeHoldImageAlert.addCancelAlertAction(title: titleCancel, handler: nil)
        self.present(changeHoldImageAlert, animated: true, completion: nil)
        
    }
    
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 2
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        switch section {
        case 0:            return 1
        default:           return 7
        }
        
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 0:
            return 130 * BGH
        default:
            if indexPath.row == 6 {
                return 200 * BGH
            }
            return 60 * BGH
        }
    }
    
    var Name = ""
    func textFieldDidBeginEditing(_ textField: UITextField) {
        Name = textField.text!
    }
    

    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        switch section {
        case 0:
            return 0
        default:
            return 10 * BGH
        }
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let cell = BGPersonalInfoheadIconCell.dequeueReusable(tableView, indexPath: indexPath)
                cell.heagImgView.image = headerImg?.roundCornersToCircle()
            return cell
            
        default:   
            //  cell.model =
            if indexPath.row == 0 {
                let cell = BGTextPersonalInfoOthersCell.dequeueReusable(tableView, indexPath: indexPath)
                cell.titleLabel.text = "昵称"
                cell.cententLabel.delegate = self
                cell.cententLabel.returnKeyType = .done
                cell.cententLabel.text = nickname
                return cell
            }else if indexPath.row == 1{
                let cell = BGPersonalInfoOthersCell.dequeueReusable(tableView, indexPath: indexPath)
                cell.titleLabel.text = "性别"
                if sexing == "1" ||  sexing == "3" {
                    cell.cententLabel.text = "男"
                }else if sexing == "2" ||  sexing == "4" {
                    cell.cententLabel.text = "女"
                }else if sexing == ""{
                    cell.cententLabel.text = ""

                }
                return cell
                
            }else if indexPath.row == 2{
                let cell = BGPersonalInfoOthersCell.dequeueReusable(tableView, indexPath: indexPath)
                cell.titleLabel.text = "绝育"
                if sexyue == "1" ||  sexyue == "2" {
                    cell.cententLabel.text = "未绝育"
                }else if sexyue == "3" ||  sexyue == "4" {
                    cell.cententLabel.text = "已绝育"
                }else if sexyue == ""{
                    cell.cententLabel.text = ""
                    
                }

                return cell
                
                
            }else if indexPath.row == 3{
                let cell = BGPersonalInfoOthersCell.dequeueReusable(tableView, indexPath: indexPath)
                cell.titleLabel.text = "品种"
                cell.cententLabel.text = pinZhong
                return cell

            }else if indexPath.row == 4{
                let cell  = tableView.dequeueReusableCell(withIdentifier: OutRegisterSubmitMainTableViewCell.cellId) as!  OutRegisterSubmitMainTableViewCell
                let dic:InputStruct  = promptlist[0]
                cell.accessoryType = .disclosureIndicator
                cell.rowNum = indexPath.row
                cell.selectionStyle = .none
                cell.prompcouont = 6
                cell.returnInfoB = mainReturn
                //cell.databind(inputStrct: dic, placeHolder: birthdayLabel, canEdit: dic.canEdit)
                cell.databind(inputStrct: promptlist[0], placeHolder: birthday, canEdit: dic.canEdit)
                return cell
            }else if indexPath.row == 5{
                
                let cell = BGPersonalInfoOthersCell.dequeueReusable(tableView, indexPath: indexPath)
                cell.titleLabel.text = "体重"
                cell.cententLabel.text = weightlbl
                return cell
            
            }else{
                let cell = UITableViewCell.init()
                return cell
            }
            
        }
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool{
        textField.resignFirstResponder()
        nickname = textField.text!
        return true;
    }
    
    
    private func tapToShowSexAlert(titleImage:String, titleTakepho:String,titleSelect:String, titleCancel:String){
        
        let message = ""
        
        let changeHoldImageAlert = UIAlertController.createAlertView(title: titleImage, message: message)
        
        let _ = changeHoldImageAlert.addAlertAction(title: titleTakepho,handler:  { (alert) in
            self.sexing = "1"
             DebugTool.debugLog(item:"男")
            
            if self.sexyue == "1" || self.sexyue == "2"{
                self.sex = "1"
            }else if self.sexyue == "4" || self.sexyue == "3"{
                self.sex = "3"
            }else  if self.sexyue == "" {
                self.sex = ""
                
            }
            

            self.tableView.reloadData()
        })
        
        let _ = changeHoldImageAlert.addAlertAction(title: titleSelect) { (alert) in
             DebugTool.debugLog(item:"女")
            self.sexing = "2"
            if self.sexyue == "1" || self.sexyue == "2"{
                self.sex = "2"
            }else if self.sexyue == "4" || self.sexyue == "3"{
                self.sex = "4"
            }else  if self.sexyue == "" {
                self.sex = ""

            }

            self.tableView.reloadData()


        }
        
        let _ = changeHoldImageAlert.addCancelAlertAction(title: titleCancel, handler: nil)
        self.present(changeHoldImageAlert, animated: true, completion: nil)
        
    }
    
    private func tapToShowSYUAlert(titleImage:String, titleTakepho:String,titleSelect:String, titleCancel:String){
        
        let message = ""
        
        let changeHoldImageAlert = UIAlertController.createAlertView(title: titleImage, message: message)
        
        let _ = changeHoldImageAlert.addAlertAction(title: titleTakepho,handler:  { (alert) in
            self.sexyue = "1"
            
            if self.sexing == "1" || self.sexing == "3" {
                self.sex = "3"
            }else if self.sexing == "4" || self.sexing == "2"{
                self.sex = "4"
            }else if self.sexing == "" {
                self.sex = ""

            }
            
            DebugTool.debugLog(item:"未绝育")
            self.tableView.reloadData()
        })
        
        let _ = changeHoldImageAlert.addAlertAction(title: titleSelect) { (alert) in
            DebugTool.debugLog(item:"已绝育")
            if self.sexing == "1" || self.sexing == "3" {
                self.sex = "1"
            }else if self.sexing == "4" || self.sexing == "2"{
                self.sex = "2"
            }else if self.sexing == "" {
                self.sex = ""
            }
            self.sexyue = "4"
            self.tableView.reloadData()
            
            
        }
        
        let _ = changeHoldImageAlert.addCancelAlertAction(title: titleCancel, handler: nil)
        self.present(changeHoldImageAlert, animated: true, completion: nil)
        
    }

    
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage{
            if (info[UIImagePickerControllerOriginalImage] as? UIImage) != nil{
                self.uploadToQiniu(img: image)
                self.headerImg = image.roundCornersToCircle()!
                self.tableView.reloadData()

            }
        }else{
            print("pick image wrong")
        }
        // 收回图库选择界面
        self.dismiss(animated: true, completion: nil)
    }

    
    
//    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage, editingInfo: [String : AnyObject]?) {
//        
//        self.headerImg = image.roundCornersToCircle()
//        self.uploadToQiniu(img: image)
//        picker.dismiss(animated: true, completion: nil)
//    }

    
    
    var pickerFlag = ""
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        switch indexPath.section {
        case 0:
            self.tapToShowAlert(titleImage:"选择头像" , titleTakepho:"拍照" , titleSelect:"从相片库中选取", titleCancel: "取消")
            
        default:
            switch indexPath.row {
            case 0:break
                
            case 1:
                self.tapToShowSexAlert(titleImage: "选择性别", titleTakepho: "男",titleSelect: "女", titleCancel: "取消")
            case 2:
                self.tapToShowSYUAlert(titleImage: "选择性别", titleTakepho: "未绝育",titleSelect: "已绝育", titleCancel: "取消")

            case 3:
                let cityPickerVC = TLCityPickerController()
                cityPickerVC.flagVc = "BGEditpetVC"
                cityPickerVC.delegate = self
                cityPickerVC.locationCityID = "800010000"
                cityPickerVC.hotCitys = ["2300080000", "1800060000", "2500050000", "300070000", "300090000","1800090000","1500060001","2600020000","2000080000","600300000"];
                self.navigationController?.pushViewController(cityPickerVC, animated: true)
            case 4:
                self.gotoDatePick(index: indexPath)
                
            default:

                self.gotoweightPick()

            }
        }
    }
    

    
    
    //MARK:主要的回调
    func mainReturn(text:String ,rowNum:Int) {
        var model = self.promptlist[rowNum ]
        model.infoValue = text
        self.promptlist[rowNum] = model
        debugPrint("传过来的text数据 \(text)")
        self.tableView.reloadData()
        
    }
    
    //MARK:打开时间选择
    
    //MARK:打开时间选择
    
    func gotoDatePick(index:IndexPath)  {
        
            //需要初始化数据
            self.lyjdatePick01.canButtonReturnB = {
                debugPrint("我要消失了哈哈哈哈哈哈3")
                self.view.ttDismissPopupViewControllerWithanimationType(TTFramePopupViewAnimationFade)
            }
            self.lyjdatePick01.sucessReturnB = { returnValue in
                self.view.ttDismissPopupViewControllerWithanimationType(TTFramePopupViewAnimationFade)
                debugPrint("我要消失了哈哈哈哈哈哈4",returnValue)
                //第二行
                var model = self.promptlist[0]
                model.infoValue = returnValue
                self.birthday = returnValue
                self.promptlist[0] = model
                    
                
                self.tableView.reloadData()
            }

        self.gototargetView(_targetView:self.lyjdatePick01)
        }
    
    
    
    func gotoweightPick()  {
        
        //需要初始化数据
//        weightpicker.weightBack = {(weight) -> Void in
//            self.weightlbl = weight
//            
//            self.tableView.reloadData()
//        }
        
        
        
        
        self.gototargetView(_targetView:self.lyjweightPick)
    }
    

    
    func goweightView(_targetView:UIView)  {
        self.tableView.ttPresentFramePopupView(_targetView, animationType: TTFramePopupViewAnimationFade) {
            self.lyjweightPick.isHidden =  false
        }
        
        _targetView.snp.makeConstraints { (make) in
            make.top.equalTo(SCREENH - 250 - 44)
            make.height.equalTo(250)
            make.left.equalTo(0)
            make.width.equalTo(SCREENW)
        }
    }
    
    
    func gototargetView(_targetView:UIView)  {
        self.tableView.ttPresentFramePopupView(_targetView, animationType: TTFramePopupViewAnimationFade) {
            
            //            debugPrint("我要消失了")
        }
        
        _targetView.snp.makeConstraints { (make) in
            make.top.equalTo(SCREENH - 250 - 44)
            make.height.equalTo(250)
            make.left.equalTo(0)
            make.width.equalTo(SCREENW)
        }
    }
}


extension BGEditpetVC{


}

extension BGEditpetVC{
    
    func cityPickerController(_ cityPickerViewController: TLCityPickerController!, didSelect city: TLCity!) {
        pinZhong = city.cityName
        let weStr = city.weight
        var arr = weStr?.components(separatedBy: ",")
        ggWstr = (arr?[0])! + "KG"
        mmWstr = (arr?[1])! + "KG"
        weightlbl = mmWstr
        self.tableView.reloadData()
    }
    
    func  cityPickerControllerDidCancel(_ cityPickerViewController: TLCityPickerController!) {
        
    }

    
    func getQiniuToken(){
        let url = RBRequestFunction.Qiuniu.获取短信验证码.urlString
        netWork.getHeader(url, dict: nil, andHeader: token, succeed: { (response) in
            let datas = JSON(response!)
            if datas["code"].intValue == 1{
                self.QiniuToken = datas["data"]["token"].stringValue
            }
            debugPrint(":",self.QiniuToken);
        }) { (error) in
            
        }
        
    }
    
    func uploadToQiniu(img:UIImage){
        let upManager = QNUploadManager()
        debugPrint("tokentoken",QiniuToken)
        
        let data = UIImageJPEGRepresentation(img, 0.05)
        upManager?.put(data, key: nil, token: QiniuToken, complete: { (info, key, resp) in
            if (info?.statusCode == 200 && resp != nil){
                let respStr = resp?["key"] as! String
                let url = "http://7xwshy.com1.z0.glb.clouddn.com/" + respStr
                debugPrint("respStrrespStr",url)

                self.imagePath = url
            }else{
                
                
            }
            
        }, option: nil)
    }
    
    
    func editPersonalInfo_NetWork(){
        guard self.nickname != "" else {
            self.popFailureShow("请输入宠物的昵称")
            return
        }
        
        guard imagePath != "" else {
            self.popFailureShow("请完善宠物的头像")
            return
        }
        
        guard birthday != "" else {
            self.popFailureShow("请完宠物的生日")
            return
        }
        
        guard sex != "" else {
            self.popFailureShow("请选择您的性别")
            return
        }
        
        guard homeDate != "" else {
            self.popFailureShow("请选择宠物到家时间")
            return
        }
  

//        guard weight != "" else {
//            self.popFailureShow("请选择宠物的体重")
//            return
//        }
//

        let url = RBRequestFunction.Pet.编辑宠物信息.urlString
        debugPrint("urlurl:",url, token)
        if self.sex == "1" {
            
            self.sex = "1"
        }else {
            self.sex = "2"
        }
        
        let parmas = ["imagePath" : self.imagePath, "nickname": self.nickname,"birthday":self.birthday,"sex":self.sex ,"homeDate":self.homeDate,"breedID":self.breedId, "weight":self.weightlbl, "petID":"596f26a38d05af76a52a7950","breed":"标准贵宾犬"]//self.pinZhong]
        debugPrint("parmas:",parmas, "token:",token)
        netWork.postHeader(url, dict: parmas, andHeader: token, succeed: { (response) in
            if let _ = response{
                let jsonData = JSON(response!)
                if jsonData["code"] == 1{
                
                    let editModel = BGEditPetsInfoModel.init(fromJson:jsonData)
                    self.dogModel = editModel.petsInfoModel
                    
                    self.tableView.reloadData()
                    debugPrint("编辑：", response ?? "")
                }
            }
            self.navigationController?.popViewController(animated: true)
        }) { (error) in
            debugPrint(error ?? "NULL")

        }
    }
    
    func addPersonalInfo_NetWork(){
        //        guard self.nicknameField.text != "" else {
        //            self.popFailureShow("请输入宠物的昵称")
        //            return
        //        }
        
        guard imagePath != "" else {
            self.popFailureShow("请完善宠物的头像")
            return
        }
        
        guard birthday != "" else {
            self.popFailureShow("请完宠物的生日")
            return
        }
        
        guard sex != "" else {
            self.popFailureShow("请选择您的性别")
            return
        }
        
//        guard homeDate != "" else {
//            self.popFailureShow("请选择宠物到家时间")
//            return
//        }
        
        guard weightlbl != "" else {
            self.popFailureShow("请选择宠物的体重")
            return
        }

        
        let url = RBRequestFunction.Pet.添加宠物.urlString
        debugPrint("urlurl:",url, token)
        if self.sex == "1" {
            
            self.sex = "1"
            
        }else{
            
            self.sex = "2"
        }
        let parmas = ["imagePath" : self.imagePath, "nickname": self.nickname,"birthday":self.birthday,"sex":self.sex ,"homeDate":self.homeDate,"breedID":self.breedId, "weight":self.weightlbl,"breed":"苏联红"]
        debugPrint("parmas:",parmas)
        netWork.postHeader(url, dict: parmas, andHeader: token, succeed: { (response) in
            debugPrint(response!)
            UserDefaults.standard.set(4, forKey: "netNumber")
            self.navigationController?.popViewController(animated: true)
        }) { (error) in
            debugPrint(error ?? "NULL")

        }

    
    }
}


class weightPicker:UIView,UIPickerViewDelegate,UIPickerViewDataSource{
    var canButtonReturnB: (() -> Void)? //取消按钮的回调
    
    var sucessReturnB: ((_ date:String) -> Void)?//选择的回调
    
    var title = UILabel.init(lableText: "")//标题
    
    var cancelButton = UIButton.init(title: "取消", bgColor: UIColor.clear, font:  CGFloat(mylableSize)) //取消按钮
    
    var confirmButton = UIButton.init(title: "确定", bgColor: UIColor.clear, font:  CGFloat(mylableSize)) //取消按钮
    
    var weight = ""
    
    
    
    
    var lineView = UIView()//一条横线
    
    
    var dateFormatter = DateFormatter()
    
    
    
    lazy var  lyjweightPick:UIPickerView = {
        let datePick = UIPickerView.init(frame: CGRect(x:0,y:0,width:self.bounds.width,height:250))
        datePick.delegate = self
        datePick.dataSource = self
        return datePick
        
    }()//时间选择器02
    
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.setupUI()
    }
    
    
    convenience init() {
        self.init(frame:CGRect.init(x: 0, y: 0, width: 100, height: 100))
        
        self.setupUI()
        
    }
    
    
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        
        super.init(coder: aDecoder)
        
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    
    
    func setupUI() {
        
        self.backgroundColor = UIColor.white
        
        self.addtitle()
        
        self.addcancelButton()
        
        self.addlineView()
        
        self.addconfirmButton()
        
        self.addDatePicker()
        
    }
    
    
    
    
    //MARK:设置标题
    private func addtitle(){
        
        
        self.addSubview(title)
        
        self.titleP()
        self.titleF()
        
        
        
    }
    
    
    
    private func titleP(){
        title.textColor = TitlelableColor
        
        title.textAlignment = .center
        
        title.font = UIFont.systemFont(ofSize: CGFloat(mylableSize))
        
        
        
    }
    
    
    
    private func titleF(){
        title.snp.makeConstraints { (make) in
            
            make.top.equalTo(self.snp.top).offset(mycommonEdge)
            
            make.centerX.equalTo(self.snp.centerX)
            
        }
        
    }
    
    
    
    private func titleD(title:String){
        
        self.title.text = title
    }
    
    
    //MARK:设置取消按钮
    private func addcancelButton(){
        
        self.addSubview(cancelButton)
        
        self.cancelP()
        
        self.cancelF()
    }
    
    private func cancelP(){
        
        self.cancelButton.setTitleColor(UIColor.system, for: .normal)
        self.cancelButton.tag = 101
        self.cancelButton.addTarget(self, action: #selector(buttonClick(_:)), for: .touchUpInside)
        
    }
    
    private func cancelF(){
        
        self.cancelButton.snp.makeConstraints { (make) in
            make.top.equalTo(self.snp.top).offset(mycommonEdge)
            
            make.leading.equalTo(self.snp.leading).offset(mycommonEdge)
            
            make.height.equalTo(mylableSize)
            
            make.width.equalTo(50)
            
        }
        
    }
    
    private func cancelD(){
        
    }
    
    
    
    //MARK:设置确定按钮
    private func addconfirmButton(){
        
        self.addSubview(confirmButton)
        
        self.confirmButtonP()
        
        self.confirmButtonF()
    }
    
    private func confirmButtonP(){
        
        self.confirmButton.setTitleColor(UIColor.system, for: .normal)
        self.confirmButton.tag = 102
        self.confirmButton.addTarget(self, action: #selector(buttonClick(_:)), for: .touchUpInside)
        
    }
    
    private func confirmButtonF(){
        
        self.confirmButton.snp.makeConstraints { (make) in
            make.top.equalTo(self.snp.top).offset(mycommonEdge)
            
            make.trailing.equalTo(self.snp.trailing).offset(-mycommonEdge)
            
            make.height.equalTo(mylableSize)
            
            make.width.equalTo(50)
            
        }
        
    }
    
    
    
    var weightBack:((_ weight:String) -> ())?
    //MARK:按钮的点击
    func buttonClick(_ sender:UIButton) {
        debugPrint("======取消按钮被点击=====")
        
        
        switch sender.tag {
        case 101:
            //取消
            if self.canButtonReturnB != nil {
                
                self.canButtonReturnB!()
            }
        case 102:
            //确定
            if self.weightBack != nil {
                self.weightBack!(weight)
            }
            
            
        default:
            break
        }
        
        
        
        
    }
    
    
    
    //MARK:设置横线
    private func addlineView(){
        
        self.addSubview(lineView)
        
        self.lineViewP()
        
        self.lineViewF()
        
    }
    
    private func lineViewP(){
        
        self.lineView.backgroundColor = UIColor.systemGray
        
        
    }
    
    private func lineViewF(){
        
        self.lineView.snp.makeConstraints { (make) in
            
            make.top.equalTo(self.cancelButton.snp.bottom).offset(mycommonEdge)
            
            make.leading.trailing.equalTo(self)
            
            make.height.equalTo(1)
            
            
        }
        
    }
    
    
    
    private func addDatePicker(){
        
        self.addSubview(lyjweightPick)
        
        self.datePickerF()
        
    }
    
    
    private func datePickerF(){
        
        lyjweightPick.snp.makeConstraints { (make) in
            make.top.equalTo(self.lineView.snp.bottom)
            make.leading.trailing.bottom.equalTo(self)
        }
    }
    
    
    //设置选择框的列数为3列,继承于UIPickerViewDataSource协议
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    //设置选择框的行数为9行，继承于UIPickerViewDataSource协议
    func pickerView(_ pickerView: UIPickerView,
                    numberOfRowsInComponent component: Int) -> Int {
        return 1000
    }
    
    //设置选择框各选项的内容，继承于UIPickerViewDelegate协议
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int,
                    forComponent component: Int) -> String? {
        let num = Int((row + 1) / 10);
        let munber = Double(Double(num) + 0.1 * Double( (row+1) % 10))
        let sreign = "\(munber)"
        return sreign + "KG"
    }
    
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let num = Int((row + 1) / 10);
        let munber = Double(Double(num) + 0.1 * Double( (row+1) % 10))
        let sreign = "\(munber)"
        weight = sreign + "KG"
    }

}

