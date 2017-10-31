//
//  Guest.swift
//  Weding
//
//  Created by kien le van on 8/24/17.
//  Copyright © 2017 kien le van. All rights reserved.
//

import UIKit

struct Guest {
    
    var idGuest: String!
    var nameGuest: String!
    var avatar: String!
    var phone: String!
    var email: String!
    
    init(idGuest: String, nameGuset: String, avatar: String, phone: String, email: String) {
        self.idGuest = idGuest
        self.nameGuest = nameGuset
        self.avatar = avatar
        self.phone = phone
        self.email = email
    }
}
