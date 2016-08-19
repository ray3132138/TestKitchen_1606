//
//  MainTabBarController.swift
//  TestKitchen
//
//  Created by qianfeng on 16/8/15.
//  Copyright © 2016年 ray. All rights reserved.
//

import UIKit


class MainTabBarController: UITabBarController {
    
    //tabbar的背景视图
    private var bgView: UIView?
    
    
    
    //json文件对应的数组
    //计算属性
    private var array: Array<Dictionary<String,String>>?{
        
        get{
            //读文件
            let path = NSBundle.mainBundle().pathForResource("Ctrl.json", ofType: nil)
            
            var myArray: Array<Dictionary<String,String>>? = nil
            if let filePath = path{
                
                let data = NSData(contentsOfFile: filePath)
                if let jsonData = data{
                    
                    do{
                        
                        let jsonValue = try NSJSONSerialization.JSONObjectWithData(jsonData, options: .MutableContainers)
                        if jsonValue.isKindOfClass(NSArray.self){
                            myArray = jsonValue as? Array<Dictionary<String,String>>
                        }
                        
                        
                        
                    }
                    catch{
                        //程序出现异常
                        print(error)
                        return nil
                    }
                    
                
                
                }
                
                
                
                
            }
            
            return myArray
            
            
        }
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        //Swift里面一般
        //创建视图控制器
        createViewControllers()
        
        
    }
    
    //创建视图控制器
    func createViewControllers(){
        
//        let ctrNames = ["CookBookViewController","CommunityViewController","MallViewController","FoodClassViewController","ProfileViewController"]
        
        var ctrNames = [String]()
        var imageNames = [String]()
        var titleNames = [String]()
        
        
        if let tmpArray = self.array{
            //json文件的数据解析成功
            //并且数组里面有数据
            for dict in tmpArray {
                let name = dict["ctrlName"]                
                let titleName = dict["titleName"]
                let imageName = dict["imageName"]
                
                ctrNames.append(name!)
                titleNames.append(titleName!)
                imageNames.append(imageName!)
                
            }
        }else{
        
            ctrNames = ["CookBookViewController","CommunityViewController","MallViewController","FoodClassViewController","ProfileViewController"]
            //home_normal  home_select
            //community_normal  community_select
            //shop_normal   shop_select
            //shike_normal  shike_select
            //mine_normal   mine_select
            
            titleNames = ["食材","社区","商城","食课","我的"]
            imageNames = ["home","community","shop","shike","mine"]
            
            
            
        }
        
        
        
        
        
        
        
        var vCtrlArray = Array<UINavigationController>()
        for i in 0..<ctrNames.count{
            //创建视图控制器
            let ctrName = "TestKitchen." + ctrNames[i]
            
            let cls = NSClassFromString(ctrName) as! UIViewController.Type
            
            let ctrl = cls.init()
            
            let navCtrl = UINavigationController(rootViewController: ctrl)
            
            vCtrlArray.append(navCtrl)
            
            
        }
        viewControllers = vCtrlArray
        
        //自定制tabbar
        createCustomTabbar(titleNames, imageNames: imageNames)
        
        
    }
    
    //自定制tabbar
    func createCustomTabbar(titleNames: [String], imageNames: [String]){
        //1.创建背景视图
        bgView = UIView.createView()
        bgView?.backgroundColor = UIColor.whiteColor()
        //设置边框
        bgView?.layer.borderWidth = 1
        bgView?.layer.borderColor = UIColor.grayColor().CGColor
        
        view.addSubview(self.bgView!)
        //2添加约束
        bgView?.snp_makeConstraints(closure: {
            [weak self]
            (make) in
            
            make.left.right.equalTo(self!.view)
            make.bottom.equalTo(self!.view)
            make.top.equalTo(self!.view.snp_bottom).offset(-49)
            
        })
        
        //2.循环添加按钮
        
        //按钮的宽度
        let width = kScreenWidth / 5.0
        
        for i in 0..<imageNames.count{
            //图片
            let imageName = imageNames[i]
            let titleName = titleNames[i]
            //2.1按钮
            let bgImageName = imageName + "_normal"
            let selectBgImageName = imageName + "_select"
            let btn = UIButton.createBtn(nil, bgImageName: bgImageName, selectBgImageName: selectBgImageName, target: self, action: #selector(clickBtn(_:)))
            
            bgView?.addSubview(btn)
            //添加约束
            btn.snp_makeConstraints(closure: {
                [weak self]
                (make) in
                make.top.bottom.equalTo(self!.bgView!)
                make.width.equalTo(width)
                make.left.equalTo(width*CGFloat(i))
                
            })
            
            //2.2 文字
            let label = UILabel.createLabel(titleName, font: UIFont.systemFontOfSize(8), textAlignment: .Center, textColor: UIColor.grayColor())
            btn.addSubview(label)
            //添加约束
            
            label.snp_makeConstraints(closure: { (make) in
                
                make.left.right.equalTo(btn)
                make.top.equalTo(btn).offset(32)
                make.height.equalTo(12)
                
                
            })
            //设置tag值
            btn.tag = 300+i
            label.tag = 400
            
            //默认选中第一个按钮
            if i == 0{
                btn.selected = true
                label.textColor = UIColor.orangeColor()
            }
            
        }
        
        
        
    }
    
    func clickBtn(curBtn: UIButton){
        
        //1.取消之前选中按钮的状态
        let lastBtnView = bgView?.viewWithTag(300+selectedIndex)
        if let tmpBtn = lastBtnView {
            let lastBtn = tmpBtn as! UIButton
            let lastView = tmpBtn.viewWithTag(400)
            if let tmpLabel = lastView{
                //上次选中的标签
                let lastLabel = tmpLabel as! UILabel
                lastBtn.selected = false
                lastLabel.textColor = UIColor.grayColor()
            }
        }
        
        //2.设置当前选中按钮的状态
        
        let curLabelView = curBtn.viewWithTag(400)
        if let tmpLabel = curLabelView{
            let curLabel = tmpLabel as! UILabel
            curBtn.selected = true
            curLabel.textColor = UIColor.orangeColor()
        }
        
        //3.选中视图控制器
        selectedIndex = curBtn.tag - 300
        
        
        
        
        
        
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
