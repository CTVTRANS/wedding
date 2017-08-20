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
            let memberURL = Constants.sharedInstance.woman?.memberURL
            let myAccount = Account(name: name!, pass: pass!, numberGuest: 0, numberMessage: 0, memberURL: memberURL!, seat: 0)
            let newNumberGuest = (Constants.sharedInstance.man?.numberGuest)! + (Constants.sharedInstance.woman?.numberGuest)!
            let newNumberMessage = Int(5)
            let linkTable = Constants.sharedInstance.woman?.tableSeat
            let linkWedStep = Constants.sharedInstance.woman?.webStep
            var newNumberNotificationOfSeat: Int = 0
            if ((linkTable?.characters.count)! > 0) {
                newNumberNotificationOfSeat += 1
            } else if ((linkWedStep?.characters.count)! > 0){
                newNumberNotificationOfSeat += 1
            }
            
            let guestNotification = newNumberGuest - myAccount.numberGuest
            Constants.sharedInstance.currentNotificationGuest = guestNotification
            let messageNotification = newNumberMessage - myAccount.numberMessage
            Constants.sharedInstance.currentNotificationMessage = messageNotification
            let seatNotification = newNumberNotificationOfSeat - myAccount.tableNotification
            Constants.sharedInstance.currentNotificationSeat = seatNotification

            myAccount.numberGuest = newNumberGuest
            myAccount.numberMessage = newNumberMessage
            myAccount.tableNotification = newNumberNotificationOfSeat
            Account.saveAccount(myAccount: myAccount)
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
