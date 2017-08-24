//
//  LoginViewController.swift
//  Weding
//
//  Created by kien le van on 8/4/17.
//  Copyright © 2017 kien le van. All rights reserved.
//

import UIKit
import SWRevealViewController

class LoginViewController: BaseViewController {

    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var passWordTextField: UITextField!
    @IBOutlet weak var nameFactory: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        userNameTextField.layer.borderColor = UIColor.rgb(r: 233, g: 130, b: 139).cgColor
        passWordTextField.layer.borderColor = UIColor.rgb(r: 233, g: 130, b: 139).cgColor
    }

    @IBAction func sigInPressed(_ sender: Any) {
        let name: String? = userNameTextField.text
        let pass: String? = passWordTextField.text
        if (name == "" || pass == "" ) {
            _ = UIAlertController.showAlertWith(title: "Notification",
                                                message: "user name or password can't emty",
                                                myViewController: self)
            return
        }
        let loginTask:LoginTask = LoginTask(name: name!, pass: pass!)
        requestWithTask(task: loginTask, success: { (data) in
            print(data!)
            Constants.sharedInstance.currentNotificationGuest = 0
            Constants.sharedInstance.currentNotificationMessage = 0
            Constants.sharedInstance.currentNotificationSeat = 0
            let memberURL = Constants.sharedInstance.woman?.memberURL
            let myAccount = Account(name: name!, pass: pass!, numberGuest: 0, numberMessage: 0, memberURL: memberURL!, seat: 0)
            myAccount.currentGuestNumberBadge = Constants.sharedInstance.currentNotificationGuest!
            myAccount.currentMessageNumberBadge =  Constants.sharedInstance.currentNotificationMessage!
            myAccount.currentSeatNumberBadge = Constants.sharedInstance.currentNotificationSeat!
            Account.saveAccount(myAccount: myAccount)
            self.processNumberNotification()
            self.showmainMenu()
        }) { (error) in
            if let dictionary = error as? [String: Any] {
                if let message: String = dictionary["ErrMsg"] as? String {
                    _ = UIAlertController.showAlertWith(title: "Warnning", message: message, myViewController: self)
                } else {
                    let message: String = (dictionary["RtnCode"] as? String)!
                    _ = UIAlertController.showAlertWith(title: "Warnning", message: message, myViewController: self)
                }
            }
        }
    }

    func showmainMenu() {
        let vc: SWRevealViewController = self.storyboard?.instantiateViewController(withIdentifier: "SWRevealViewController") as! SWRevealViewController
        self.present(vc, animated: false, completion: nil)
    }
}
