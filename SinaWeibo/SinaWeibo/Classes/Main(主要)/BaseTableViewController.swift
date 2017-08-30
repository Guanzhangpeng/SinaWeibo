//
//  BaseTableViewController.swift
//  SinaWeibo
//
//  Created by 管章鹏 on 2017/8/24.
//  Copyright © 2017年 管章鹏. All rights reserved.
//

import UIKit

class BaseTableViewController: UITableViewController {

    lazy var visitorView : VisitorView = VisitorView.visitorView()
    
    var isLogin = UserAccountViewModal.shareInstance.isLogin
    
    // MARK:- 系统回调方法
    override func loadView() {
        STWLog("=================")
        
        isLogin ? super.loadView() : setupVisitorView()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
}

//Mark:- 初始化UI
extension BaseTableViewController
{
    fileprivate func setupUI()
    {
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "注册", style: .plain, target: self, action: #selector(registerBtnClick))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "登录", style: .plain, target: self, action: #selector(loginBtnClick))
        
        visitorView.loginButton.addTarget(self, action: #selector(loginBtnClick), for: .touchUpInside)
        visitorView.registerButton.addTarget(self, action: #selector(registerBtnClick), for: .touchUpInside)
        
    }
    fileprivate func setupVisitorView()
    {
        view = visitorView
    }
}

//Mark: -  点击事件
extension BaseTableViewController
{
    @objc fileprivate func registerBtnClick()
    {
        STWLog("注册....")
    }
    @objc fileprivate func loginBtnClick()
    {
        //弹出授权页面
        let vc = OAuthController()
        
        let nav = UINavigationController(rootViewController: vc)
        
        present(nav, animated: true, completion: nil)
    }
}

