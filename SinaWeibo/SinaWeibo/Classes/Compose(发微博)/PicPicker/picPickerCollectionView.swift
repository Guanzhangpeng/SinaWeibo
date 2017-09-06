//
//  picPickerCollectionView.swift
//  SinaWeibo
//
//  Created by 管章鹏 on 2017/9/6.
//  Copyright © 2017年 管章鹏. All rights reserved.
//

import UIKit
fileprivate let kCellID = "picPickerCell"
fileprivate let itemMargin : CGFloat = 15

class picPickerCollectionView: UICollectionView {

    // MARK:- 属性
    var images : [UIImage] = [UIImage]()
    {
        didSet{
            
            reloadData()
        }
    }
    // MARK:- 系统回调方法
    override func awakeFromNib() {
        super.awakeFromNib()
        
        dataSource = self
        
        //设置layout
        let layout = collectionViewLayout as! UICollectionViewFlowLayout
        let itemHW = (UIScreen.main.bounds.width - 4 * itemMargin) / 3
        layout.itemSize = CGSize(width: itemHW, height: itemHW)
        layout.minimumLineSpacing = itemMargin
        layout.minimumInteritemSpacing = itemMargin
        
        //设置CollectionView的属性
        contentInset = UIEdgeInsets(top: itemMargin, left: itemMargin, bottom: 0, right: itemMargin)
    
        //注册cell
        register(UINib(nibName: "picPickerCell", bundle: nil), forCellWithReuseIdentifier: kCellID)
    }
}

extension picPickerCollectionView : UICollectionViewDataSource
{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count == 9 ? images.count : images.count + 1
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kCellID, for: indexPath) as! picPickerCell
        cell.image = indexPath.item <= images.count - 1 ? images[indexPath.item] : nil
        return cell
    }
}
