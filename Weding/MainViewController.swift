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
        womanName.text = Constants.sharedInstance.woman?.getNameBride()
        womanCounterDay.text = Constants.sharedInstance.woman?.getCounterDay()
        
    }


    
    @IBAction func pressedItemRight(_ sender: Any) {
        self.dismiss(animated: false, completion: nil)
    }

    @IBAction func openWeb(_ sender: Any) {
        let webVC: WebViewController = self.storyboard?.instantiateViewController(withIdentifier: "Web") as! WebViewController
        let url = URL(string: "http://www.freewed.com.tw/app/LOVE.aspx?ACCT=ann730204")
        webVC.url = url
        self.navigationController?.pushViewController(webVC, animated: true)
    }
    
    @IBAction func sharePressed(_ sender: Any) {
        let textToShare = "Swift is awesome!  Check out this website about it!"
        if let myWebsite = NSURL(string: "http://www.codingexplorer.com/") {
            let objectsToShare = [textToShare, myWebsite] as [Any]
            let activityVC = UIActivityViewController(activityItems: objectsToShare, applicationActivities: nil)
            activityVC.popoverPresentationController?.sourceView = sender as? UIView
            self.present(activityVC, animated: true, completion: nil)
        }
    }
   
    @IBAction func dismiss(_ sender: Any) {
        self.dismiss(animated: false, completion: nil)
    }
}
