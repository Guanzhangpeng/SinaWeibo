//
//  picPickerCell.swift
//  SinaWeibo
//
//  Created by 管章鹏 on 2017/9/6.
//  Copyright © 2017年 管章鹏. All rights reserved.
//

import UIKit

class picPickerCell: UICollectionViewCell {

    // MARK:- 控件属性
    @IBOutlet weak var iconImage: UIImageView!
    @IBOutlet weak var removeButton: UIButton!
    @IBOutlet weak var picPickerButton: UIButton!
    var image : UIImage?{
        didSet{
           if image != nil{
            iconImage.image = image
            picPickerButton.isUserInteractionEnabled = false
            removeButton.isHidden = false
            
           }
           else {
            iconImage.image = nil
            picPickerButton.isUserInteractionEnabled = true
            removeButton.isHidden = true
            }
        }
    }
    
    // MARK:- 系统回调方法
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    

    @IBAction func picPickerButtonClick(_ sender: Any) {
        
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: kpicPickerAddNote), object: nil)
    }

    @IBAction func removePicClick(_ sender: Any) {
        
         NotificationCenter.default.post(name: NSNotification.Name(rawValue: kpicPickerRemoveNote), object: image)
    }
}
