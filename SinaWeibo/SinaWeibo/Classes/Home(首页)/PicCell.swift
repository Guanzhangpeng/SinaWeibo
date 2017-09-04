//
//  PicCell.swift
//  SinaWeibo
//
//  Created by 管章鹏 on 2017/9/4.
//  Copyright © 2017年 管章鹏. All rights reserved.
//

import UIKit
import Kingfisher

class PicCell: UICollectionViewCell {

    @IBOutlet weak var iconView: UIImageView!
    
    var picURL : URL?
    {
        didSet{
            guard let picURL = picURL else {
                return
            }
            iconView.kf.setImage(with: picURL, placeholder: UIImage(named:"empty_picture"))
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()

    }

}
