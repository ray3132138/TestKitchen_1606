//
//  CBRecommendModel.swift
//  TestKitchen
//
//  Created by qianfeng on 16/8/16.
//  Copyright © 2016年 ray. All rights reserved.
//

import UIKit

class CBRecommendModel: NSObject {
    
    var code: NSNumber?
    var msg: Bool?
    var version: String?
    var timestamp: NSNumber?
    var data: CBRecommendDataModel?
    
    
    /*"code": 0,
     "msg": true,
     "version": null,
     "timestamp": 1471318802136,
     "data"*/
}

class CBRecommendDataModel: NSObject {
    var banner: Array<CBRecommendBannerModel>?
    var widgetList: Array<CBRecommendWidgetListModel>?
}

class CBRecommendBannerModel: NSObject {
    
    var banner_id: NSNumber?
    var banner_title: String?
    var banner_picture: String?
    
    var banner_link: String?
    var is_link: NSNumber?
    var refer_key: NSNumber?
    
    var type_id: NSNumber?
    
    
    
}

class CBRecommendWidgetListModel: NSObject {
    
    var widget_id: NSNumber?
    var widget_type: NSNumber?
    var title: String?
    
    var title_link: String?
    var desc: String?
    var widget_data: Array<CBRecommendWidgetDataModel>?
    
    
}

class CBRecommendWidgetDataModel: NSObject {
    
    var id: NSNumber?
    var type: String?
    var content: String?
    var link: String?
    /*
     id": 1,
     "type": "image",
     "content": "http:\/\/img.szzhangchu.com\/1456222953065_6855615159.png",
     "link": "http:\/\/h5.izhangchu.com\/Tour.html?app_hideheader=1"
     */
}






