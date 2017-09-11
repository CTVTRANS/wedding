//
//  UploadURL.swift
//  Weding
//
//  Created by kien le van on 9/11/17.
//  Copyright © 2017 kien le van. All rights reserved.
//

import UIKit

class UploadURL: NSObject {
    private var _manFileUpload: String!
    private var _womanFileUpload: String!

    init(man: String, woman: String) {
        _manFileUpload = man
        _womanFileUpload = woman
    }
    
    required init(coder decoder: NSCoder) {
        _manFileUpload = decoder.decodeObject(forKey: "manFileUpload") as! String
        _womanFileUpload = decoder.decodeObject(forKey: "womanFileUpload") as! String
    }
    
    func encode(with coder: NSCoder) {
        coder.encode(_manFileUpload, forKey: "manFileUpload")
        coder.encode(_womanFileUpload, forKey: "womanFileUpload")
    }
    
    class func saveURL(myURL: UploadURL) {
        let encodedURL = NSKeyedArchiver.archivedData(withRootObject: myURL)
        UserDefaults.standard.set(encodedURL, forKey: "myURL")
    }
    
    class func getURL() -> UploadURL {
        if let url = UserDefaults.standard.data(forKey: "myURL"),
            let myURL = NSKeyedUnarchiver.unarchiveObject(with: url) as? UploadURL {
            return myURL
        } else {
            let myURL: UploadURL? = nil
            return myURL!
        }
    }
    var man: String {
        get {
            return _manFileUpload
        }
        set {
            _manFileUpload = newValue
        }
    }
    var woman: String {
        get {
            return _womanFileUpload
        }
        set {
            _womanFileUpload = newValue
        }
    }
}
