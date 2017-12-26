//
//  SplashViewController.swift
//  Weding
//
//  Created by kien le van on 8/17/17.
//  Copyright © 2017 kien le van. All rights reserved.
//

import UIKit
import SWRevealViewController

class SplashViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        if Account.isAuthentic() {
            let loginTask: LoginTask = LoginTask(name: Account.getAccount().name,
                                                pass: Account.getAccount().pass)
            requestWithTask(task: loginTask) { (_) in
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "SWRevealViewController") as? SWRevealViewController
                self.present(vc!, animated: false, completion: nil)
            }
        } else {
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "LoginView") as? UINavigationController
            self.present(vc!, animated: false, completion: { 
                
            })
        }
    }
    
    deinit {
         NotificationCenter.default.removeObserver(self)
    }
}
