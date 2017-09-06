//
//  ComposeTitleView.swift
//  SinaWeibo
//
//  Created by 管章鹏 on 2017/9/6.
//  Copyright © 2017年 管章鹏. All rights reserved.
//

import UIKit
import SnapKit

class ComposeTitleView: UIView {

    // MARK:- 懒加载
    fileprivate lazy var titleLabel : UILabel = UILabel()
    fileprivate lazy var screenNameLabel : UILabel = UILabel()
    
    
    // MARK:- 系统回调方法
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setUpUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
extension ComposeTitleView{
    fileprivate func setUpUI()
    {
        //1.0 添加子控件
        addSubview(titleLabel)
        addSubview(screenNameLabel)
        
        // 2.0 设置属性
        titleLabel.text = "发微博"
        screenNameLabel.text = UserAccountViewModal.shareInstance.userAccount?.screen_name
        
        titleLabel.snp.makeConstraints { (make) in
            make.top.equalTo(self)
            make.centerX.equalTo(self)
        }
        screenNameLabel.snp.makeConstraints { (make) in
            make.centerX.equalTo(titleLabel.snp.centerX)
            make.top.equalTo(titleLabel.snp.bottom).offset(3)
        }
        
        titleLabel.font = UIFont.systemFont(ofSize: 16)
        screenNameLabel.font = UIFont.systemFont(ofSize: 14)
        
        screenNameLabel.textColor = UIColor.lightGray
        
        titleLabel.textAlignment = .center
        screenNameLabel.textAlignment = .center
        
    }
}
