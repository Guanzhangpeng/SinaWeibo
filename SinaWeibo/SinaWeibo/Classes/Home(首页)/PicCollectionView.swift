//
//  PicCollectionView.swift
//  SinaWeibo
//
//  Created by 管章鹏 on 2017/9/4.
//  Copyright © 2017年 管章鹏. All rights reserved.
//

import UIKit
import Kingfisher

class PicCollectionView: UICollectionView {


    var picUrls :[URL] = [URL]()
    {
        didSet{
            reloadData()
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        
        register(UINib(nibName: "PicCell", bundle: nil), forCellWithReuseIdentifier: "PicCell")
        dataSource = self
        delegate = self
    }

}
extension PicCollectionView : AnimatorForPresentedDelegate
{
    func startRect(indexPath: IndexPath) -> CGRect {
        //1.0 获取点击的cell
        let cell = self.cellForItem(at: indexPath)!
        
        //2.0 转换坐标系
        let frame = self.convert(cell.frame, to: UIApplication.shared.keyWindow)
        
        return frame
    }
    func endRect(indexPath: IndexPath) -> CGRect {
    
        //1.0 获取点击的图片
        let url =  picUrls[indexPath.item]
        
        guard let image = KingfisherManager.shared.cache.retrieveImageInDiskCache(forKey: url.absoluteString) else{
            return CGRect.zero
        }
        
        //2.0 计算大图的尺寸
        var y : CGFloat = 0
        let width = UIScreen.main.bounds.width
        let height = width/image.size.width * image.size.height
        
        if height > UIScreen.main.bounds.height
        {
            y = 0
        }
        else{
            y = (UIScreen.main.bounds.height - height) * 0.5
        }
        
        return CGRect(x: 0, y: y, width: width, height: height)
        
    
    }
    func imageView(indexPath: IndexPath) -> UIImageView? {
        //1.0 获取点击的图片
        let url =  picUrls[indexPath.item]
        
        guard let image = KingfisherManager.shared.cache.retrieveImageInDiskCache(forKey: url.absoluteString) else{
            return nil
        }
        
        //2.0 创建临时图片
        let tempImg = UIImageView()
        tempImg.image = image
        tempImg.contentMode = .scaleAspectFill
        tempImg.clipsToBounds = true
        
        return tempImg
    }
}
extension PicCollectionView : UICollectionViewDataSource , UICollectionViewDelegate
{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return picUrls.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PicCell", for: indexPath) as! PicCell
        cell.picURL = picUrls[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        //组装参数
        let userInfo : [String : Any] = [kPhotoBrowerIndexPath : indexPath , kPhotoBrowerUrls : picUrls]
        
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: kPhotoBrowerNote), object: self, userInfo: userInfo)
        
        
    }
}
