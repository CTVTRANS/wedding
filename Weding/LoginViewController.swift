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
        userNameTextField.layer.borderColor = UIColor.rgb(233, 130, 139).cgColor
        passWordTextField.layer.borderColor = UIColor.rgb(233, 130, 139).cgColor
    }

    @IBAction func sigInPressed(_ sender: Any) {
        let name: String? = userNameTextField.text
        let pass: String? = passWordTextField.text
        if name == "" || pass == "" {
            UIAlertController.showAlertWith(title: "Notification", message: "user name or password can't emty",
                                            myViewController: self)
            return
        }
        let loginTask: LoginTask = LoginTask(name: name!, pass: pass!)
        requestWithTask(task: loginTask) { (data) in
            print(data!)
            Constants.sharedInstance.currentNotificationGuest = 0
            Constants.sharedInstance.currentNotificationMessage = 0
            Constants.sharedInstance.currentNotificationSeat = 0
            let memberURL = Constants.sharedInstance.woman?.memberURL
            let myAccount = Account(name: name!, pass: pass!, numberGuest: 0, numberMessage: 0, memberURL: memberURL!, seat: 0)
            myAccount.currentGuestNumberBadge = Constants.sharedInstance.currentNotificationGuest!
            myAccount.currentMessageNumberBadge =  Constants.sharedInstance.currentNotificationMessage!
            myAccount.currentSeatNumberBadge = Constants.sharedInstance.currentNotificationSeat!
            myAccount.token = Constants.sharedInstance.token ?? ""
            myAccount.keyAccess = Constants.sharedInstance.keyAccount!
            Account.saveAccount(myAccount: myAccount)
            self.processNumberNotification()
            self.showmainMenu()
            
            let sendToken: SendToken = SendToken()
            self.requestWithTask(task: sendToken) { (_) in

            }
        }
    }

    @IBAction func pressedOpenWeb(_ sender: Any) {
         UIApplication.shared.openURL(URL(string: "http://www.freewed.com.tw/app/index0.aspx?todo=loginmb")!)
    }
    
    func showmainMenu() {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "SWRevealViewController") as? SWRevealViewController
        self.present(vc!, animated: false, completion: nil)
    }
}
