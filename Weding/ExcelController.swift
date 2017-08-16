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
        if self.revealViewController() != nil {
            navigationItem.leftBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "ic_leftButton"), style: .plain, target: self.revealViewController(), action: #selector(revealViewController().revealToggle(_:)))
            navigationItem.rightBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "ic_rightButton"), style: .plain, target: nil, action: nil)
            navigationItem.title = "婚禮籌備平台"
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
            self.view.addGestureRecognizer(self.revealViewController().tapGestureRecognizer())
        }
        nameFactory.text = Constants.sharedInstance.factory?.getName()
        manView.layer.borderColor = UIColor.rgb(r: 188, g: 123, b: 7).cgColor
        womwnView.layer.borderColor = UIColor.rgb(r: 188, g: 123, b: 7).cgColor
    }
    
    @IBAction func manDownloadExcel(_ sender: Any) {
        let url = Constants.sharedInstance.man?.excelUrl
        downloadMemberExcel(url: url!)
    }

    @IBAction func manUploadEcel(_ sender: Any) {
        let filePtah = Constants.sharedInstance.man?.filePath
        uploadExcel(url: filePtah!)
    }
    @IBAction func womanDownloadExcel(_ sender: Any) {
        let url = Constants.sharedInstance.woman?.excelUrl
        downloadMemberExcel(url: url!)
    }
    @IBAction func wonmanUploadExcel(_ sender: Any) {
        let filePtah = Constants.sharedInstance.man?.filePath
        uploadExcel(url: filePtah!)
    }
    
}
