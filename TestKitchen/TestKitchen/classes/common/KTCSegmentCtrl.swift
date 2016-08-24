//
//  KTCSegmentCtrl.swift
//  TestKitchen
//
//  Created by qianfeng on 16/8/23.
//  Copyright © 2016年 ray. All rights reserved.
//

import UIKit

protocol KTCSegmentCtrlDelegate: NSObjectProtocol{
    func didSelectSegCtrl(segCtrl: KTCSegmentCtrl, atIndex index: Int)
}



class KTCSegmentCtrl: UIView {
    
    //代理属性
    weak var delegate: KTCSegmentCtrlDelegate?
    
    
    //选中按钮的序号
    var selectIndex: Int = 0 {
        didSet{
            if selectIndex != oldValue{
                
                selectBtnAtIndex(selectIndex, lastIndex: oldValue)

            }
            
        }
        
    }
    
    //下划线视图
    private var lineView: UIView?
    
    //重新实现初始化方法
    /*
     titleNames: 每个按钮上面显示文字的数组
     */
    init(frame: CGRect, titleNames: [String]) {
        super.init(frame: frame)
        
        if titleNames.count > 0{
            //按钮的宽度
            let w:CGFloat = bounds.size.width/CGFloat(titleNames.count)
            for i in 0..<titleNames.count{
                //计算按钮的frame
                let frame = CGRectMake(CGFloat(i)*w, 0, w, bounds.size.height)
                
                let btn = KTCSegmentBtn(frame: frame)
                //显示数据
                btn.configTitle(titleNames[i])
                
                //tag值
                btn.tag = 300+i
                
                //点击事件
                btn.addTarget(self, action: #selector(clickbtn(_:)), forControlEvents: .TouchUpInside)
                
                
                addSubview(btn)
                
                //默认选中第一个
                if i == 0{
                    btn.clicked = true
                }
                
                
            }
            
            //下划线视图
            lineView = UIView.createView()
            lineView?.backgroundColor = UIColor.orangeColor()
            lineView?.frame = CGRectMake(0, bounds.size.height-2, w, 2)
            addSubview(lineView!)
            
        }
        
        
        
        
    }
    //index:当前选中的序号
    //lastIndex 上次选中的序号
    func selectBtnAtIndex(index: Int, lastIndex: Int){
        //1.修改UI
        let curBtn = viewWithTag(300+index)
        
        if curBtn?.isKindOfClass(KTCSegmentBtn.self) == true{
            let btn = curBtn as! KTCSegmentBtn
            //选中当前点击的按钮
            btn.clicked = true
            
        }
        
        
        //取消上次选中的按钮
        let lastBtn = viewWithTag(300+lastIndex)
        
        if lastBtn?.isKindOfClass(KTCSegmentBtn.self) == true{
            let lastSegBtn = lastBtn as! KTCSegmentBtn
            lastSegBtn.clicked = false
            
        }
//        //修改当前选中的序号
//        selectIndex = index
        
        
        //修改下划线视图的位置
        lineView?.frame.origin.x = (lineView?.bounds.size.width)! * CGFloat(selectIndex)
        
    }
    
    func clickbtn(btn: KTCSegmentBtn){
        
        //如果点击的是已经选中的按钮
        if btn.tag != 300+selectIndex{
            
            //1.修改UI
            selectIndex = btn.tag - 300
    
            
            //2.其他的操作
            delegate?.didSelectSegCtrl(self, atIndex: selectIndex)
            
            
        }
        
        
        
    }
    
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    

}

class KTCSegmentBtn: UIControl{
    
    private var label: UILabel?
    
    
    var clicked: Bool? {
        didSet{
            
            if clicked == true{
                //选中
                label?.textColor = UIColor.blackColor()
                
            }else if clicked == false{
                //取消选中
                label?.textColor = UIColor.grayColor()
                
                
            }
            
        }
        
    }
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        //创建文字的控件
        label = UILabel.createLabel(nil, font: UIFont.systemFontOfSize(20), textAlignment: .Center, textColor: UIColor.grayColor())
        label?.frame = CGRectMake(0, 0, bounds.size.width, bounds.size.height-10)
        addSubview(label!)
        
        
        
    }
    //显示文字
    func configTitle(title: String){
        label?.text = title
    }
    
    
    
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
}




