//
//  StatusesCell.swift
//  SinaWeibo
//
//  Created by 管章鹏 on 2017/9/1.
//  Copyright © 2017年 管章鹏. All rights reserved.
//

import UIKit
import Kingfisher
fileprivate let edgeMargin : CGFloat = 15
fileprivate let itemMargin : CGFloat = 10
class StatusesCell: UITableViewCell {

    // MARK:- 控件属性
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var createTimeLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var sourceLabel: UILabel!
    @IBOutlet weak var verifyImage: UIImageView!
    @IBOutlet weak var rankImage: UIImageView!
    @IBOutlet weak var retweedText: UILabel!
    @IBOutlet weak var picView: PicCollectionView!
    @IBOutlet weak var retweetedBGView: UIView!
    
    @IBOutlet weak var StwtoolBar: UIView!
    
    // MARK:- 约束的属性
    @IBOutlet weak var contentLabelWidthCons: NSLayoutConstraint!
    @IBOutlet weak var picViewWCons: NSLayoutConstraint!
    @IBOutlet weak var picViewHCons: NSLayoutConstraint!
    @IBOutlet weak var picViewBottomCons: NSLayoutConstraint!
    
    @IBOutlet weak var retweetedTextTopCons: NSLayoutConstraint!
    var viewModel : StatusViewModel? {
        
        didSet{
            //1.0 nil值校验
            
            guard let viewModel = viewModel else {
                return
            }
            
            //2.0 给头像赋值
            iconImageView.kf.setImage(with: viewModel.profileImage_Url, placeholder: UIImage(named:"avatar_default_small"))
            
            //3.0 认证图标
            verifyImage.image = viewModel.verifyImage
            
            
            //3.0 昵称赋值
            titleLabel.text = viewModel.status?.user?.screen_name
           
            titleLabel.textColor = viewModel.vipImage == nil ? UIColor.black : UIColor.orange
            
            //4.0 会员等级
            rankImage.image = viewModel.vipImage
            
            //5.0 微博发布时间
            createTimeLabel.text = viewModel.created_Time
            
            //6.0 微博来源
            sourceLabel.text = viewModel.sourceText
            
            //7.0 微博正文
            contentLabel.text = viewModel.status?.text
            
            //8.0 设置转发微博
            if viewModel.status?.retweeted_status != nil{
                if let retweetedText = viewModel.status?.retweeted_status?.text, let retweetedScreen_name = viewModel.status?.retweeted_status?.user?.screen_name
                {
                    retweedText.text = "@"+"\(retweetedScreen_name): "+retweetedText
                }
                
                retweetedBGView.isHidden = false
                retweetedTextTopCons.constant  = 15
            }
            else
            {
                retweedText.text = nil
                retweetedBGView.isHidden = true
                retweetedTextTopCons.constant  = 0
            }
            
            //9.0 设置图片
            picView.picUrls = viewModel.picURLS
            
            // 计算配图的宽高
            let picSize = calcultePicSize(urlCount: viewModel.picURLS.count)
            
            picViewWCons.constant = picSize.width
            picViewHCons.constant = picSize.height
            
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        iconImageView.layer.cornerRadius = 20
        iconImageView.layer.masksToBounds = true
        contentLabelWidthCons.constant = UIScreen.main.bounds.width - 2 * edgeMargin
    }
}
extension StatusesCell
{
    fileprivate func calcultePicSize(urlCount : Int ) -> CGSize
    {
        //1.0 没有配图的情况
        if urlCount == 0
        {
            picViewBottomCons.constant = 0
            return CGSize.zero
        }
        
        picViewBottomCons.constant = 10
        
         let  layout = picView.collectionViewLayout as! UICollectionViewFlowLayout
         let picHW = (UIScreen.main.bounds.width - 2 * edgeMargin - 2 * itemMargin) / 3
         layout.itemSize = CGSize(width: picHW, height: picHW)
        
        //2.0 计算单张配图的宽高
        if urlCount == 1
        {
            //获取缓存的图片
            let url = viewModel?.picURLS.last?.absoluteString
            
            guard let cacheImage =  KingfisherManager.shared.cache.retrieveImageInDiskCache(forKey: url!) else {
                
               return CGSize(width: picHW, height: picHW)

            }
            
            layout.itemSize = CGSize(width: cacheImage.size.width * 2, height: cacheImage.size.height * 2)
            
            return CGSize(width: cacheImage.size.width * 2, height: cacheImage.size.height * 2)
          
        }
        //3.0 4张配图的情况
        if urlCount == 4
        {
            let picViewHW = picHW * 2 + itemMargin + 1
            
            return CGSize(width: picViewHW, height: picViewHW)
        }
        
        //4.0 其他张配图
        let row = CGFloat( (urlCount - 1 ) / 3 + 1 )
        
        let picViewH = picHW * row + (row - 1) * itemMargin
        
        let picViewW = UIScreen.main.bounds.width - 2 * edgeMargin
        
        return CGSize(width: picViewW, height: picViewH)
        
    }
}
