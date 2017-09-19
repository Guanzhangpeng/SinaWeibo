//
//  EmoticonViewController.swift
//  Emoticon
//
//  Created by 管章鹏 on 2017/9/19.
//  Copyright © 2017年 管章鹏. All rights reserved.
//

import UIKit

fileprivate let kCellID = "kCellID"
class EmoticonViewController: UIViewController {

    // MARK:- 数据懒加载
    fileprivate lazy var manager : EmoticonManager = EmoticonManager()
    var selectedEmoticonCallBack : (_ emoticon : Emoticon) -> ()
    fileprivate lazy var collectionView : UICollectionView = {
    
        let layout = EmoticonViewLayout()
        
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        
        collectionView.dataSource = self;
        collectionView.delegate = self
        collectionView.register(EmoticonCell.self, forCellWithReuseIdentifier: kCellID)
        
        //设置Collectionview的属性
        collectionView.isPagingEnabled = true
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = false
        
        return collectionView
    }()
    
    fileprivate lazy var toolBar : UIToolbar = {
    
        let titles = ["最近","默认","emoji","浪小花"]
        var tempItems = [UIBarButtonItem]()
        
        var index = 0
        for title in titles
        {
            let item = UIBarButtonItem(title: title, style: .plain, target: self, action: #selector(itemClick(item:)))
            item.tag = index
            tempItems.append(item)
            index += 1
            tempItems.append(UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil))
        }
        
        let toolBar = UIToolbar()
        tempItems.removeLast()
        toolBar.items = tempItems
        toolBar.tintColor = UIColor.orange
        return toolBar
    }()
    
    init(selectedEmoticonCallBack : @escaping (_ emoticon : Emoticon) -> ())
    {
        self.selectedEmoticonCallBack = selectedEmoticonCallBack
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    // MARK:- 系统回调函数
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
}
extension EmoticonViewController
{
    fileprivate func setupUI()
    {
        //1.0 添加控件
        view.addSubview(collectionView)
        view.addSubview(toolBar)
        
        //2.0 添加约束
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        toolBar.translatesAutoresizingMaskIntoConstraints = false
        let views : [String : Any] = ["toolBar":toolBar , "collectionView":collectionView]
        var cons = NSLayoutConstraint.constraints(withVisualFormat: "H:|-0-[toolBar]-0-|", options: [], metrics: nil, views: views)
        
        cons += NSLayoutConstraint.constraints(withVisualFormat: "V:|-0-[collectionView]-0-[toolBar]-0-|", options: [.alignAllLeft , .alignAllRight], metrics: nil, views: views)
        
        view.addConstraints(cons)
        
        
    }
}
// MARK:- 点击事件
extension EmoticonViewController
{
    @objc fileprivate func itemClick(item : UIBarButtonItem)
    {
        //1.0 获取tag值
        let tag = item.tag
        
        let indexPath = IndexPath(item: 0, section: tag)
        
        collectionView.scrollToItem(at: indexPath, at: .left, animated: true)
    }
}
extension EmoticonViewController : UICollectionViewDataSource , UICollectionViewDelegate
{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return manager.packages.count
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        let packages = manager.packages[section]
        
        return packages.emoticons.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kCellID, for: indexPath) as! EmoticonCell
        
        cell.backgroundColor = indexPath.item % 2 == 0 ? .red : .blue
        let packages = manager.packages[indexPath.section]
        cell.emoticon = packages.emoticons[indexPath.item]        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let packages = manager.packages[indexPath.section]
        let emoticon = packages.emoticons[indexPath.item]
        
        //插入最近的表情
        insertRecentlyEmoticon(emoticon: emoticon)
        
        //回调
        selectedEmoticonCallBack(emoticon)
        
    }
    
    fileprivate func insertRecentlyEmoticon(emoticon : Emoticon)
    {
        //1.0 如果是删除或者是空白表情
        if emoticon.isRemove || emoticon.isEmpty {
            return
        }
        //2.0 判断最近的表情中是否包含该表情
        if  manager.packages.first!.emoticons.contains(emoticon)
        {
            //获取该表情所在的位置
            let index = manager.packages.first!.emoticons.index(of: emoticon)!
            
            manager.packages.first!.emoticons.remove(at: index)
        }
        else
        {
             manager.packages.first!.emoticons.remove(at: 19)
        }
        
        manager.packages.first!.emoticons.insert(emoticon, at: 0)
    }
}
class  EmoticonViewLayout: UICollectionViewFlowLayout {
    override func prepare() {
        super.prepare()
        
        let itemWH = UIScreen.main.bounds.width / 7
        
        //设置Layout属性
          itemSize = CGSize(width: itemWH, height: itemWH)
          minimumLineSpacing = 0
          minimumInteritemSpacing = 0
          scrollDirection = .horizontal
        
        let margin = (collectionView!.bounds.height - 3 * itemWH) / 2
        collectionView?.contentInset = UIEdgeInsets(top: margin, left: 0, bottom: margin, right: 0)
    
        
     
    }
}
