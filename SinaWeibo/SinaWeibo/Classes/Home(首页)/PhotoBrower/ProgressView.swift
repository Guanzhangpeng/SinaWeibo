//
//  ProgressView.swift
//  SinaWeibo
//
//  Created by 管章鹏 on 2017/9/21.
//  Copyright © 2017年 管章鹏. All rights reserved.
//

import UIKit

class ProgressView: UIView {

    var progress : CGFloat = 0
    {
        didSet{
            setNeedsDisplay()
        }
    }
   
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        // 准备参数
        let center = CGPoint(x: rect.width * 0.5, y: rect.height * 0.5 )
        let radius = rect.width * 0.5 - 3
        let startAngle = CGFloat(-Double.pi/2)
        let endAngle = (CGFloat(Double.pi) * 2) * progress + startAngle
        
        //创建贝塞尔曲线
        let bezierPath = UIBezierPath(arcCenter: center, radius: radius, startAngle: startAngle, endAngle: endAngle, clockwise: true)
        
        //绘制一条到中心点的线条
        bezierPath.addLine(to: center)
        bezierPath.close()
        
        //设置绘制的颜色
        UIColor(white: 1.0, alpha: 0.4).setFill()

        bezierPath.fill()
    }
 

}
