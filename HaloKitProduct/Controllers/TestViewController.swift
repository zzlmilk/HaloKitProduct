//
//  MainViewController.swift
//  HaloKitProduct
//
//  Created by zhou zhiling on 2017/6/29.
//  Copyright © 2017年 范博. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    
    override func loadView() {
        super.loadView()
        
        let label = UILabel(frame: self.view.bounds)
        label.frame = CGRect(x: 100, y: 100, width: 100, height: 100);
        label.text = "Hello, Swift"
        self.view.addSubview(label)
        
        
        
        let button:UIButton = UIButton(type:.contactAdd)
        button.frame = CGRect(x: 100, y: 200, width: 100, height: 100);
        self.view .addSubview(button);

        
        


    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
    
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    

        // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        // Get the new view controller using segue.destinationViewController.
//        // Pass the selected object to the new view controller.
//        
//    }


}
