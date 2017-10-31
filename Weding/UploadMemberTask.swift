//
//  UploadMemberTask.swift
//  Weding
//
//  Created by kien le van on 8/15/17.
//  Copyright © 2017 kien le van. All rights reserved.
//

import UIKit
import LCNetwork

class UploadMemberTask: BaseTaskNetwork {
    
    private var _todo: String!
    private var _name: String!
    private var _data: Data?
    
    init(data: Data, todo: String, name: String) {
        _data = data
        _todo = todo
        _name = name
    }
    
    override func fileUpload() -> Data! {
        return _data
    }
    
    override func parameterOfFile() -> String! {
        return "UploadFile"
    }
    
    override func nameFile() -> String! {
        return _name
    }
    
    override func path() -> String! {
        return  sendData + "id=" + Account.getAccount().name + "&k=" + Account.getAccount().keyAccess
    }
    
    override func parameters() -> [AnyHashable: Any]! {
        return ["todo": _todo]
    }
    
    override func method() -> String! {
        return POST
    }
    
    override func data(withResponse response: Any!) -> Any! {
        if let dictionary = response as? [String: Any] {
            let mesage: String = (dictionary["ErrMsg"] as? String)!
            return mesage
        }
        return "Fail"
    }
}
