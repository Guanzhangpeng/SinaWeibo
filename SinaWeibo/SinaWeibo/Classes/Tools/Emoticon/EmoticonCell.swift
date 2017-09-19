//
//  EmoticonCell.swift
//  Emoticon
//
//  Created by 管章鹏 on 2017/9/19.
//  Copyright © 2017年 管章鹏. All rights reserved.
//

import UIKit

class EmoticonCell: UICollectionViewCell {
    
    // MARK:- 懒加载
    fileprivate lazy var emoticonButton : UIButton = UIButton()
    var emoticon : Emoticon?{
        didSet{
            guard let emoticon = emoticon else {
                return
            }
            
            emoticonButton.setImage(UIImage(contentsOfFile: emoticon.pngPath ?? ""), for: .normal)
            emoticonButton.setTitle(emoticon.emojiCode, for: .normal)
            
            if emoticon.isRemove
            {
                emoticonButton.setImage(UIImage(named:"compose_emotion_delete"), for: .normal)
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
extension EmoticonCell
{
    fileprivate func setupUI()
    {
        contentView.addSubview(emoticonButton)
        emoticonButton.isUserInteractionEnabled = false
        emoticonButton.frame = contentView.bounds
        emoticonButton.titleLabel?.font = UIFont.systemFont(ofSize: 32)
        
    }
}
