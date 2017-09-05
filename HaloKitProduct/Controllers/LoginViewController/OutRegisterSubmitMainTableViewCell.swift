//
//  OutRegisterSubmitMainTableViewCell.swift
//  Colliers-CFIM
//
//  Created by Liyanjun on 2017/1/17.
//  Copyright © 2017年 yingwf. All rights reserved.
//

import UIKit
//import IQKeyboardManagerSwift

//这是外来人员登记输入框的通用cell
class OutRegisterSubmitMainTableViewCell: UITableViewCell {
    typealias ReturnInfoB = (_ infoValue:String, _ rowNum:Int ) -> Void;//定义一个
    var returnInfoB: ReturnInfoB?//回调函数
    var rowNum = 0 //当前行数
    static let cellId = "OutRegisterSubmitMainTableViewCell"
    var canEdit = true
    var borderView:UIView! = UIView()//边框view
    //定义ui所需的组件
    var promptlable:UILabel! = UILabel(lableText: "  ")//字段提示
    var infoTextView:LYJUITextView! = LYJUITextView()//字段输入
    
    var prompcouont:Int = 4//提示的字数个数
    
    lazy var point:UIImageView = {
        let point = UIImageView.init()
        point.backgroundColor = UIColor.init(red: 188/255, green: 188/255, blue: 188/255, alpha: 1.0)
        point.layer.masksToBounds = true
        point.layer.cornerRadius = 3
        return point
    }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.initialization()
    }
    
    
    
    
    
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.initialization()
    }
    
    
    // MARK: 初始化
    private   func initialization() {
        self.setUI()
        
        
        
    }
    
    
    
    
    
    
    
    //MARK:设置ui
    private   func setUI(){
        
        
        
        self.addborderView()
        
        self.addpromptlable()
        
        self.addinfoTextView()
        
        
        
        
        
    }
    
    
    //MARK: 设置边框view
    private func addborderView() {
        
        self.contentView.addSubview(borderView)
        self.addborderViewP()
        
    }
    
    private func addborderViewP() {
        
        //        borderView.backgroundColor = UIColor.yellow
        
        borderView.layer.masksToBounds = true
        
        borderView.layer.cornerRadius = 8
        
        borderView.layer.borderWidth = 1
        
        borderView.layer.borderColor = UIColor.clear.cgColor
        
    }
    
    private func addborderViewF() {
        
        borderView.snp.makeConstraints { (make) in
            
            make.top.equalTo(self.contentView.snp.top).offset( bordertopbottom)
            
            make.bottom.equalTo(self.contentView.snp.bottom).offset(-bordertopbottom)
            
            make.leading.equalTo(self.contentView.snp.leading).offset(mycommonEdge)
            
            make.trailing.equalTo(self.contentView.snp.trailing).offset(-mycommonEdge)
        }
        
    }
    
    
    
    
    // MARK: prompt字段设置
    private  func addpromptlable() {
        self.contentView.addSubview(point)
        self.contentView.addSubview(promptlable)
        self.addpromptlableP()
        
        
    }
    
    private   func addpromptlableP() {
        
        promptlable.textColor = UIColor.black
        
        promptlable.textAlignment = .left
        
        promptlable.font = UIFont.systemFont(ofSize: CGFloat(mylableSize))
        
    }
    
    
    private   func addpromptlableF() {
        
        point.snp.makeConstraints { (make) -> Void  in
            make.left.equalTo(32 * BGW)
            make.centerY.equalTo(self.snp.centerY)
            make.width.height.equalTo(6 * BGW)
            
        }

        
        promptlable.snp.makeConstraints { (make) in
            
            make.left.equalTo(self.point.snp.right).offset(10 * BGW)
            
            make.centerY.equalTo(self.snp.centerY)
            
            make.width.equalTo(17.5 * Float(prompcouont))
            
        }
        
        
    }
    
    
    
    // MARK:设置textView
    private  func addinfoTextView() {
        
        self.contentView.addSubview(infoTextView)
        
        self.infoTextViewP()
        
        
    }
    
    
    private   func infoTextViewP() {
        //       timeLalble.text = "巡检时间："
        infoTextView.textColor = UIColor.black
        infoTextView.textAlignment = .right
        infoTextView.myplaceholderLabel.text = "点击选择"
        
        infoTextView.delegate = self
        
        
        
        //        infoTextView.text = "显示很多的数据的时候怎么办显示很多的数据的时候怎么办显示很多的数据的时候怎么办显示很多的数据的时候怎么办显示很多的数据的时候怎么办显示很多的数据的时候怎么办显示很多的数据的时候怎么办显示很多的数据的时候怎么办显示很多的数据的时候怎么办显示很多的数据的时候怎么办"
        
        //        infoTextView.backgroundColor = UIColor.red
        
        infoTextView.font = UIFont.systemFont(ofSize: CGFloat(mylableSize))
        
    }
    
    
    private  func infoTextViewF() {
        
        infoTextView.snp.makeConstraints { (make) in
            make.right.equalTo(-30 * BGW)
            make.centerY.equalTo(self.borderView.snp.centerY)
            make.leading.equalTo(self.promptlable.snp.trailing)
            make.height.equalTo(commontextViewHeight)
            
        }
        
        
        
        
    }
    
    
    
    
    func setContenF(){
        contentView.snp.remakeConstraints({ (make) in
            make.bottom.equalTo(self.infoTextView.snp.bottom).offset(bordertopbottom*2)
            make.leading.equalTo(self)
            make.top.equalTo(self)
            make.trailing.equalTo(self)
        })
    }
    
    
    //MARK:数据加载
    
    
    func databind(inputStrct:InputStruct,placeHolder:String, canEdit:Bool )  {
        self.canEdit = canEdit
        self.promptlable.text = inputStrct.infoLalbel
        self.promptlable.font = UIFont.systemFont(ofSize: 16)
        self.infoTextView.text = inputStrct.infoValue
        
        self.infoTextView.keyboardType = inputStrct.keyboardtype
        
        
        self.infoTextView.textContainerInset = UIEdgeInsets.init(top: 0, left: 0, bottom: 0, right: 0)
        
        self.infoTextView.isUserInteractionEnabled = canEdit
        
        //        self.infoTextView.isEditable = canEdit
        
        self.infoTextView.isScrollEnabled = true
        self.infoTextView.font = UIFont.systemFont(ofSize: 14)
        self.infoTextView.textAlignment = .right
        
        self.infoTextView.showsVerticalScrollIndicator = true
        
        if canEdit {
            let index = placeHolder.index(placeHolder.startIndex, offsetBy: 10)

            infoTextView.text = placeHolder.substring(to: index)
            
        }else{
            
            if placeHolder == ""{
                infoTextView.text = ""

            }else{
                let index = placeHolder.index(placeHolder.startIndex, offsetBy: 10)
                infoTextView.text = placeHolder.substring(to: index)

            }
            
            
        }
        
        self.addpromptlableF()
        
        self.infoTextViewF()
        
        self.addborderViewF()
        
        self.setContenF()
        
        
    }
    
    
    
    
    deinit {
        self.infoTextView.resignFirstResponder()
    }
    
    
    
    
    
    
}




extension OutRegisterSubmitMainTableViewCell: UITextViewDelegate{
    
    
    
    func textViewDidEndEditing(_ textView: UITextView){
        
        
        if returnInfoB != nil {
            textView.font = UIFont.systemFont(ofSize: 12)
            textView.textAlignment = .right
            self.returnInfoB!(textView.text , self.rowNum)
        }
        
    }
    
    func textViewDidChange(_ textView: UITextView) {
        
        
        //
        //        var frame = textView.frame
        //
        //        let  constraintSize = CGSize.init(width: frame.size.width, height:CGFloat(MAXFLOAT) )
        //
        //
        //        let size  = textView .sizeThatFits(constraintSize)
        //
        //        if size.height >= frame.size.height {
        //            frame.size.height =  size.height
        //        }
        //        
        //        
        //        textView.frame = CGRect.init(x: frame.origin.x, y: frame.origin.y, width: frame.size.width, height: frame.size.height)
        //        
        
        
    }
    
    
    
    
    
}
