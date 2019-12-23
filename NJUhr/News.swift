//
//  News.swift
//  NJUhr
//
//  Created by apple on 2019/12/23.
//  Copyright © 2019 437.Inc. All rights reserved.
//

import Foundation
import UIKit

class News{
    var title:String = ""
    var time:String = ""
    var isBreaking:Bool = false
    var path:String = ""
    init?(title:String,time:String,num:Int,path:String){
        self.title = title
        self.time = time
        if num > 1000{
            self.isBreaking = true
        }
        self.path = Download().basePath + path
    }
    
    static func getNews() -> [String:[News]]{
        var res:[String:[News]] = [:]
        let tmp = Download().getResults(path: Download().basePath)
        res.updateValue(tmp[0]!, forKey: "人事通知")
        res.updateValue(tmp[1]!, forKey: "人事新闻")
        res.updateValue(tmp[2]!, forKey: "公示公告")
        res.updateValue(tmp[3]!, forKey: "招聘信息")
        return res
    }
}
