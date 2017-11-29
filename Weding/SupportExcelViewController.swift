//
//  SupportExcelViewController.swift
//  Weding
//
//  Created by kien le van on 10/28/17.
//  Copyright © 2017 kien le van. All rights reserved.
//

import UIKit

class SupportExcelViewController: BaseViewController, UIWebViewDelegate {

    @IBOutlet weak var webView: UIWebView!
    override func viewDidLoad() {
        super.viewDidLoad()
        showActivity(inView: self.view)
        webView.delegate = self
        webView.scrollView.bounces = false
        webView.loadRequest(URLRequest(url: URL(string: linkguideExcel)!))
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "ic_back"), style: .plain, target: self, action: #selector(popNavigation))
        
    }
    
    @objc func popNavigation() {
        navigationController?.popViewController(animated: false)
    }
    
    func webViewDidFinishLoad(_ webView: UIWebView) {
        stopActivityIndicator()
    }

}
