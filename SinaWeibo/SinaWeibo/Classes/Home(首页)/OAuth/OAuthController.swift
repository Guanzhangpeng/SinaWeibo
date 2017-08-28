//
//  OAuthController.swift
//  SinaWeibo
//
//  Created by 郑隋 on 2017/8/28.
//  Copyright © 2017年 管章鹏. All rights reserved.
//

import UIKit
import SVProgressHUD

class OAuthController: UIViewController {

      // MARK : 系统属性
    @IBOutlet weak var webView: UIWebView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        //设置导航栏
        setupNavigationBar()
        
        //加载网页
        loadPage()
   }
}
//MARK -界面布局
extension OAuthController
{
    fileprivate func setupNavigationBar()
    {
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "取消", style: .plain, target: self, action: #selector(cancelClick))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "填充", style: .plain, target: self, action: #selector(fillLoginInfo))
    
        title = "登录"
    }
    fileprivate func loadPage()
    {
        let urlStr = "https://api.weibo.com/oauth2/authorize?client_id=\(APP_Key)&redirect_uri=\(Redirect_Uri)"
        guard let url = URL(string: urlStr) else {
            return
        }
        //请求授权页面
        webView.loadRequest(URLRequest(url: url))
    }
}

//MARK -点击事件
extension OAuthController
{
    @objc fileprivate func cancelClick()
    {
        dismiss(animated: true, completion: nil)
    }
    @objc fileprivate func fillLoginInfo()
    {
        // 1.书写js代码 : javascript / java --> 雷锋和雷峰塔
        let jsCode = "document.getElementById('userId').value='zswangzp@163.com';document.getElementById('passwd').value='abcdef1234567890';"
        
        webView.stringByEvaluatingJavaScript(from: jsCode)
    }
}

extension OAuthController : UIWebViewDelegate
{
    func webView(_ webView: UIWebView, shouldStartLoadWith request: URLRequest, navigationType: UIWebViewNavigationType) -> Bool {
        guard let url = request.url else {
            return true
        }

        let urlStr = url.absoluteString
        
        //判断是否包含code
        guard urlStr.contains("code=")  else {
            return true
        }
    
        //截取code 
        let code = urlStr.components(separatedBy: "code=").last!
        
        //请求AccessToken
        NetWorkTools.Requst(methodType: .POST , urlString: "https://api.weibo.com/oauth2/access_token", parameters: ["client_id":APP_Key as AnyObject , "client_secret":APP_Secret as AnyObject , "grant_type":"authorization_code" as AnyObject, "code":code as AnyObject , "redirect_uri":"http://www.baidu.com" as AnyObject]) { (response) in
            
            STWLog(response)
            
            //字典转模型
            let account = UserAccount(dict: response as! [String : AnyObject])
            
            STWLog(account)
        }
        
        return false
    }
    func webViewDidStartLoad(_ webView: UIWebView) {
        SVProgressHUD.show()
    }
    func webViewDidFinishLoad(_ webView: UIWebView) {
        SVProgressHUD.dismiss()
    }
    func webView(_ webView: UIWebView, didFailLoadWithError error: Error) {
         SVProgressHUD.dismiss()
    }
}
