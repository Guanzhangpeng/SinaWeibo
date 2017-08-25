//
//  UIBarButtonItem-Extensions.swift
//  SinaWeibo
//
//  Created by 管章鹏 on 2017/8/25.
//  Copyright © 2017年 管章鹏. All rights reserved.
//

import UIKit

extension UIBarButtonItem
{
    convenience init(imageName: String)
    {
        let buttonItem = UIButton()
        buttonItem.setImage(UIImage(named:imageName), for: .normal)
        buttonItem.setImage(UIImage(named:imageName + "_highlighted"), for: .highlighted)
        buttonItem.sizeToFit()
        
        self.init(customView: buttonItem)
    }
}
