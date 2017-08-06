//
//  Constants.swift
//  Weding
//
//  Created by kien le van on 8/6/17.
//  Copyright © 2017 kien le van. All rights reserved.
//

import UIKit

class Constants: NSObject {
    
    var checkClickLeftBarButtonMainSreen: Bool! = false

    class func shaareIntance() -> Constants {
        var instance:Constants? = nil
        if (instance == nil) {
            instance = Constants.init()
        }
        return instance!
    }
}
