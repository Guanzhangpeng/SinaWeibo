//
//  titleButton.swift
//  SinaWeibo
//
//  Created by 管章鹏 on 2017/8/25.
//  Copyright © 2017年 管章鹏. All rights reserved.
//

import UIKit

class titleButton: UIButton {

 
    override init(frame: CGRect) {
        super.init(frame: frame)
      
      setImage(UIImage(named:"navigationbar_arrow_down"), for: .normal)
      setImage(UIImage(named:"navigationbar_arrow_up"), for: .selected)
      setTitleColor(UIColor.black, for: .normal)
      sizeToFit()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        titleLabel?.frame.origin.x = 0
        imageView?.frame.origin.x = titleLabel!.frame.width + 5
    }
}
