//
//  GetFactoryTask.swift
//  Weding
//
//  Created by Le Cong on 8/8/17.
//  Copyright © 2017 kien le van. All rights reserved.
//

import UIKit
import LCNetwork

class GetFactoryTask: BaseTaskNetwork {
    
    override func path() -> String! {
        return "http://www.freewed.com.tw/api/GetFactoryInfo.aspx?id=sophia5353829&k=ce97e1dce2857e6dff98d61c0e49b23d5cabc2d6"
    }
    
    override func method() -> String! {
        return GET
    }
    
    override func data(withResponse response: Any!) -> Any! {
        if let dictionary = response as? [String: Any] {
            let name = dictionary["COMPANYNM"] as? String
            let factory: Factory = Factory(name: name!)
            Constants.shared.factory = factory
        }
        return nil
    }
}
