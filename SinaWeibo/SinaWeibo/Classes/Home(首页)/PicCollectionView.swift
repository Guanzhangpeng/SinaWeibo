//
//  PicCollectionView.swift
//  SinaWeibo
//
//  Created by 管章鹏 on 2017/9/4.
//  Copyright © 2017年 管章鹏. All rights reserved.
//

import UIKit

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
        
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: kPhotoBrowerNote), object: nil, userInfo: userInfo)
        
        
    }
}
