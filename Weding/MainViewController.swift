//
//  SecondViewController.swift
//  Weding
//
//  Created by kien le van on 8/4/17.
//  Copyright © 2017 kien le van. All rights reserved.
//

import UIKit

class MainViewController: BaseViewController {
    
    @IBOutlet weak var manName: UILabel!
    @IBOutlet weak var womanName: UILabel!
    @IBOutlet weak var manCounterDay: UILabel!
    @IBOutlet weak var womanCounterDay: UILabel!
    @IBOutlet weak var manNumberClient: UILabel!
    @IBOutlet weak var womanNumberClient: UILabel!
    @IBOutlet weak var nameFactory: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if self.revealViewController() != nil {
            navigationItem.leftBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "ic_leftButton"), style: .plain, target: self.revealViewController(), action: #selector(revealViewController().revealToggle(_:)))
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
            self.view.addGestureRecognizer(self.revealViewController().tapGestureRecognizer())
        }
        manName.text = Constants.sharedInstance.man?.getNameGroom()
        manCounterDay.text = Constants.sharedInstance.man?.getCounterDay()
        let numberManCustomer = String(Constants.sharedInstance.man!.getNumberCustomer())
        manNumberClient.text =  numberManCustomer
        
        womanName.text = Constants.sharedInstance.woman?.getNameBride()
        womanCounterDay.text = Constants.sharedInstance.woman?.getCounterDay()
        let numberWonmanCustomer = String(Constants.sharedInstance.woman!.getNumberCustomer())
        womanNumberClient.text = numberWonmanCustomer
        nameFactory.text = Constants.sharedInstance.factory?.getName()
    }

    @IBAction func openWeb(_ sender: Any) {
        //get number guest:man+woman = number heart
        UIApplication.shared.openURL(URL(string: linkWeb)!)
    }
    
    @IBAction func sharePressed(_ sender: Any) {
        shareApp()
    }
    
    @IBAction func downloadMemberList(_ sender: Any) {
        downloadMemberExcel()
    }
   
    @IBAction func openWedForLogined(_ sender: Any) {
        //get url imag? and wedstep? = numberheart
        UIApplication.shared.openURL(URL(string: linkWebLogin)!)
    }
    
    @IBAction func sendImageOfSeatPosition(_ sender: Any) {
        sendImageOfPosition()
    }
    
    @IBAction func dismiss(_ sender: Any) {
        self.dismiss(animated: false, completion: nil)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}
