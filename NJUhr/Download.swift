//
//  Download.swift
//  NJUhr
//
//  Created by apple on 2019/12/23.
//  Copyright © 2019 437.Inc. All rights reserved.
//

import Foundation


class Download{
    var data:URLSessionTask?
    let basePath = "https://hr.nju.edu.cn"
    //let basePath = "https://www.baidu.com"
    
    func getResults(path:String) -> [Int:[News]]{
        var new:[Int:[News]] = [0:[],
                                1:[],
                                2:[],
                                3:[]]
        if let url = URL(string: path){
            do{
                let str = try String(contentsOf: url, encoding: String.Encoding.utf8)
                //let nstr = NSString(string: str)
                /*let slices1 = str.slices(from: "人事通知", to: "</ui>")
                let slices2 = str.slices(from: "人事新闻", to: "</ui>")
                let slices3 = str.slices(from: "公示公告", to: "</ui>")
                let slices4 = str.slices(from: "招聘信息", to: "</ui>")
                slices1.forEach({print($0)})
                slices2.forEach({print($0)})
                slices3.forEach({print($0)})
                slices4.forEach({print($0)})*/
                let slices = str.slices(from: "<li class=\"news ", to: "</li>")
                var cnt = 1
                var k = 0
                for slice in slices{
                    var ind:String
                    if slice.first == "i"{
                        ind = String(slice[slice.index(slice.startIndex,offsetBy: 1)])
                    }
                    else{
                        ind = String((slice[slice.startIndex]))
                    }
                    if cnt > Int(ind)!{
                        k += 1
                        cnt = 1
                    }
                    let title = slice.slices(from: "title='", to: "'>").first!
                    let time = slice.slices(from: "meta\">", to: "</span").first
                    let num = slice.slices(from: "class=\"news_meta1\">", to: "</span>").first
                    let path = slice.slices(from: "<a href='", to: "' target='_blank'").first
                    let num1 = num?.suffix(num!.count - 1)
                    let num2 = num1?.prefix(num1!.count - 1)
                    let number = Int(String(num2!))!
                    let n = News(title: title, time: time!, num: number, path: path!)
                    new[k]?.append(n!)
                    cnt += 1
                }
                //let res = try NSDictionary(contentsOf: url,error: ())
                //print(str)
            }catch{
                print("cannot load")
            }
        }
        else{
            print("bad URL")
        }
        return new
        /*let url = URL(string: path)!
        let session:URLSession = URLSession.shared
        let request:URLRequest = URLRequest(url:url)
        let dataTask:URLSessionTask = session.dataTask(with: request){
            (data,response,error) in
            do{
                let res:[String:Any] = try JSONSerialization.jsonObject(with: data!, options: .allowFragments) as! [String:Any]
                print(res)
            }catch{
                print(error)
            }
        }
        dataTask.resume()*/
        /*let session = URLSession(configuration: .default)
        let url = URL(string: path)
        let urlRequest = URLRequest(url: url!)
        let task = session.dataTask(with: urlRequest){
            (data,response,error) in
            guard error == nil
                else{
                    print("error")
                    return
            }
            guard let data = data
                else{
                    print("empty data")
                    return
            }
            let responseString = NSString(data: data, encoding: String.Encoding.utf8.rawValue)! as String
            completion(responseString)
        }
        task.resume()*/
    }
}

extension String{
    func ranges(of string:String,options:CompareOptions = .literal) -> [Range<Index>]{
        var res:[Range<Index>] = []
        var start = startIndex
        while let range = range(of:string,options: options,range: start..<endIndex){
            res.append(range)
            start = range.lowerBound < range.upperBound ? range.upperBound : index(range.lowerBound,offsetBy: 1,limitedBy: endIndex) ?? endIndex
        }
        return res
    }
    func slices(from: String, to: String) -> [String]{
        let pattern = "(?<=" + from + ").*?(?=" + to + ")"
        return ranges(of:pattern,options: .regularExpression).map{
            String(self[$0])}
    }
}
