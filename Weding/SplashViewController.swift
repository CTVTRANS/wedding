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
        if (Account.isAuthentic()) {
            let loginTask:LoginTask = LoginTask(name: Account.getAccount().name,
                                                pass: Account.getAccount().pass)
            requestWithTask(task: loginTask, success: { (data) in
                print(data!)
                self.processNumberNotification()
                
                let vc: SWRevealViewController = self.storyboard?.instantiateViewController(withIdentifier: "SWRevealViewController") as! SWRevealViewController
                self.present(vc, animated: false, completion: nil)
            }) { (error) in
                let _ = UIAlertController.showAlertWith(title: "Warnning", message: "", myViewController: self)
                return
            }
        } else {
            let vc: UINavigationController = self.storyboard?.instantiateViewController(withIdentifier: "LoginView") as! UINavigationController
//            self.navigationController?.present(vc, animated: false, completion: nil)
            self.present(vc, animated: false, completion: { 
                print("ok")
            })
        }
    }
    
    deinit {
         NotificationCenter.default.removeObserver(self)
    }
}
