//
//  BaseExtendtion.swift
//  Weding
//
//  Created by Le Cong on 8/10/17.
//  Copyright © 2017 kien le van. All rights reserved.
//

import UIKit

class BaseViewcontrollerExtend: NSObject {

}

extension BaseViewController {
    func downloadMemberExcel() {
        let getMemberTask: DowloadMemberList = DowloadMemberList()
        downloadFileSuccess(task: getMemberTask, success: { (data) in
            let activityVC: UIActivityViewController = UIActivityViewController.init(activityItems: [data!], applicationActivities: nil)
            self.present(activityVC, animated: true, completion: nil)
        }) { (error) in
            
        }
    }
    
    func shareApp() {
        let textToShare = "Swift is awesome!  Check out this website about it!"
        if let myWebsite = NSURL(string: linkDownloadApp) {
            let objectsToShare = [textToShare, myWebsite] as [Any]
            let activityVC = UIActivityViewController(activityItems: objectsToShare, applicationActivities: nil)
            self.present(activityVC, animated: true, completion: nil)
        }
        
    }
    
    func sendImageOfPosition() {
        let alert = UIAlertController(title: "Notification", message: "Send images of seat postition succses", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}
