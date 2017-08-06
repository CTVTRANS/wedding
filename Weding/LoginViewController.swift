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
    @IBOutlet weak var customNavigation: CustomNavigationBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        userNameTextField.layer.borderColor = UIColor.init(red: 233/255.0, green: 130/255.0, blue: 139/255.0, alpha: 1.0).cgColor
        passWordTextField.layer.borderColor = UIColor.init(red: 233/255.0, green: 130/255.0, blue: 139/255.0, alpha: 1.0).cgColor

    }

    @IBAction func sigInPressed(_ sender: Any) {
        let vc: SWRevealViewController = self.storyboard?.instantiateViewController(withIdentifier: "SWRevealViewController") as! SWRevealViewController
        self.present(vc, animated: false, completion: nil)
    }
}
