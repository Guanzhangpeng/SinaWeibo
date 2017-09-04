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
    }

}
extension PicCollectionView : UICollectionViewDataSource
{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return picUrls.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PicCell", for: indexPath) as! PicCell
        cell.picURL = picUrls[indexPath.row]
        return cell
    }
}
