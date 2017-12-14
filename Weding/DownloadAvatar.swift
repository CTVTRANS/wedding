//
//  DownloadAvatar.swift
//  Weding
//
//  Created by le kien on 12/14/17.
//  Copyright © 2017 kien le van. All rights reserved.
//

import UIKit
import LCNetwork

class DownloadAvatar: BaseTaskNetwork {
    let file: String!
    
    init(file: String) {
        self.file = file
    }
    override func path() -> String! {
        return file
    }
    
    override func method() -> String! {
        return GET
    }
    
    override func data(withResponse response: Any!) -> Any! {
        return response
    }
}
