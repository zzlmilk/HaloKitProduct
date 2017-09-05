//
//  ImageViewExtension.swift
//
//  ImageHelper
//  Version 3.2.2
//
//  Created by Melvin Rivera on 7/23/14.
//  Copyright (c) 2014 All Forces. All rights reserved.
//

import Foundation
import UIKit
import QuartzCore

public extension UIImageView {
    
    func imageFromURL(_ url: String, placeholder: UIImage, fadeIn: Bool = true, shouldCacheImage: Bool = true, closure: ((_ image: UIImage?) -> ())? = nil)
    {
        self.image = UIImage.image(fromURL: url, placeholder: placeholder, shouldCacheImage: shouldCacheImage) {
            (image: UIImage?) in
            if image == nil {
                return
            }
            self.image = image
            if fadeIn {
                let transition = CATransition()
                transition.duration = 0.5
                transition.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
                transition.type = kCATransitionFade
                self.layer.add(transition, forKey: nil)
            }
            closure?(image)
        }
    }
    
    
}
 
