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
        
        userNameTextField.layer.borderColor = UIColor.init(red: 233/255.0, green: 130/255.0, blue: 139/255.0, alpha: 1.0).cgColor
        passWordTextField.layer.borderColor = UIColor.init(red: 233/255.0, green: 130/255.0, blue: 139/255.0, alpha: 1.0).cgColor
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
            let alert: UIAlertController = UIAlertController(title: "Warnning", message: "user name or password can't emty", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            return
        }
        let loginTask:LoginTask = LoginTask(name: name!, pass: pass!)
        requestWithTask(task: loginTask, success: { (data) in
            print(data!)
            let vc: SWRevealViewController = self.storyboard?.instantiateViewController(withIdentifier: "SWRevealViewController") as! SWRevealViewController
            self.present(vc, animated: false, completion: nil)
        }) { (error) in
            let alert:UIAlertController
            if let dictionary = error as? [String: Any] {
                if let message: String = dictionary["ErrMsg"] as? String {
                    alert = UIAlertController(title: "Warnning", message: message, preferredStyle: UIAlertControllerStyle.alert)
                } else {
                    let message: String = (dictionary["RtnCode"] as? String)!
                    alert = UIAlertController(title: "Warnning", message: message, preferredStyle: UIAlertControllerStyle.alert)
                }
                alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
        }
    }
}
