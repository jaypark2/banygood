//
//  Save.swift
//  FirstApp
//
//  Created by 星裕一郎 on 2020/09/06.
//  Copyright © 2020 yuichiro. All rights reserved.
//

import UIKit

class Save {
    
    var objectId: String
    var who: String
    var what: String
    var createDate: Date
    
    init(objectId: String, who: String, what: String, createDate: Date) {
        self.objectId = objectId
        self.who = who
        self.what = what
        self.createDate = createDate
    }
     
}
