//
//  GetLIstGuestTask.swift
//  Weding
//
//  Created by kien le van on 10/26/17.
//  Copyright © 2017 kien le van. All rights reserved.
//

import UIKit
import LCNetwork

class GetLIstGuestTask: BaseTaskNetwork {

    override func path() -> String! {
        return getListGuestURL + "id=" + Account.getAccount().name + "&k=" + Account.getAccount().keyAccess
    }
    
    override func method() -> String! {
        return GET
    }
    
    override func data(withResponse response: Any!) -> Any! {
        var listGuest: [Guest] = []
        if let arrayGuest = response as? [[String: Any]] {
            for dictionary in arrayGuest {
                let guest = parseGuest(dictionary: dictionary)
                listGuest.append(guest)
            }
        }
        return listGuest
    }
}

extension BaseTaskNetwork {
    func parseGuest(dictionary: [String: Any]) -> Guest {
        let nameGuest = dictionary["USERNAME"] as? String ?? ""
        let idGuest = dictionary["id"] as? String ?? ""
        let mobileGuest = dictionary["MOBILE"] as? String ?? ""
        let emailGuest = dictionary["EMAIL"] as? String ?? ""
        let avaterGuest = dictionary["AVATAR"] as? String ?? ""
        let guest = Guest(idGuest: idGuest, nameGuset: nameGuest, avatar: avaterGuest, phone: mobileGuest, email: emailGuest)
        return guest
    }
}
