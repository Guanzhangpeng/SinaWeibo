//
//  VisitorView.swift
//  SinaWeibo
//
//  Created by 管章鹏 on 2017/8/24.
//  Copyright © 2017年 管章鹏. All rights reserved.
//

import UIKit

class VisitorView: UIView {

    
    // MARK:- 控件属性
    @IBOutlet weak var rotationView: UIImageView!
    @IBOutlet weak var tipLabel: UILabel!
    @IBOutlet weak var iconView: UIImageView!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var registerButton: UIButton!
    
    // MARK:- 快速创建View的方法
   class func visitorView() -> VisitorView {
        return Bundle.main.loadNibNamed("VisitorView", owner: nil, options: nil)?.last as! VisitorView
    }
    
    // MARK:- 自定义函数
    func setupVisitorViewInfo(_ imageName : String , _ title : String) {
        self.iconView.image = UIImage(named: imageName)
        self.tipLabel.text = title
        rotationView.isHidden = true
    }
    
    func addRotationAnim()
    {
        //1.0 创建动画
        let rotationAnim = CABasicAnimation(keyPath: "transform.rotation.z")
        
        //2.0 设置动画属性
        rotationAnim.fromValue = 0
        rotationAnim.toValue = Double.pi * 2
        rotationAnim.duration = 5
        rotationAnim.isRemovedOnCompletion = false
        rotationAnim.repeatCount = MAXFLOAT
        
        //3.0 添加动画
        rotationView.layer.add(rotationAnim, forKey: nil)
    }
}
