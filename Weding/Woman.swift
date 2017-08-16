//
//  BrideModel.swift
//  Weding
//
//  Created by kien le van on 8/6/17.
//  Copyright © 2017 kien le van. All rights reserved.
//

import UIKit

class Woman: NSObject {
    private var _name: String! = ""
    private var _weddingDay: String! = "12"
    private var _weddingDayCounter: String! = "3"
    private var _numberGuest: Int! = 2
    private var _linkDownloadExcel: String!
    private var _filepathURL: String?
    
    init(name: String, day: String, dayCounter: String, numberGuest: Int, linkdownloadExcel: String) {
        self._name = name
        self._weddingDay = day
        let dayCounterArray = dayCounter.components(separatedBy: " ")
        self._weddingDayCounter = dayCounterArray[1]
        self._numberGuest = numberGuest
        self._linkDownloadExcel = linkdownloadExcel
//        let dayOfWeddingArray = date.components(separatedBy: " ")
//        let dateOfWedding: String! = dayOfWeddingArray[1]
//        let index = dateOfWedding.index(dateOfWedding.startIndex, offsetBy: 1)
//        self._dateOfWedding = dateOfWedding.substring(from: index)
        
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
    var filePath: String {
        get {
            return _filepathURL!
        }
        set {
            _filepathURL = newValue
        }
    }
}
