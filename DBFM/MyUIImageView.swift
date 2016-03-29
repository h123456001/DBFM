//
//  MyUIImageView.swift
//  DBFM
//
//  Created by Justine on 16/3/29.
//  Copyright © 2016年 hxb. All rights reserved.
//

import UIKit

class MyUIImageView: UIImageView {
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        //设置圆角
        self.clipsToBounds = true
        self.layer.cornerRadius = self.frame.size.width/2
        
        //边框描边
        self.layer.borderWidth = 4
        self.layer.borderColor = UIColor(colorLiteralRed: 1.0, green: 1.0, blue: 1.0, alpha: 0.7).CGColor
        
    }
    
    //旋转方法
    func onRoatation(){
        //动画实例关键字
        let animation = CABasicAnimation(keyPath: "transform.rotation")
        //初始值
        animation.fromValue = 0.0
        //结束值
        animation.toValue = M_PI*2.0
        //动画执行时间
        animation.duration = 20
        //动画重复次数
        animation.repeatCount = 10000
        self.layer.addAnimation(animation, forKey: nil)
    }

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */
}
