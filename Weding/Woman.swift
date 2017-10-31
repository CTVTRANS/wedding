//
//  BrideModel.swift
//  Weding
//
//  Created by kien le van on 8/6/17.
//  Copyright © 2017 kien le van. All rights reserved.
//

import UIKit

class Woman: NSObject {
    
    private var _memberURL: String!
    private var _name: String! = ""
    private var _weddingDay: String! = ""
    private var _weddingDayCounter: String! = ""
    private var _numberGuest: Int! = 0
    private var _linkDownloadExcel: String!
    private var _filepathURL: URL!
    private var _tableSeat: String!
    private var _webStep: String!
    
    init(name: String, day: String, dayCounter: String, numberGuest: Int, linkdownloadExcel: String, filePath: String) {
        self._name = name
        self._weddingDay = day
        let dayCounterArray = dayCounter.components(separatedBy: " ")
        self._weddingDayCounter = dayCounterArray[1]
        self._numberGuest = numberGuest
        self._linkDownloadExcel = linkdownloadExcel
        self._filepathURL = URL(fileURLWithPath: filePath)
    }
    var name: String {
        get {
            return _name
        }
        set {
            _name = newValue
        }
    }
    var weddingDay: String {
        get {
            return _weddingDay
        }
        set {
            _weddingDay = newValue
        }
    }
    var counterDay: String {
        get {
            return _weddingDayCounter
        }
        set {
            _weddingDayCounter = newValue
        }
    }
    var numberGuest: Int {
        get {
            return _numberGuest
        }
        set {
            _numberGuest = newValue
        }
    }
    var excelUrl: String {
        get {
            return _linkDownloadExcel!
        }
        set {
            _linkDownloadExcel = newValue
        }
    }
    var filePath: URL {
        get {
            return _filepathURL
        }
        set {
            _filepathURL = newValue
        }
    }
    var memberURL: String {
        get {
            return _memberURL
        }
        set {
            _memberURL = newValue
        }
    }
    var tableSeat: String {
        get {
            return _tableSeat
        }
        set {
            _tableSeat = newValue
        }
    }
    var webStep: String {
        get {
            return _webStep
        }
        set {
            _webStep = newValue
        }
    }
}
