//
//  CBRecommendADCell.swift
//  TestKitchen
//
//  Created by qianfeng on 16/8/17.
//  Copyright © 2016年 ray. All rights reserved.
//

import UIKit

class CBRecommendADCell: UITableViewCell {
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    
    @IBOutlet weak var pageControl: UIPageControl!
    
    
    var bannerArray: Array<CBRecommendBannerModel>?{
        
        didSet{
            
            showData()
            
        }
        
    }
    
    func showData(){
        
        let cnt = bannerArray?.count
        if cnt > 0{
            //0.添加一个容器视图
            let containerView = UIView.createView()
            scrollView.addSubview(containerView)
            containerView.snp_makeConstraints(closure: {
                [weak self]
                (make) in
                
                make.edges.equalTo(self!.scrollView)
                //高度一定要设置
                make.height.equalTo(self!.scrollView)
            })
            
            var lastView: UIView? = nil
            
            
            for i in 0..<cnt!{
                //1.获取模型对象
                let model = bannerArray![i]
                //2.创建图片
                let tmpImageView = UIImageView.createImageView(nil)
                //在线加载图片
                
                /*
                 1.图片网站URL
                 2.默认显示的图片
                 3.选项
                 4.可以获取下载的进度
                 5.下载结束的时候的操作
                 */
                let url = NSURL(string: model.banner_picture!)
                let image = UIImage(named: "sdefaultImage")
                tmpImageView.kf_setImageWithURL(url, placeholderImage: image, optionsInfo: nil, progressBlock: nil, completionHandler: nil)
                containerView.addSubview(tmpImageView)
                
                //约束
                
                if i == 0{
                    
                    
                }else{
                    
                    
                }
                
                tmpImageView.snp_makeConstraints(closure: { (make) in
                    
                    make.top.bottom.equalTo(containerView)
                    make.width.equalTo(kScreenWidth)
                    if i == 0{
                        make.left.equalTo(containerView)
                    }else{
                        make.left.equalTo((lastView?.snp_right)!)
                    }
                    
                })
                
                lastView = tmpImageView
                
                
            }
            
            //修改容器视图的约束
            containerView.snp_makeConstraints(closure: { (make) in
                make.right.equalTo((lastView?.snp_right)!)
                
            })
            
            //修改分页空间
            pageControl.numberOfPages = cnt!
            
            scrollView.pagingEnabled = true
            
            //设置代理
            scrollView.delegate = self
            
        }
        
        
        
        
    }
    
    //创建cell的方法
    class func createAdCellFor(tableView: UITableView, atIndexPath indexPath: NSIndexPath, withModel model: CBRecommendModel)->CBRecommendADCell{
        
        let cellId = "recommendADCellId"
        var cell = tableView.dequeueReusableCellWithIdentifier(cellId) as? CBRecommendADCell
        if cell == nil{
            cell = NSBundle.mainBundle().loadNibNamed("CBRecommendADCell", owner: nil, options: nil).last as? CBRecommendADCell
        }
        
        
        cell?.bannerArray = model.data?.banner
        
        
        
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

//MARK: UIScrollView
extension CBRecommendADCell: UIScrollViewDelegate{
    
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        let index = Int(scrollView.contentOffset.x/scrollView.bounds.size.width)
        
        pageControl.currentPage = index
        
    }
    
    
    
    
    
}








