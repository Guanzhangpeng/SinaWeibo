//
//  ComposeTextView.swift
//  SinaWeibo
//
//  Created by 管章鹏 on 2017/9/6.
//  Copyright © 2017年 管章鹏. All rights reserved.
//

import UIKit
import SnapKit

class ComposeTextView: UITextView {

    // MARK:- 懒加载
    lazy var placeHolderLabel : UILabel = UILabel()
  
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        setupUI()
    }

}
extension ComposeTextView
{
    fileprivate func setupUI()
    {
        // 1.0 添加子控件
        addSubview(placeHolderLabel)
        
        //2.0 设置属性
        placeHolderLabel.snp.makeConstraints { (maker) in
            maker.top.equalTo(8)
            maker.left.equalTo(10)
        }
        
        placeHolderLabel.textColor = UIColor.lightGray
        placeHolderLabel.font = font
        placeHolderLabel.text = "分享新鲜事..."
        textContainerInset = UIEdgeInsets(top: 6, left: 7, bottom: 0, right: 7)
        
    }
}
