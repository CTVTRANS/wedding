//
//  ExcelController.swift
//  Weding
//
//  Created by kien le van on 8/16/17.
//  Copyright © 2017 kien le van. All rights reserved.
//

import UIKit

class ExcelController: BaseViewController {

    @IBOutlet weak var manView: UIView!
    @IBOutlet weak var womwnView: UIView!
    @IBOutlet weak var nameFactory: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigation()
        nameFactory.text = Constants.sharedInstance.factory?.getName()
        manView.layer.borderColor = UIColor.rgb(r: 188, g: 123, b: 7).cgColor
        womwnView.layer.borderColor = UIColor.rgb(r: 188, g: 123, b: 7).cgColor
    }
    
    @IBAction func manDownloadExcel(_ sender: Any) {
        let url = Constants.sharedInstance.man?.excelUrl
        downloadMemberExcel(byHuman: "man", url: url!)
    }

    @IBAction func manUploadEcel(_ sender: Any) {
        let filePtah = Constants.sharedInstance.man?.filePath
        uploadExcel(url: filePtah!)
    }
    @IBAction func womanDownloadExcel(_ sender: Any) {
        let url = Constants.sharedInstance.woman?.excelUrl
        downloadMemberExcel(byHuman: "woman", url: url!)
    }
    @IBAction func wonmanUploadExcel(_ sender: Any) {
        let filePtah = Constants.sharedInstance.woman?.filePath
        uploadExcel(url: filePtah!)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
}
