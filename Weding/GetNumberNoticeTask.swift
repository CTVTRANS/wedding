//
//  GetNumberNoticeTask.swift
//  Weding
//
//  Created by le kien on 12/26/17.
//  Copyright © 2017 kien le van. All rights reserved.
//

import UIKit
import LCNetwork

class GetNumberNoticeTask: BaseTaskNetwork {
    
    override func path() -> String! {
        return getNumberNotice + "id=\(Account.getAccount().name)&k=\(Account.getAccount().keyAccess)"
    }

    override func method() -> String! {
        return GET
    }
    
    override func data(withResponse response: Any!) -> Any! {
        if let dictionaty = response as? [String: Any] {
            let numberMesssage = dictionaty["count1"] as? Int ?? 0
            let numberGuest = dictionaty["count3"] as? Int ?? 0
            let numberSeat = dictionaty["count2"] as? Int ?? 0
            return (numberMesssage, numberGuest, numberSeat)
        }
        return nil
    }
}
