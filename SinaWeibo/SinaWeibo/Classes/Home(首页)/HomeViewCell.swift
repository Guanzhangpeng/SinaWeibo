//
//  HomeViewCell.swift
//  SinaWeibo
//
//  Created by 管章鹏 on 2017/9/1.
//  Copyright © 2017年 管章鹏. All rights reserved.
//

import UIKit
import Kingfisher
fileprivate let edgeMargin : CGFloat = 15
class HomeViewCell: UITableViewCell {
    // MARK:- 控件属性
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var createTimeLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var sourceLabel: UILabel!
    @IBOutlet weak var verifyImage: UIImageView!
    @IBOutlet weak var rankImage: UIImageView!
    
  
    @IBOutlet weak var contentLabelWidthCons: NSLayoutConstraint!
    
    var viewModel : StatusViewModel? {
    
        didSet{
//            //1.0 nil值校验
//           
//            guard let viewModel = viewModel else {
//                return
//            }
//            
//            //2.0 给头像赋值
//            iconImageView.kf.setImage(with: viewModel.profileImage_Url, placeholder: UIImage(named:"avatar_default_small"))
//            
//            //3.0 认证图标
//            verifyImage.image = viewModel.verifyImage
//            
//            
//            //3.0 昵称赋值
//            titleLabel.text = viewModel.status?.user?.screen_name
//            
//            //4.0 会员等级
//            rankImage.image = viewModel.vipImage
//            
//            //5.0 微博发布时间
//            createTimeLabel.text = viewModel.created_Time
//            
//            //6.0 微博来源
//            sourceLabel.text = viewModel.sourceText
//            
//            //7.0 微博正文
//            contentLabel.text = viewModel.status?.text
            
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        
//        contentLabelWidthCons.constant = UIScreen.main.bounds.width - 2 * edgeMargin
        
    }
}
