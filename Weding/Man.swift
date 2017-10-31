//
//  GroomModel.swift
//  Weding
//
//  Created by kien le van on 8/6/17.
//  Copyright © 2017 kien le van. All rights reserved.
//

import UIKit

class Man: NSObject {
    
    private var _name: String! = ""
    private var _weddingDay: String! = ""
    private var _weddingDayCounter: String! = ""
    private var _numberGuest: Int! = 2
    private var _linkDownloadExcel: String!
    private var _filepathURL: URL!
    
    init(name: String, day: String, dayCounter: String, numberCustomer: Int, linkDownloadExcel: String, filePath: String) {
        self._name = name
        self._weddingDay = day
        let dayCounterArray = dayCounter.components(separatedBy: " ")
        self._weddingDayCounter = dayCounterArray[1]
        self._numberGuest = numberCustomer
        self._linkDownloadExcel = linkDownloadExcel
        self._filepathURL = URL(string: filePath)
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
            return _linkDownloadExcel
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

}
