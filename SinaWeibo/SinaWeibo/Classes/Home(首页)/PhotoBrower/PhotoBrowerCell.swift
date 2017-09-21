//
//  PhotoBrowerCell.swift
//  SinaWeibo
//
//  Created by 管章鹏 on 2017/9/20.
//  Copyright © 2017年 管章鹏. All rights reserved.
//

import UIKit
import Kingfisher
class PhotoBrowerCell: UICollectionViewCell {
    
    //属性
    var url : URL?
    {
        didSet{
          setupContent(url: url)
        }
    }
    
    var closePhotoBrowerCallBack : (() -> ())?
    
    // MARK:- 懒加载
    fileprivate lazy var scrollView : UIScrollView = UIScrollView()
    var imgView : UIImageView = UIImageView()
    fileprivate lazy var progressView : ProgressView = ProgressView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
extension PhotoBrowerCell
{
    fileprivate func setupUI()
    {
        contentView.addSubview(scrollView)
        contentView.addSubview(progressView)
        scrollView.addSubview(imgView)
        
        scrollView.frame = contentView.bounds
        scrollView.frame.size.width -= 20
        progressView.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
        progressView.center = CGPoint(x: UIScreen.main.bounds.width * 0.5 , y: UIScreen.main.bounds.height * 0.5)
        
        progressView.isHidden = true
        progressView.backgroundColor = UIColor.clear
        let tapGes = UITapGestureRecognizer(target: self, action: #selector(closePhotoBrower))
        
        scrollView.addGestureRecognizer(tapGes)
    }
    fileprivate func setupContent(url : URL?)
    {
        // 1.0 获取图片
        guard let url = url else {
            return
        }
        
        STWLog(url)
        let cacheImage = KingfisherManager.shared.cache.retrieveImageInDiskCache(forKey: url.absoluteString)!
        

        let width = UIScreen.main.bounds.width
        let height = width / cacheImage.size.width * cacheImage.size.height
        var y : CGFloat = 0
        if height > UIScreen.main.bounds.height
        {
            y = 0
        }
        else
        {
            y = (UIScreen.main.bounds.height - height) * 0.5
        }
        
        imgView.frame = CGRect(x: 0, y: y, width: width, height: height)
        progressView.isHidden = false
        
        imgView.kf.setImage(with: getBigImg(url: url), placeholder: cacheImage, options: [], progressBlock: { (current, total) in
            self.progressView.progress = CGFloat(current) / CGFloat(total)
        }) { (bigImage, _, _, _) in
            
            self.progressView.isHidden = true
            let height = width / bigImage!.size.width * bigImage!.size.height
            var y : CGFloat = 0
            if height > UIScreen.main.bounds.height
            {
                y = 0
            }
            else
            {
                y = (UIScreen.main.bounds.height - height) * 0.5
            }
            
            self.imgView.frame = CGRect(x: 0, y: y, width: width, height: height)
            self.scrollView.contentSize = CGSize(width: 0, height: height)
        }
        
    }
    fileprivate func getBigImg(url : URL) -> URL
    {
        let urlStr = url.absoluteString
        
       let bigImgStr =  urlStr.replacingOccurrences(of: "thumbnail", with: "bmiddle")
        
        return URL(string: bigImgStr)!
    }
}

extension PhotoBrowerCell{
    @objc fileprivate func closePhotoBrower()
    {
        if (closePhotoBrowerCallBack != nil) {
            closePhotoBrowerCallBack!()
        }
    }
}
