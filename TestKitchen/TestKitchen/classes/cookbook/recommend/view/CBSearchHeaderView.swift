//
//  CBSearchHeaderView.swift
//  TestKitchen
//
//  Created by qianfeng on 16/8/18.
//  Copyright © 2016年 ray. All rights reserved.
//

import UIKit

class CBSearchHeaderView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        /*
        //创建一个搜索框
        let searchBar = UISearchBar(frame: CGRectMake(0,0,bounds.size.width,bounds.size.height))
        searchBar.placeholder = "输入菜名或食材搜索"
        //searchBar的背景颜色修改
        //searchBar.barTintColor = UIColor.whiteColor()
        addSubview(searchBar)
        */
        
        let textField = UITextField(frame: CGRectMake(40,4,bounds.size.width-40*2,bounds.size.height-4*2))
        textField.borderStyle = .RoundedRect
        textField.placeholder = "输入菜名或食材搜索"
        addSubview(textField)
        
        //左边搜索图片
        let imageView = UIImageView.createImageView("search1")
        imageView.frame = CGRectMake(0, 0, 25, 25)
        textField.leftView = imageView
        textField.leftViewMode = .Always
        
        backgroundColor = UIColor(white: 0.8, alpha: 1.0)
        
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
