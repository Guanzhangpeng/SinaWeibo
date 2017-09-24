//
//  PhotoBrowerAnimator.swift
//  SinaWeibo
//
//  Created by 管章鹏 on 2017/9/21.
//  Copyright © 2017年 管章鹏. All rights reserved.
//

import UIKit


protocol AnimatorForPresentedDelegate : NSObjectProtocol {
    func startRect(indexPath : IndexPath) -> CGRect
    func endRect(indexPath : IndexPath) -> CGRect
    func imageView(indexPath : IndexPath) -> UIImageView?
}

protocol AnimatorForDismissDelegate : NSObjectProtocol {
    func imageViewForDismiss() -> UIImageView
    func indexPathForDismiss() -> IndexPath
}


class PhotoBrowerAnimator: NSObject {

    var isPresented : Bool = false
    
    var presentedDelegate : AnimatorForPresentedDelegate?
    var dismissDelegate : AnimatorForDismissDelegate?
    var indexPath : IndexPath?
}

extension PhotoBrowerAnimator : UIViewControllerTransitioningDelegate
{
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        isPresented = true
        return self
    }
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        isPresented = false
        return self
    }
}
extension PhotoBrowerAnimator : UIViewControllerAnimatedTransitioning
{
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.5
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
     
        isPresented ? animationControllerForPresented(using: transitionContext) : animationControllerForDismissed(using: transitionContext)
    }
    
    func animationControllerForPresented(using transitionContext: UIViewControllerContextTransitioning)
    {
        guard let presentedDelegate = presentedDelegate , let indexPath = indexPath else {
            return
        }
        
        //1.0 获取弹出的View
        let presentedView = transitionContext.view(forKey: UITransitionContextViewKey.to)!
        
        //2.0 添加到ContainerView中
        transitionContext.containerView.addSubview(presentedView)
        
        //3.0 获取到开始位置和临时图片
        let startFrame = presentedDelegate.startRect(indexPath: indexPath)
        guard  let tempImg = presentedDelegate.imageView(indexPath: indexPath) else{
            return
        }
        transitionContext.containerView.addSubview(tempImg)
        tempImg.frame = startFrame
        
        //3.0 添加动画
        presentedView.alpha = 0
        transitionContext.containerView.backgroundColor = UIColor.black
        
        UIView.animate(withDuration: transitionDuration(using: transitionContext), animations: {
            
            tempImg.frame = presentedDelegate.endRect(indexPath: indexPath)
            
        }) { (_) in
            presentedView.alpha = 1.0
            tempImg.removeFromSuperview()
            transitionContext.containerView.backgroundColor = UIColor.clear
            transitionContext.completeTransition(true)
        }
    }
    func animationControllerForDismissed(using transitionContext: UIViewControllerContextTransitioning)
    {
        guard let dismissDelegate = dismissDelegate , let presentedDelegate = presentedDelegate else {
            return
        }
        
        //1.0 获取消失的View
        let dismissedView = transitionContext.view(forKey: UITransitionContextViewKey.from)!
        dismissedView.removeFromSuperview()
        
        //2.0 获取即将消失的图片
        let tempImg = dismissDelegate.imageViewForDismiss()
        transitionContext.containerView.addSubview(tempImg)
        
        let indexPath = dismissDelegate.indexPathForDismiss()
        
        //2.0 执行动画
        UIView.animate(withDuration: transitionDuration(using: transitionContext), animations: { 
            
            tempImg.frame = presentedDelegate.startRect(indexPath: indexPath)
            
        }) { (_) in
            dismissedView.removeFromSuperview()
            transitionContext.completeTransition(true)
        }
      
    }
}
