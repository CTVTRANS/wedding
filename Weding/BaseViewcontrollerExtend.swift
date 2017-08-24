//
//  BaseExtendtion.swift
//  Weding
//
//  Created by Le Cong on 8/10/17.
//  Copyright © 2017 kien le van. All rights reserved.
//

import UIKit
import DeviceKit

class BaseViewcontrollerExtend: NSObject {

}

extension BaseViewController {
    
    func sendImageOfPosition() {
        let alert = UIAlertController(title: nil, message: "桌位圖發佈賓客成功", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}

extension UIAlertController {
    class func showAlertWith(title: String, message: String, myViewController: UIViewController) {
        let alertView = UIAlertController(title: title,
                                          message: message,
                                          preferredStyle: UIAlertControllerStyle.alert)
        let action = UIAlertAction(title: "OK",
                                   style: UIAlertActionStyle.default) { (UIAlertAction) in
            alertView.dismiss(animated: true, completion: nil)
        }
        alertView.addAction(action)
        myViewController.present(alertView, animated: true, completion: nil)
    }
}

extension UILabel {
    var adjustFontToRealIPhoneSize: Bool {
        set {
            if newValue {
                let currentFont = self.font
                var sizeScale: CGFloat = 1
                let device = Device()
                if (device == .simulator(.iPhone7)
                    || device == .simulator(.iPhone6)
                    || device == .iPhone6
                    || device == .iPhone7) {
                    sizeScale = 1.2
                } else if (device == .simulator(.iPhone6Plus)
                    || device == .simulator(.iPhone7Plus)
                    || device == .iPhone6Plus
                    || device == .iPhone7Plus
                    || device == .iPhone6s) {
                    sizeScale = 1.3
                }
                self.font = currentFont?.withSize((currentFont?.pointSize)! * sizeScale)
            }
        }
        get {
            return false
        }
    }
}

extension UITextField {
    var adjustFontToRealIPhoneSize: Bool {
        set {
            if newValue {
                let currentFont = self.font
                var sizeScale: CGFloat = 1
                let device = Device()
                if (device == .simulator(.iPhone7)
                    || device == .simulator(.iPhone6)
                    || device == .iPhone6
                    || device == .iPhone7) {
                    sizeScale = 1.2
                } else if (device == .simulator(.iPhone6Plus)
                    || device == .simulator(.iPhone7Plus)
                    || device == .iPhone6Plus
                    || device == .iPhone7Plus
                    || device == .iPhone6s) {
                    sizeScale = 1.3
                }
                self.font = currentFont?.withSize((currentFont?.pointSize)! * sizeScale)
            }
        }
        get {
            return false
        }
    }
}

extension NSLayoutConstraint {
    var adjustConstantToRealIPhoneSize: Bool {
        set {
            if newValue {
                let currentConstant = self.constant
                var sizeScale: CGFloat = 1
                let device = Device()
                if (device == .simulator(.iPhone7)
                    || device == .simulator(.iPhone6)
                    || device == .iPhone6
                    || device == .iPhone7) {
                    sizeScale = 1.2
                } else if (device == .simulator(.iPhone6Plus)
                        || device == .simulator(.iPhone7Plus)
                        || device == .iPhone6Plus
                        || device == .iPhone7Plus
                        || device == .iPhone6s) {
                    sizeScale = 1.3
                }
                self.constant = currentConstant * sizeScale
            }
        }
        get {
            return false
        }
    }

}

extension UIButton {
    var adjustFontToRealIPhoneSize: Bool {
        set {
            if newValue {
                let currentFont = self.titleLabel?.font
                var sizeScale: CGFloat = 1
//                let model = UIDevice.current.model
                let device = Device()
                if (device == .simulator(.iPhone7)
                    || device == .simulator(.iPhone6)
                    || device == .iPhone6
                    || device == .iPhone7) {
                    sizeScale = 1.2
                } else if (device == .simulator(.iPhone6Plus)
                    || device == .simulator(.iPhone7Plus)
                    || device == .iPhone6Plus
                    || device == .iPhone7Plus
                    || device == .iPhone6s) {
                    sizeScale = 1.3
                }
//                if model == "iPhone 6" {
//                    sizeScale = 1.3
//                }
//                else if model == "iPhone 6 Plus" {
//                    sizeScale = 1.5
//                }
                self.titleLabel?.font = currentFont?.withSize((currentFont?.pointSize)! * sizeScale)
            }
        }
        
        get {
            return false
        }
    }
}

extension UIColor {
    class func rgb(r: Float, g: Float, b: Float) -> UIColor {
        return UIColor(colorLiteralRed: r/255.0, green: g/255.0, blue: b/255.0, alpha: 1.0)
    }
}



/*
extension UIDevice {
    
    var modelName: String {
        var systemInfo = utsname()
        uname(&systemInfo)
        let machineMirror = Mirror(reflecting: systemInfo.machine)
        let identifier = machineMirror.children.reduce("") { identifier, element in
            guard let value = element.value as? Int8, value != 0 else { return identifier }
            return identifier + String(UnicodeScalar(UInt8(value)))
        }
        
        switch identifier {
        case "iPod5,1":                                 return "iPod Touch 5"
        case "iPod7,1":                                 return "iPod Touch 6"
        case "iPhone3,1", "iPhone3,2", "iPhone3,3":     return "iPhone 4"
        case "iPhone4,1":                               return "iPhone 4s"
        case "iPhone5,1", "iPhone5,2":                  return "iPhone 5"
        case "iPhone5,3", "iPhone5,4":                  return "iPhone 5c"
        case "iPhone6,1", "iPhone6,2":                  return "iPhone 5s"
        case "iPhone7,2":                               return "iPhone 6"
        case "iPhone7,1":                               return "iPhone 6 Plus"
        case "iPhone8,1":                               return "iPhone 6s"
        case "iPhone8,2":                               return "iPhone 6s Plus"
        case "iPhone9,1", "iPhone9,3":                  return "iPhone 7"
        case "iPhone9,2", "iPhone9,4":                  return "iPhone 7 Plus"
        case "iPhone8,4":                               return "iPhone SE"
        case "iPad2,1", "iPad2,2", "iPad2,3", "iPad2,4":return "iPad 2"
        case "iPad3,1", "iPad3,2", "iPad3,3":           return "iPad 3"
        case "iPad3,4", "iPad3,5", "iPad3,6":           return "iPad 4"
        case "iPad4,1", "iPad4,2", "iPad4,3":           return "iPad Air"
        case "iPad5,3", "iPad5,4":                      return "iPad Air 2"
        case "iPad6,11", "iPad6,12":                    return "iPad 5"
        case "iPad2,5", "iPad2,6", "iPad2,7":           return "iPad Mini"
        case "iPad4,4", "iPad4,5", "iPad4,6":           return "iPad Mini 2"
        case "iPad4,7", "iPad4,8", "iPad4,9":           return "iPad Mini 3"
        case "iPad5,1", "iPad5,2":                      return "iPad Mini 4"
        case "iPad6,3", "iPad6,4":                      return "iPad Pro 9.7 Inch"
        case "iPad6,7", "iPad6,8":                      return "iPad Pro 12.9 Inch"
        case "iPad7,1", "iPad7,2":                      return "iPad Pro 12.9 Inch 2. Generation"
        case "iPad7,3", "iPad7,4":                      return "iPad Pro 10.5 Inch"
        case "AppleTV5,3":                              return "Apple TV"
        case "i386", "x86_64":                          return "Simulator"
        default:                                        return identifier
        }
    }
}
 */
