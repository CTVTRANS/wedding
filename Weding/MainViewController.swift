//
//  SecondViewController.swift
//  Weding
//
//  Created by kien le van on 8/4/17.
//  Copyright © 2017 kien le van. All rights reserved.
//

import UIKit

class MainViewController: BaseViewController {

    @IBOutlet weak var navigation: CustomNavigationBar!
    
    @IBOutlet weak var manName: UILabel!
    @IBOutlet weak var womanName: UILabel!
    @IBOutlet weak var manCounterDay: UILabel!
    @IBOutlet weak var womanCounterDay: UILabel!
    @IBOutlet weak var manNumberClient: UILabel!
    @IBOutlet weak var womanNumberClient: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if self.revealViewController() != nil {
            navigation.leftButton.addTarget(self.revealViewController(), action: #selector(revealViewController().revealToggle(_:)), for: .touchUpInside)
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
        
        
    }


    
    @IBAction func pressedItemRight(_ sender: Any) {
        self.dismiss(animated: false, completion: nil)
    }

    @IBAction func openWeb(_ sender: Any) {
        UIApplication.shared.openURL(URL(string: LINK_WEB)!)
    }
    
    @IBAction func sharePressed(_ sender: Any) {
        let textToShare = "Swift is awesome!  Check out this website about it!"
        if let myWebsite = NSURL(string: LINK_DOWNLOAD_APP) {
            let objectsToShare = [textToShare, myWebsite] as [Any]
            let activityVC = UIActivityViewController(activityItems: objectsToShare, applicationActivities: nil)
            activityVC.popoverPresentationController?.sourceView = sender as? UIView
            self.present(activityVC, animated: true, completion: nil)
        }
    }
   
    @IBAction func openWedForLogined(_ sender: Any) {
        UIApplication.shared.openURL(URL(string: LINK_WEB_LOGINED)!)
    }
    
    
    @IBAction func dismiss(_ sender: Any) {
        self.dismiss(animated: false, completion: nil)
    }
}
