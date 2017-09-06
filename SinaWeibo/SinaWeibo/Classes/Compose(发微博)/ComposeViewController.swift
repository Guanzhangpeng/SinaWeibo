//
//  ComposeViewController.swift
//  SinaWeibo
//
//  Created by 管章鹏 on 2017/9/5.
//  Copyright © 2017年 管章鹏. All rights reserved.
//

import UIKit

class ComposeViewController: UIViewController {

    // MARK:- 控件属性
    @IBOutlet weak var composeView: ComposeTextView!
    @IBOutlet weak var toolBarBottomCons: NSLayoutConstraint!
    @IBOutlet weak var picPickerViewHeightCons: NSLayoutConstraint!
    @IBOutlet weak var picPickerView: picPickerCollectionView!
    var isPickerImage : Bool = false
   
    // MARK:- 懒加载属性
    fileprivate lazy var titleView : ComposeTitleView = ComposeTitleView()
    fileprivate lazy var imageArray : [UIImage] = [UIImage]()
    
    
    
    // MARK:- 系统回调方法
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpNavigationBar()
        
        //监听通知
        setupNotification()
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if !isPickerImage
        {
             composeView.becomeFirstResponder()
        }
        
    }
   
}
extension ComposeViewController
{
    fileprivate func setUpNavigationBar()
    {
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "关闭", style: .plain, target: self, action: #selector(closeButtonClick))
        
         navigationItem.rightBarButtonItem = UIBarButtonItem(title: "发送", style: .plain, target: self, action: #selector(composeButtonClick))
        
        titleView.frame = CGRect(x: 0, y: 0, width: 100, height: 40)
        
        navigationItem.titleView = titleView
        
    }
}
// MARK:- 监听通知
extension ComposeViewController
{
    fileprivate func setupNotification()
    {
        NotificationCenter.default.addObserver(self, selector:#selector(keyboardWillChangeFrame(note:)), name: NSNotification.Name.UIKeyboardWillChangeFrame, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(addPicImage), name: NSNotification.Name(rawValue: kpicPickerAddNote), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(removePicImage(note:)), name: NSNotification.Name(rawValue:kpicPickerRemoveNote) , object: nil)
    }
}
// MARK:- 点击事件
extension ComposeViewController{
    @objc fileprivate func closeButtonClick()
    {
        dismiss(animated: true, completion: nil)
    }
    @objc fileprivate func composeButtonClick()
    {
        STWLog("+++++++")
    }
    
    @objc fileprivate func keyboardWillChangeFrame(note : NSNotification)
    {
        let duration = note.userInfo![UIKeyboardAnimationDurationUserInfoKey] as! TimeInterval
        let keyBoardFrame = (note.userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        let keyBoardY = UIScreen.main.bounds.height - keyBoardFrame.origin.y
        toolBarBottomCons.constant = keyBoardY
        UIView.animate(withDuration: duration) { 
            self.view.layoutIfNeeded()
        }
    }
    @objc fileprivate func addPicImage()
    {
        //1.0 判断照片源是否可用
        if !UIImagePickerController.isSourceTypeAvailable(.photoLibrary)
        {
            return
        }
        
        //2.0 创建照片选择控制器
        let ipc = UIImagePickerController()
        
        //3.0 设置照片源
        ipc.sourceType = .photoLibrary
        
        //4.0 设置代理
        ipc.delegate = self
        
        //5.0 弹出照片选择控制器
        present(ipc, animated: true, completion: nil)
    }
    
    
    @objc fileprivate func removePicImage(note : NSNotification)
    {
        guard let image = note.object as? UIImage ,   let imageIndex =  imageArray.index(of: image) else {
            return
        }
        
        //将照片从数组中删除
       imageArray.remove(at: imageIndex)
     
        //重新赋值
        picPickerView.images = imageArray
        
    }
    @IBAction func picPickerButtonClick(_ sender: Any) {
        
        //1.0 退出键盘
        composeView.resignFirstResponder()
        
        //2.0 改变picPickerView的高度
        picPickerViewHeightCons.constant = UIScreen.main.bounds.height * 0.65
        UIView.animate(withDuration: 0.5) { 
            self.view.layoutIfNeeded()
        }
    }
    
}
// MARK:- 代理方法
extension ComposeViewController : UITextViewDelegate
{
    func textViewDidChange(_ textView: UITextView) {
        composeView.placeHolderLabel.isHidden = textView.hasText
        navigationItem.rightBarButtonItem?.isEnabled = textView.hasText
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        composeView.resignFirstResponder()
    }
}

// MARK:- UIImagePickerControllerDelegate 代理方法
extension ComposeViewController :UIImagePickerControllerDelegate ,UINavigationControllerDelegate
{
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        STWLog(info)
       let image =  info[UIImagePickerControllerOriginalImage] as! UIImage
       imageArray.append(image)
        picPickerView.images = imageArray
        
        isPickerImage = true
        
        //退出照片选择控制器
        picker.dismiss(animated: true, completion: nil)
    }
}
