//
//  Factory.swift
//  Weding
//
//  Created by Le Cong on 8/8/17.
//  Copyright © 2017 kien le van. All rights reserved.
//

import UIKit

class Factory: NSObject {
    
    var nameFactory: String! = ""
    
    init(name: String) {
        nameFactory = name
    }
    
    func getName() -> String {
        return nameFactory
    }

}
