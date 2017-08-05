//
//  SecondViewController.swift
//  Weding
//
//  Created by kien le van on 8/4/17.
//  Copyright © 2017 kien le van. All rights reserved.
//

import UIKit

class MainViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.setBackgroundImage(#imageLiteral(resourceName: "navigationBar"), for: .default)
        self.navigationController?.navigationBar.tintColor = UIColor.white
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
    @IBAction func dismiss(_ sender: Any) {
        self.dismiss(animated: false, completion: nil)
    }
}
