//
//  MainTabBarController.swift
//  TestKitchen
//
//  Created by qianfeng on 16/8/15.
//  Copyright © 2016年 ray. All rights reserved.
//

import UIKit


class MainTabBarController: UITabBarController {
    
    
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
        if let tmpArray = self.array{
            //json文件的数据解析成功
            //并且数组里面有数据
            for dict in tmpArray {
                let name = dict["ctrlName"]
                ctrNames.append(name!)
            }
        }else{
            
            ctrNames = ["CookBookViewController","CommunityViewController","MallViewController","FoodClassViewController","ProfileViewController"]
            
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
        self.viewControllers = vCtrlArray
        
        
        
        
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
