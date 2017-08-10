//
//  BrideModel.swift
//  Weding
//
//  Created by kien le van on 8/6/17.
//  Copyright © 2017 kien le van. All rights reserved.
//

import UIKit

class BrideModel: NSObject {
    private var nameBride: String! = ""
    private var weddingDay: String! = "12"
    private var weddingDayCounter: String! = "3"
    private var numberCustomerCount: Int! = 2
    private var dayOfWedding: String! = "123"
    init(name: String, day: String, dayCounter: String, numberCustomer: Int, date: String) {
        nameBride = name
        weddingDay = day
        let dayCounterArray = dayCounter.components(separatedBy: " ")
        weddingDayCounter = dayCounterArray[1]
        numberCustomerCount = numberCustomer
        
        let dayOfWeddingArray = date.components(separatedBy: " ")
        let dateOfWedding: String! = dayOfWeddingArray[1]
        let index = dateOfWedding.index(dateOfWedding.startIndex, offsetBy: 1)
        dayOfWedding = dateOfWedding.substring(from: index)  // playground
    }
    func getNameBride() -> String {
        return nameBride
    }
    func getWeddingDay() -> String {
        return weddingDay
    }
    func getCounterDay() -> String {
        return weddingDayCounter
    }

    func getNumberCustomer() -> Int {
        return numberCustomerCount
    }
    
    func getdayOfWedding() -> String {
        return dayOfWedding
    }
}
