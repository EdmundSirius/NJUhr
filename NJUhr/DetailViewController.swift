//
//  DetailViewController.swift
//  NJUhr
//
//  Created by 郑天烨 on 2019/12/24.
//  Copyright © 2019 437.Inc. All rights reserved.
//

import Foundation
import UIKit
import WebKit

class DetailViewController:UIViewController{
    var webSite:String?
    @IBOutlet weak var webView: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let address = webSite,
            let webURL = URL(string: address) {
            let urlRequest = URLRequest(url: webURL)
            webView.load(urlRequest)
        }
    }
    
}
