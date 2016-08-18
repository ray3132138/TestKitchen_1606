//
//  CBRedPackertCell.swift
//  TestKitchen
//
//  Created by qianfeng on 16/8/18.
//  Copyright © 2016年 ray. All rights reserved.
//

import UIKit

class CBRedPackertCell: UITableViewCell {
    
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    
    //显示数据
    var model: CBRecommendWidgetListModel?{
        
        didSet{
            showData()
        }
        
        
    }
    
    //显示图片和文字
    func showData(){
        scrollView.pagingEnabled = true
        scrollView.showsHorizontalScrollIndicator = false
        //1.容器视图
        let container = UIView.createView()
        
        scrollView.addSubview(container)
        
        container.snp_makeConstraints {
            [weak self]
            (make) in
            make.edges.equalTo(self!.scrollView)
            make.height.equalTo(self!.scrollView.snp_height)
        }
        //2.循环添加图片
        let cnt = model?.widget_data?.count
        var lastView: UIView? = nil
        if cnt > 0{
            for i in 0..<cnt! {
                let imageModel = model?.widget_data![i]
                
                if imageModel?.type == "image"{
                    let imageView = UIImageView.createImageView(nil)
                    let url = NSURL(string: (imageModel?.content)!)
                    imageView.kf_setImageWithURL(url, placeholderImage: UIImage(named: "sdefaultImage"), optionsInfo: nil, progressBlock: nil, completionHandler: nil)
                    container.addSubview(imageView)
                    
                    imageView.tag = 400+i
                    imageView.userInteractionEnabled = true
                    //手势
                    let g = UITapGestureRecognizer(target: self, action: #selector(tapAction(_:)))
                    imageView.addGestureRecognizer(g)
                    
                    //约束
                    imageView.snp_makeConstraints(closure: { (make) in
                        make.top.bottom.equalTo(container)
                        make.width.equalTo(180)
                        if i == 0{
                            make.left.equalTo(0)
                            
                        }else{
                            make.left.equalTo((lastView?.snp_right)!)
                        }
                        
                    })
                    
                    lastView = imageView
                }
                
                
                
                
            }
            
            //修改容器的大小
            
            container.snp_makeConstraints(closure: { (make) in
                make.right.equalTo((lastView?.snp_right)!)
            })
            
            
            
        }
        
        
        
    }
    
    
    func tapAction(g:UITapGestureRecognizer){
        let index = (g.view?.tag)! - 400
        print(index)
        
        
    }
    
    //创建cell的方法
    class func createRedPackageCellFor(tableView: UITableView, atIndexPath indexPath: NSIndexPath, withListModel listModel: CBRecommendWidgetListModel)->CBRedPackertCell{
        
        let cellId = "redPackertCellId"
        var cell = tableView.dequeueReusableCellWithIdentifier(cellId) as? CBRedPackertCell
        if cell == nil {
            cell = NSBundle.mainBundle().loadNibNamed("CBRedPackertCell", owner: nil, options: nil).last as? CBRedPackertCell
        }
        cell?.model = listModel
        
        return cell!
        
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





















