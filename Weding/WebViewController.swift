//
//  WebViewController.swift
//  Weding
//
//  Created by kien le van on 8/4/17.
//  Copyright © 2017 kien le van. All rights reserved.
//

import UIKit

class WebViewController: BaseViewController {
    
    var url:URL!
    @IBOutlet weak var webVC: UIWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let request = URLRequest.init(url: url)
        webVC.loadRequest(request)

    }

}
