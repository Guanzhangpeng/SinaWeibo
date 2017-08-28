//
//  HomeViewController.swift
//  SinaWeibo
//
//  Created by 管章鹏 on 2017/8/23.
//  Copyright © 2017年 管章鹏. All rights reserved.
//

import UIKit

class HomeViewController: BaseTableViewController {
 
    // MARK:- 懒加载属性
    fileprivate lazy var titleBtn : titleButton = titleButton()
    
    fileprivate lazy var popoverAnimator : PopoverAnimator =  PopoverAnimator {[weak self] (presented) -> () in
        self?.titleBtn.isSelected = presented
    }
    
    // MARK:- 系统回调函数
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // MARK:- 未登录操作
        // 添加旋转动画
        visitorView.addRotationAnim()
        
        if !isLogin
        {
            return
        }
        
        // MARK:- 已登录操作
        setupUI()
    }
}

extension HomeViewController
{
    fileprivate func setupUI()
    {
        navigationItem.leftBarButtonItem = UIBarButtonItem(imageName: "navigationbar_friendattention")
        navigationItem.rightBarButtonItem = UIBarButtonItem(imageName: "navigationbar_pop")
        
        titleBtn.setTitle("Mark_Guan", for: .normal)
        navigationItem.titleView = titleBtn
        
        //titleBtn添加点击事件
        titleBtn.addTarget(self, action: #selector(titleBtnClick(titleBtn:)), for: .touchUpInside)
    }
}
// MARK:- 点击事件
extension HomeViewController
{
    @objc fileprivate func titleBtnClick(titleBtn : titleButton)
    {
        
        //创建弹出控制器
        let vc = PopoverViewController()
        
        //设置代理
        vc.transitioningDelegate = popoverAnimator
        popoverAnimator.presentedFrame = CGRect(x: 100, y: 64, width: 180, height: 250)
        
        //设置弹出样式
        vc.modalPresentationStyle = .custom
        
        present(vc, animated: true, completion: nil)
    }
}

