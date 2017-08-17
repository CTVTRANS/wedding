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
    
    let urlToRequest = "http://www.freewed.com.tw/api/GetMemberSearch.aspx"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        userNameTextField.layer.borderColor = UIColor.rgb(r: 233, g: 130, b: 139).cgColor
         passWordTextField.layer.borderColor = UIColor.rgb(r: 233, g: 130, b: 139).cgColor
        let getInformationFactoryTask: GetFactoryTask = GetFactoryTask()
        requestWithTask(task: getInformationFactoryTask, success: { (data) in
            self.nameFactory.text = Constants.sharedInstance.factory?.getName()
        }) { (error) in
            
        }
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
            let numberGuest =
                (Constants.sharedInstance.man?.numberGuest)! + (Constants.sharedInstance.woman?.numberGuest)!
            let numberMessage = Int(5)
            let memberURL = Constants.sharedInstance.woman?.memberURL
            let linkTable = Constants.sharedInstance.woman?.tableSeat
            let linkWedStep = Constants.sharedInstance.woman?.webStep
            var numberNotificationOfSeat: Int = 0
            if ((linkTable?.characters.count)! > 0) {
                numberNotificationOfSeat += 1
            } else if ((linkWedStep?.characters.count)! > 0){
                numberNotificationOfSeat += 1
            }
            let myAccount = Account(name: name!, numberGuest: numberGuest, numberMessage: numberMessage, memberURL: memberURL!, seat: numberNotificationOfSeat)
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
