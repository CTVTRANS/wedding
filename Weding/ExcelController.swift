//
//  ExcelController.swift
//  Weding
//
//  Created by kien le van on 8/16/17.
//  Copyright © 2017 kien le van. All rights reserved.
//

import UIKit
import FileBrowser

class ExcelController: BaseViewController {

    @IBOutlet weak var manView: UIView!
    @IBOutlet weak var womwnView: UIView!
    @IBOutlet weak var nameFactory: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigation()
        nameFactory.text = Constants.sharedInstance.factory?.getName()
        manView.layer.borderColor = UIColor.rgb(red: 188, green: 123, blue: 7).cgColor
        womwnView.layer.borderColor = UIColor.rgb(red: 188, green: 123, blue: 7).cgColor
    }
    
    @IBAction func manDownloadExcel(_ sender: Any) {
        downloadMemberExcel(objectID: "1")
    }

    @IBAction func manUploadEcel(_ sender: Any) {
        let filePath = Constants.sharedInstance.man?.filePath
        uploadExcel(url: filePath!, object: "MemberAddGuestPlanDoc", nameFile: "GUESTPLAN-ann730204.xlsx")
    }
    
    @IBAction func womanDownloadExcel(_ sender: Any) {
        downloadMemberExcel(objectID: "2")
    }
    
    @IBAction func wonmanUploadExcel(_ sender: Any) {
        let filePath = Constants.sharedInstance.woman?.filePath
        uploadExcel(url:  filePath!, object: "MemberAddGuestPlanDoc2", nameFile: "GUESTPLAN2-ann730204.xlsx")
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
}
