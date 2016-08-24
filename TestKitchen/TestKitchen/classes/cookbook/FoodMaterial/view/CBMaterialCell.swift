//
//  CBMaterialCell.swift
//  TestKitchen
//
//  Created by qianfeng on 16/8/24.
//  Copyright © 2016年 ray. All rights reserved.
//

import UIKit

class CBMaterialCell: UITableViewCell {
    
    var model: CBMaterialTypeModel?{
        didSet{
            if model != nil{
                showData()
            }
            
        }
        
    }
    
    func showData(){
        
        //1.删除之前的子视图
        for oldSub in contentView.subviews{
            oldSub.removeFromSuperview()
        }
        //2.添加子视图
        //2.1 标题
        
        let titleLabel = UILabel.createLabel(model!.text!, font: UIFont.systemFontOfSize(20), textAlignment: .Left, textColor: UIColor.blackColor())
        titleLabel.frame = CGRectMake(20, 0, kScreenWidth-20*2, 40)
        contentView.addSubview(titleLabel)
        
        //横线间距
        let spaceX: CGFloat = 10
        //纵向间距
        let spaceY: CGFloat = 10
        //多少列
        let colNum = 5
        //按钮高度
        let h: CGFloat = 40
        //按钮宽度
        let w = (kScreenWidth-spaceX*CGFloat(colNum+1)) / CGFloat(colNum)
        //y的偏移量
        let offsetY: CGFloat = 40
        
        //2.2 图片
        let imageFrame = CGRectMake(spaceX, offsetY, w*2+spaceX, h*2+spaceY)
        let imageView = UIImageView.createImageView(nil)
        imageView.frame = imageFrame
        
        let url = NSURL(string: (model?.image!)!)
        imageView.kf_setImageWithURL(url, placeholderImage: UIImage(named: "sdefaultImage"), optionsInfo: nil, progressBlock: nil, completionHandler: nil)
        contentView.addSubview(imageView)
        
        //2.3 循环创建按钮
        
        if model?.data?.count > 0{
            for i in 0..<(model?.data?.count)! {
                var btnFrame = CGRectZero
                if i < 6{
                    //前两行的按钮
                    
                    //行和列
                    let row = i / 3
                    let col = i % 3
                    btnFrame = CGRectMake(w*2+spaceX*3+(spaceX+w)*CGFloat(col), offsetY+(spaceY+h)*CGFloat(row), w, h)
                    
                    
                }else{
                    //后面几行的按钮
                    
                    let row = (i-6) / 5
                    let col = (i-6) % 5
                    btnFrame = CGRectMake(spaceX+(spaceX+w)*CGFloat(col), offsetY+h*2+spaceY*2+(spaceY+h)*CGFloat(row), w, h)
                    
                }
                
                //按钮
                
                let btn = CBMaterialBtn(frame: btnFrame)
                btn.model = model?.data![i]
                
                contentView.addSubview(btn)
                
                
            }
            
        }
        
        
        
        
        
        
    }
    
    class func heightWithModel(model: CBMaterialTypeModel)-> CGFloat{
        
        var h: CGFloat = 0
        
        //标题高度
        let offsetY: CGFloat = 40
        //纵向间距
        let spaceY: CGFloat = 10
        //按钮的高度
        let btnH: CGFloat = 40
        
        if model.data?.count > 0{
            if model.data?.count < 6{
                
                h = offsetY + (btnH+spaceY)*2
                
            }else{
                //计算有多少行
                h = offsetY + (btnH+spaceY)*2
                
                var rowNum = ((model.data?.count)! - 6) / 5
                
                //除不尽的时候另外加一行..
                if ((model.data?.count)! - 6)%5 > 0{
                    rowNum += 1
                }
                
                h += CGFloat(rowNum)*(btnH+spaceY)
                
                
            }
        }
        
        
        return h
    }
    
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}


class CBMaterialBtn: UIControl{
    private var titleLabel: UILabel?
    
    //数据的显示
    var model: CBMaterialSubtypeModel?{
        didSet{
            
            titleLabel?.text = model?.text
            
        }
        
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = UIColor(white: 0.8, alpha: 1.0)
        
        titleLabel = UILabel.createLabel(nil, font: UIFont.systemFontOfSize(17), textAlignment: .Center, textColor: UIColor.blackColor())
        titleLabel?.adjustsFontSizeToFitWidth = true
        titleLabel?.frame = bounds
        addSubview(titleLabel!)
        
    }
    
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}









