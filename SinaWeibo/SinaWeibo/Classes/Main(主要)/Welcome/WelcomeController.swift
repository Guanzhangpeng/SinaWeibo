//
//  WelcomeController.swift
//  SinaWeibo
//
//  Created by 管章鹏 on 2017/8/29.
//  Copyright © 2017年 管章鹏. All rights reserved.
//

import UIKit
import Kingfisher

class WelcomeController: UIViewController {
    
    // MARK:- 控件属性
    @IBOutlet weak var iconView: UIImageView!
    @IBOutlet weak var iconBottomCons: NSLayoutConstraint!
    
    // MARK:- 系统回调函数
    override func viewDidLoad() {
        super.viewDidLoad()
        
    //设置头像
    let profileURLString = UserAccountViewModal.shareInstance.userAccount?.avatar_large
   
    let url = URL(string: profileURLString ?? "")
    
    iconView.kf.setImage(with: url , placeholder: UIImage(named:"avatar_default_big"))
    
        
     iconBottomCons.constant = UIScreen.main.bounds.height - 200
        
        UIView.animate(withDuration: 1.5, delay: 0.0, usingSpringWithDamping: 0.7, initialSpringVelocity: 5.0, options: [], animations: {
            self.view.layoutIfNeeded()
        }) { (_) in
            UIApplication.shared.keyWindow?.rootViewController = UIStoryboard(name: "Main", bundle: nil).instantiateInitialViewController()
        }
    }
}
