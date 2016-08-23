//
//  CookBookViewController.swift
//  TestKitchen
//
//  Created by qianfeng on 16/8/15.
//  Copyright © 2016年 ray. All rights reserved.
//

import UIKit

class CookBookViewController: BaseViewController {
    
    //食材首页的推荐视图
    private var recommendView: CBRecommendView?
    
    //首页的食材视图
    private var foodView: CBMaterialView?
    //首页的分类视图
    private var categoryView: CBMaterialView?
    
    
    //导航的标题视图
    private var segCtrl: KTCSegmentCtrl?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        
        
        //创建导航
        createMyNav()
        
        //初始化视图
        createHomePageView()
        
        //下载推荐的数据
        downloadRecommendData()
        //下载食材的数据
        downloadFoodData()
        
    }
    //下载食材的数据
    
    func downloadFoodData(){
        //methodName=MaterialSubtype&token=&user_id=&version=4.5
        let dict = ["methodName":"MaterialSubtype"]
        let downloader = KTCDownloader()
        downloader.delegate = self
        downloader.type = .FoodMaterial
        
        downloader.postWithUrl(kHostUrl, params: dict)
        
        
        
    }
    
    
    
    
    
    //初始化视图
    func createHomePageView(){
        
        self.automaticallyAdjustsScrollViewInsets = false
        
        //1.创建滚动视图
        let scrollView = UIScrollView()
        scrollView.pagingEnabled = true
        scrollView.showsHorizontalScrollIndicator = false
        
        view.addSubview(scrollView)
        //约束
        scrollView.snp_makeConstraints {
            [weak self]
            (make) in
            make.edges.equalTo(self!.view).inset(UIEdgeInsetsMake(64, 0, 49, 0))
            
            //添加约束的闭包内使用到 self 的时候才使用: [weak self]
        }
        //2.创建容器视图
        let containerView = UIView.createView()
        scrollView.addSubview(containerView)
        containerView.snp_makeConstraints {
            (make) in
            make.edges.equalTo(scrollView)
            make.height.equalTo(scrollView)
        }
        
        
        //3.添加子视图
        //3.1.推荐
        recommendView = CBRecommendView()
        containerView.addSubview(recommendView!)
        
        //约束
        recommendView?.snp_makeConstraints(closure: {
            (make) in
            
            make.top.bottom.equalTo(containerView)
            make.width.equalTo(kScreenWidth)
            make.left.equalTo(containerView)
            
        })
        
        
        //3.2.食材
        foodView = CBMaterialView()
        foodView?.backgroundColor = UIColor.redColor()
        containerView.addSubview(foodView!)
        
        foodView?.snp_makeConstraints(closure: { (make) in
            make.top.bottom.equalTo(containerView)
            make.width.equalTo(kScreenWidth)
            make.left.equalTo((recommendView?.snp_right)!)
        })
        
        
        //3.3.分类
        categoryView = CBMaterialView()
        categoryView?.backgroundColor = UIColor.yellowColor()
        containerView.addSubview(categoryView!)
        categoryView?.snp_makeConstraints(closure: { (make) in
            make.top.bottom.equalTo(containerView)
            make.width.equalTo(kScreenWidth)
            make.left.equalTo((foodView?.snp_right)!)
        })
        
        //4.修改容器视图的大小
        containerView.snp_makeConstraints { (make) in
            
            make.right.equalTo(categoryView!)
            
        }
        
        
        
        
    }
    
    
    //下载推荐的数据
    func downloadRecommendData(){
        //首页推荐参数
        //methodName=SceneHome&token=&user_id=&version=4.5
        //参数:
        let dict = ["methodName":"SceneHome"]
        let downloader = KTCDownloader()
        
        downloader.type = .Recommend
        downloader.delegate = self
        downloader.postWithUrl(kHostUrl, params: dict)
        
    }
    
    //创建导航
    func createMyNav(){
        
        //标题位置
        let segCtrl = KTCSegmentCtrl(frame: CGRectMake(80, 0, kScreenWidth-80*2, 44), titleNames: ["推荐","食材","分类"])
        navigationItem.titleView = segCtrl
        
        //扫一扫
        addNavBtn("saoyisao", target: self, action: #selector(scanAction), isLeft: true)
        
        addNavBtn("search", target: self, action: #selector(searchAction), isLeft: false)
        
    }
    //扫一扫
    func scanAction(){
        
    }
    //搜索
    func searchAction(){
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}



//MARK: KTCDownloader代理
extension CookBookViewController:KTCDownloaderDelegate{
    
    func downloader(downloader: KTCDownloader, didFailWithError error: NSError) {
        
        print(error)
        
    }
    func downloader(downloader: KTCDownloader, didFinishWithData data: NSData?) {
        
        if downloader.type == .Recommend{
            //推荐
            
            if let jsonData = data{
                let model = CBRecommendModel.parseModel(jsonData)
                //显示数据
                dispatch_async(dispatch_get_main_queue(), {
                    [weak self] in
                    
                    self!.recommendView?.model = model
                    
                    
                    })
                
            }
            
            
        }else if downloader.type == .FoodMaterial{
            //食材
//            let str = NSString(data: data!, encoding: NSUTF8StringEncoding)
//            print(str)
            if let jsonData = data{
                
                let model = CBMaterialModel.parseModelWithData(jsonData)
                
                
                
            }
            
            
            
        }else if downloader.type == .Category{
            //分类
            
            
        }
        

        
        
        
        
        
    }
    
    
}



