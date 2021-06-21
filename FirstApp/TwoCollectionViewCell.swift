//
//  TwoCollectionViewCell.swift
//  FirstApp
//
//  Created by 星裕一郎 on 2020/09/06.
//  Copyright © 2020 yuichiro. All rights reserved.
//

import UIKit


class TwoCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet var whoLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
     required init?(coder aDecoder: NSCoder) {
           super.init(coder: aDecoder)

           // cellの枠の太さ
           self.layer.borderWidth = 1.0
           // cellの枠の色
           self.layer.borderColor = UIColor.white.cgColor
           // cellを丸くする
           self.layer.cornerRadius = 8.0
       }
    

}
