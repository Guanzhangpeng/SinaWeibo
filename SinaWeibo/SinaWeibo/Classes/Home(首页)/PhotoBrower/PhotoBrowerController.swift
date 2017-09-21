//
//  PhotoBrowerController.swift
//  SinaWeibo
//
//  Created by 管章鹏 on 2017/9/20.
//  Copyright © 2017年 管章鹏. All rights reserved.
//

import UIKit
import SnapKit
import SVProgressHUD

fileprivate let kPhotoBrowerCellID = "kPhotoBrowerCellID"
class PhotoBrowerController: UIViewController {

    var indexPath : IndexPath
    var urls : [URL]
    
    // MARK:- 懒加载
    fileprivate lazy var closeBtn : UIButton = UIButton(UIColor.gray, font: UIFont.systemFont(ofSize: 14), title: "关 闭")
    fileprivate lazy var saveBtn : UIButton = UIButton(UIColor.gray, font: UIFont.systemFont(ofSize: 14), title: "保 存")
    fileprivate lazy var collectionView : UICollectionView = {
    
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: PhotoBrowerCollectionViewLayout())
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.isPagingEnabled = true
        collectionView.dataSource = self
        collectionView.register(PhotoBrowerCell.self, forCellWithReuseIdentifier: kPhotoBrowerCellID)
        return collectionView
        
    }()
    // MARK:- 系统回调函数
    init(indexPath : IndexPath , urls : [URL])
    {
        
        self.indexPath = indexPath
        self.urls = urls
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.orange
        
        setupUI()
        
        //滚动到点击的位置
        collectionView.scrollToItem(at: indexPath, at: .left, animated: false)
    }
    override func loadView() {
        super.loadView()
        
        view.frame.size.width += 20
    }

}
// MARK:- 布局UI
extension PhotoBrowerController
{
    fileprivate func setupUI()
    {
        //1.0 添加控件
        view.addSubview(collectionView)
        view.addSubview(closeBtn)
        view.addSubview(saveBtn)
        
        //设置frame
        collectionView.frame = view.bounds
        closeBtn.snp.makeConstraints { (make) in
            make.left.equalTo(20)
            make.bottom.equalTo(-10)
            make.size.equalTo(CGSize(width: 90, height: 32))
            
        }
        saveBtn.snp.makeConstraints { (make) in
            make.right.equalTo(-40)
            make.bottom.equalTo(closeBtn.snp.bottom)
            make.size.equalTo(closeBtn.snp.size)
            
        }
        
        closeBtn.addTarget(self, action: #selector(closeBtnClick), for: .touchUpInside)
        saveBtn.addTarget(self, action: #selector(saveBtnClick), for: .touchUpInside)
        
  
    }
}
// MARK:- 点击事件
extension PhotoBrowerController
{
    @objc fileprivate func closeBtnClick()
    {
        dismiss(animated: true, completion: nil)
    }
    @objc fileprivate func saveBtnClick()
    {
       //获取正在显示的cell
        let cell = collectionView.visibleCells.first as! PhotoBrowerCell
        
        guard let imgview = cell.imgView.image else {
            return
        }
        
        UIImageWriteToSavedPhotosAlbum(imgview, self, #selector(image(image:didFinishSavingWithError:contextInfo:)), nil)

        
    }
    
    @objc fileprivate func image(image : UIImage, didFinishSavingWithError error : NSError?, contextInfo : AnyObject) {
        var showInfo = ""
        if error != nil {
            showInfo = "保存失败"
        } else {
            showInfo = "保存成功"
        }
        
        SVProgressHUD.showInfo(withStatus: showInfo)
    }
}
extension PhotoBrowerController : UICollectionViewDataSource
{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return urls.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kPhotoBrowerCellID, for: indexPath) as! PhotoBrowerCell
        
        cell.backgroundColor = indexPath.item % 2 == 0 ? UIColor.red : UIColor.blue
        
        cell.url = urls[indexPath.item]
        cell.closePhotoBrowerCallBack = {
             self.dismiss(animated: true, completion: nil)
        }
        return cell
    }
}
class PhotoBrowerCollectionViewLayout: UICollectionViewFlowLayout {
    override func prepare() {
        super.prepare()
        
        itemSize = collectionView!.bounds.size
        scrollDirection = .horizontal
        minimumLineSpacing = 0
        minimumInteritemSpacing = 0
    }
}
