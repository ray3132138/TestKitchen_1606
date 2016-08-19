//
//  CBHeaderView.swift
//  TestKitchen
//
//  Created by qianfeng on 16/8/19.
//  Copyright © 2016年 ray. All rights reserved.
//

import UIKit

class CBHeaderView: UIView {
    
    //标题
    private var titleLabel: UILabel?
    //图片
    private var imageView: UIImageView?
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        //创建一个背景视图:
        let bgView = UIView.createView()
        bgView.frame = CGRectMake(0, 10, bounds.size.width, bounds.size.height-10)
        bgView.backgroundColor = UIColor.whiteColor()
        addSubview(bgView)
        //标题文字
        let titleW: CGFloat = 100
        let imageW: CGFloat = 24
        let x = (bounds.size.width - titleW-imageW)/2
        
        titleLabel = UILabel.createLabel(nil, font: UIFont.boldSystemFontOfSize(18), textAlignment: .Center, textColor: UIColor.blackColor())
        titleLabel?.frame = CGRectMake(x, 10, titleW, bounds.size.height-10)
        addSubview(titleLabel!)
        
        //右边图片
        imageView = UIImageView.createImageView("more_icon")
        imageView?.frame = CGRectMake(x+titleW, 14, imageW, imageW)
        addSubview(imageView!)
        
        
        
        self.backgroundColor = UIColor(white: 0.8, alpha: 1.0)
    }
    
    //显示标题
    func configTitle(title: String){
        
        titleLabel?.text = title
        
        
        
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    
    
    
    
    

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

}
