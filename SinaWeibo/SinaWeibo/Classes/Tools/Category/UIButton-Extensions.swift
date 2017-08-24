//
//  UIButton-Extensions.swift
//  SinaWeibo
//
//  Created by 管章鹏 on 2017/8/24.
//  Copyright © 2017年 管章鹏. All rights reserved.
//

import UIKit

extension UIButton
{
   convenience init(imageName : String , backgroundImageName : String) {
    
        self.init()
        setBackgroundImage(UIImage(named:backgroundImageName), for: .normal)
        
        setBackgroundImage(UIImage(named:backgroundImageName + "_highlighted"), for: .highlighted)
        
        setImage(UIImage(named:imageName), for: .normal)
        setImage(UIImage(named:imageName + "_highlighted"), for: .highlighted)
        sizeToFit()
    
    }
}
