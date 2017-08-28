//
//  PopoverAnimator.swift
//  SinaWeibo
//
//  Created by 郑隋 on 2017/8/28.
//  Copyright © 2017年 管章鹏. All rights reserved.
//

import UIKit

class PopoverAnimator: NSObject {
    var presentedFrame : CGRect = CGRect.zero
    var isPresented : Bool = false
}
extension PopoverAnimator :UIViewControllerTransitioningDelegate
{
    // 目的: 改变弹出View的大小
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        
       let presentationController = STWPresentationController(presentedViewController: presented, presenting: presenting)
        presentationController.presentedFrame = presentedFrame
        return presentationController
    }
    
    // 目的:自定义弹出动画
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        isPresented = true
        return self
    }
    // 目的:自定义消失动画
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        isPresented = false
        return self
    }
}
extension PopoverAnimator : UIViewControllerAnimatedTransitioning
{
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.5
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
        isPresented ? animationForPresented(using: transitionContext) : animationForDismiss(using: transitionContext)
    }
    
    func animationForPresented(using transitionContext: UIViewControllerContextTransitioning){
        //1.0 获取即将弹出的View
        let presentedView = transitionContext.view(forKey: UITransitionContextViewKey.to)
        
        //2.0 添加到ContainerView上
        transitionContext.containerView.addSubview(presentedView!)
        
        //3.0 设置动画效果
        presentedView?.transform = CGAffineTransform(scaleX: 1.0, y: 0)
        presentedView?.layer.anchorPoint = CGPoint(x: 0.5, y: 0)
        
        UIView.animate(withDuration: transitionDuration(using: transitionContext), animations: {
            presentedView?.transform = CGAffineTransform.identity
        }) { (_) in
            
            transitionContext.completeTransition(true)
        }
    }
    
    func animationForDismiss(using transitionContext: UIViewControllerContextTransitioning){
        //1.0 获取即将消失的动画
        let dismissView = transitionContext.view(forKey: UITransitionContextViewKey.from)
        
        //2.0 设置动画效果
        UIView.animate(withDuration: transitionDuration(using: transitionContext), animations: {
            
            dismissView?.transform = CGAffineTransform(scaleX: 1.0, y: 0.0001)
        }) { (_) in
            transitionContext.completeTransition(true)
        }
    }
}
