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
    fileprivate lazy var statuses : [StatusViewModel] = [StatusViewModel]()
    
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
        
        // 获取首页数据
        loadData()
        
        tableView.rowHeight = UITableViewAutomaticDimension
        
        tableView.estimatedRowHeight = 200
    }
}

// MARK:- 设置UI
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

// MARK:- 网络请求
extension HomeViewController{
    fileprivate func loadData()
    {
        NetWorkTools.Requst(methodType: .GET, urlString: "https://api.weibo.com/2/statuses/home_timeline.json" , parameters: ["access_token":(UserAccountViewModal.shareInstance.userAccount?.access_token)! as AnyObject]) { (result) in
            
            guard  let dataDic = result as? [String : AnyObject] else{return}
            
            guard let dataArray = dataDic["statuses"] as? [[String : AnyObject]] else{return}
            
            for dict in dataArray
            {
                let status = Status(dict: dict)
                
                let vm = StatusViewModel(status: status)
                
                self.statuses.append(vm)
            }
            self.tableView.reloadData()
        }
    }
}

// MARK:- tableView的数据源方法
extension HomeViewController{
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return statuses.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "StatusCell", for: indexPath) as! HomeViewCell
        
        cell.viewModel = statuses[indexPath.row]
        
        return cell
    }
}
