//
//  HomeViewController.swift
//  SinaWeibo
//
//  Created by 管章鹏 on 2017/8/23.
//  Copyright © 2017年 管章鹏. All rights reserved.
//

import UIKit
import Kingfisher
import MJRefresh
class HomeViewController: BaseTableViewController {
 
    // MARK:- 懒加载属性
    fileprivate lazy var titleBtn : titleButton = titleButton()
    fileprivate lazy var statuses : [StatusViewModel] = [StatusViewModel]()
    fileprivate lazy var tipLabel : UILabel = UILabel()
    
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
        
        //集成下载刷新
        setupHeader()
        setupFooter()
        setupTipLabel()
        
        //注册Cell
        tableView.register(UINib(nibName: "StatusesCell", bundle: nil), forCellReuseIdentifier: "StatusesCell")
        tableView.separatorStyle = .none
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
    fileprivate func setupHeader()
    {
        let header = MJRefreshNormalHeader(refreshingTarget: self, refreshingAction:#selector(loadNewStatues))
        
        tableView.mj_header = header
        
        tableView.mj_header.beginRefreshing()
    }
    fileprivate func setupFooter()
    {
        let footer = MJRefreshAutoNormalFooter(refreshingTarget: self, refreshingAction: #selector(loadMoreStatuses))
        
        tableView.mj_footer = footer
        tableView.mj_footer.beginRefreshing()
    }
    fileprivate func setupTipLabel()
    {
        navigationController?.navigationBar.insertSubview(tipLabel, at: 0)
        
//        navigationController?.navigationBar.insertSubview(tipLabel, belowSubview: _UIBarBackground)
        
        STWLog(navigationController?.navigationBar.subviews)
        
        //设置tipLabel的属性
        tipLabel.frame = CGRect(x: 0, y: 10, width: UIScreen.main.bounds.width, height: 32)
        tipLabel.backgroundColor = UIColor.orange
        tipLabel.textColor = UIColor.white
        tipLabel.font = UIFont.systemFont(ofSize: 15)
        tipLabel.textAlignment = .center
        tipLabel.isHidden = true

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
    @objc fileprivate func loadNewStatues()
    {
        loadData(isNewData: true)
    }
    
    @objc fileprivate func loadMoreStatuses()
    {
        loadData(isNewData: false)
    }
}

// MARK:- 网络请求
extension HomeViewController{
    fileprivate func loadData(isNewData : Bool)
    {
        var since_id : Int = 0
        var max_id : Int = 0
        if isNewData  {
            since_id = statuses.first?.status?.mid ?? 0
        }
        else
        {
            max_id = statuses.last?.status?.mid ?? 0
            
            max_id = max_id == 0 ? 0 :(max_id - 1)
        }
        
        
        NetWorkTools.Requst(methodType: .GET, urlString: "https://api.weibo.com/2/statuses/home_timeline.json" , parameters: ["access_token":(UserAccountViewModal.shareInstance.userAccount?.access_token)! as AnyObject , "since_id" : "\(since_id)" as AnyObject , "max_id":"\(max_id)" as AnyObject]) { (result) in
            
            guard  let dataDic = result as? [String : AnyObject] else{return}
            
            guard let dataArray = dataDic["statuses"] as? [[String : AnyObject]] else{return}
            
            var tempArray = [StatusViewModel]()
            
            for dict in dataArray
            {
                let status = Status(dict: dict)
                
                let vm = StatusViewModel(status: status)
                
                tempArray.append(vm)
                
            }
            
            if isNewData
            {
                self.statuses = tempArray + self.statuses
            }
            else{
                
                self.statuses = self.statuses + tempArray
            }
            
            //缓存图片
            self.cachesImgs(statuses: tempArray)
           
        }
    }
    
    fileprivate func cachesImgs(statuses : [StatusViewModel])
    {
        //1.0 创建队列组
        let group = DispatchGroup.init()
        
        for statusViewModel in statuses {
           if  statusViewModel.picURLS.count == 1
           {
            //2.0 缓存图片
            group.enter()
            
            KingfisherManager.shared.downloader.downloadImage(with: statusViewModel.picURLS[0])
            group.leave()
            
            }
        }
        group.notify(queue:  DispatchQueue.main) {
            self.tableView.reloadData()
            self.tableView.mj_header.endRefreshing()
            self.tableView.mj_footer.endRefreshing()
            
            self.showTipLabel(statuses.count)
        }
        
    }
    
    fileprivate func showTipLabel(_ statusCount : Int)
    {
        //显示TipLabel
        tipLabel.isHidden = false
        tipLabel.text = statusCount == 0 ? "没有新微博" : "更新了\(statusCount)条微博"
        
        //执行动画效果
        UIView.animate(withDuration: 1.0, animations: {
            
            self.tipLabel.frame.origin.y = 44
            
        }) { (_) in
            
            UIView.animate(withDuration: 1.0, delay: 1.5, options: [], animations: {
                
                self.tipLabel.frame.origin.y = 10
                
            }, completion: { (_) in
                self.tipLabel.isHidden = true
            })
        }
    }
}
// MARK:- tableView的数据源方法
extension HomeViewController{
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return statuses.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "StatusesCell", for: indexPath) as! StatusesCell
        cell.selectionStyle = .none
        cell.viewModel = statuses[indexPath.row]
        return cell
    }

}
