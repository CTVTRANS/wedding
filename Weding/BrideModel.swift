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
    
    
    init(name: String, day: String, dayCounter: String) {
        nameBride = name
        weddingDay = day
        let dayCounterArray = dayCounter.components(separatedBy: " ")
        weddingDayCounter = dayCounterArray[1]
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


}
