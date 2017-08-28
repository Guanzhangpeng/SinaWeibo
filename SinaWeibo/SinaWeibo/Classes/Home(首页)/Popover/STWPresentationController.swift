//
//  STWPresentationController.swift
//  SinaWeibo
//
//  Created by 郑隋 on 2017/8/28.
//  Copyright © 2017年 管章鹏. All rights reserved.
//

import UIKit

class STWPresentationController: UIPresentationController {

    var presentedFrame : CGRect = CGRect.zero
      // MARK : 懒加载属性
    fileprivate lazy var coverView : UIView = UIView()
    
    override func containerViewWillLayoutSubviews() {
        super.containerViewWillLayoutSubviews()
        
        //1.0 设置弹出View的尺寸
        presentedView?.frame = presentedFrame
        
        //2.0 添加遮盖View
        setupCoverView()
    }
}
extension STWPresentationController
{
    fileprivate func setupCoverView()
    {
        // 添加遮盖view
        containerView?.insertSubview(coverView, at: 0)
        
        // 设置属性
        coverView.frame = containerView!.bounds
        coverView.backgroundColor = UIColor(white: 0.8, alpha: 0.2)
        
        // 添加点击手势
        let tapGes = UITapGestureRecognizer(target: self, action: #selector(coverViewClick))
        
        coverView.addGestureRecognizer(tapGes)
    }
}

//MARK -点击事件
extension STWPresentationController
{
    @objc fileprivate func coverViewClick()
    {
        
        presentedViewController.dismiss(animated: true, completion: nil)
        
    }
}
