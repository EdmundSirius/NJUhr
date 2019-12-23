//
//  CustomCell.swift
//  NJUhr
//
//  Created by apple on 2019/12/23.
//  Copyright © 2019 437.Inc. All rights reserved.
//

import Foundation
import UIKit

class CustomCell:UITableViewCell{
    
    @IBOutlet weak var isBreaking: UIImageView!
    @IBOutlet weak var newsTitle: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    var new:News? {
        didSet{
            if let new = new{
                newsTitle.text = new.title
                if new.isBreaking{
                    isBreaking.image = .checkmark
                }
                else{
                    isBreaking.image = .none
                }
            }
        }
    }
    
}
