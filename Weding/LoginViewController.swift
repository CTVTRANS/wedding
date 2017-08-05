//
//  LoginViewController.swift
//  Weding
//
//  Created by kien le van on 8/4/17.
//  Copyright © 2017 kien le van. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var passWordTextField: UITextField!
    @IBOutlet weak var customNavigation: CustomNavigationBar!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        customNavigation.setUpTitle(title: "kien")
        userNameTextField.layer.borderColor = UIColor.init(red: 233/255.0, green: 130/255.0, blue: 139/255.0, alpha: 1.0).cgColor
        passWordTextField.layer.borderColor = UIColor.init(red: 233/255.0, green: 130/255.0, blue: 139/255.0, alpha: 1.0).cgColor

    }

    @IBAction func sigInPressed(_ sender: Any) {
        let vc: UINavigationController = self.storyboard?.instantiateViewController(withIdentifier: "Main") as! UINavigationController
        self.present(vc, animated: false, completion: nil)
    }
}
