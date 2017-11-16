//
//  ExcelController.swift
//  Weding
//
//  Created by kien le van on 8/16/17.
//  Copyright © 2017 kien le van. All rights reserved.
//

import UIKit

class ExcelController: BaseViewController {

    @IBOutlet weak var supportView: UIView!
    @IBOutlet weak var manView: UIView!
    @IBOutlet weak var womwnView: UIView!
    @IBOutlet weak var nameFactory: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigation()
        nameFactory.text = Constants.shared.factory?.getName()
        manView.layer.borderColor = UIColor.rgb(152, 102, 13).cgColor
        womwnView.layer.borderColor = UIColor.rgb(152, 102, 13).cgColor
        supportView.layer.borderColor = UIColor.rgb(152, 102, 13).cgColor
    }
    
    @IBAction func manDownloadExcel(_ sender: Any) {
        downloadMemberExcel(objectID: "1")
    }

    @IBAction func manUploadEcel(_ sender: Any) {
        let filePath = Constants.shared.man?.filePath
        uploadExcel(url: filePath!, object: "MemberAddGuestPlanDoc", nameFile: "GUESTPLAN-ann730204.xlsx")
    }
    
    @IBAction func womanDownloadExcel(_ sender: Any) {
        downloadMemberExcel(objectID: "2")
    }
    
    @IBAction func wonmanUploadExcel(_ sender: Any) {
        let filePath = Constants.shared.woman?.filePath
        uploadExcel(url: filePath!, object: "MemberAddGuestPlanDoc2", nameFile: "GUESTPLAN2-ann730204.xlsx")
    }
    
    @IBAction func pressedShowsupport(_ sender: Any) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "SupportExcelViewController") as? SupportExcelViewController {
            navigationController?.pushViewController(vc, animated: false)
        }
    }
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
}
