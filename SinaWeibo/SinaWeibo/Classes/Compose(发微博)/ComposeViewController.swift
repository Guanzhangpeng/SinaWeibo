//
//  ComposeViewController.swift
//  SinaWeibo
//
//  Created by 管章鹏 on 2017/9/5.
//  Copyright © 2017年 管章鹏. All rights reserved.
//

import UIKit

class ComposeViewController: UIViewController {

    // MARK:- 控件属性
    @IBOutlet weak var composeView: ComposeTextView!
    
    fileprivate lazy var titleView : ComposeTitleView = ComposeTitleView()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setUpNavigationBar()
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        composeView.becomeFirstResponder()
    }
   
}
extension ComposeViewController
{
    fileprivate func setUpNavigationBar()
    {
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "关闭", style: .plain, target: self, action: #selector(closeButtonClick))
        
         navigationItem.rightBarButtonItem = UIBarButtonItem(title: "发送", style: .plain, target: self, action: #selector(composeButtonClick))
        
        titleView.frame = CGRect(x: 0, y: 0, width: 100, height: 40)
        
        navigationItem.titleView = titleView
        
    }
}
// MARK:- 点击事件
extension ComposeViewController{
    @objc fileprivate func closeButtonClick()
    {
        dismiss(animated: true, completion: nil)
    }
    @objc fileprivate func composeButtonClick()
    {
        STWLog("+++++++")
    }
}
// MARK:- 代理方法
extension ComposeViewController : UITextViewDelegate
{
    func textViewDidChange(_ textView: UITextView) {
        
        composeView.placeHolderLabel.isHidden = textView.hasText
        navigationItem.rightBarButtonItem?.isEnabled = textView.hasText
        
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        composeView.resignFirstResponder()
    }
}
