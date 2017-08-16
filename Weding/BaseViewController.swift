//
//  BaseViewController.swift
//  Weding
//
//  Created by kien le van on 8/4/17.
//  Copyright © 2017 kien le van. All rights reserved.
//

import UIKit
import SWRevealViewController
import LCNetwork
import CryptoSwift

class BaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func requestWithTask(task: BaseTaskNetwork, success: @escaping BlockSuccess, failure: @escaping BlockFailure) {
        task.request(blockSucess: { (data) in
            success(data)
        }) { (error) in
            failure(error)
        }
    }
    
    func downloadFileSuccess(task: BaseTaskNetwork, success: @escaping BlockSuccess, failure: @escaping BlockFailure) {
        task.downloadFileSuccess({ (data) in
            success(data)
        }) { (error) in
            failure(error)
        }
    }
    
    func uploadFileSuccess(task: BaseTaskNetwork, success: @escaping BlockSuccess, failure: @escaping BlockFailure) {
        task.upLoadFile({ (data) in
            success(data)
        }) { (error) in
            failure(error)
        }
    }
}
