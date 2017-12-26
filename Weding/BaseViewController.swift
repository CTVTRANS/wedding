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
import SDWebImage

class BaseViewController: UIViewController {

    var swVC: SWRevealViewController?
    var activity: UIActivityIndicatorView?
    var backGroundview: UIView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        swVC = self.revealViewController()
    }
    
    func setupNavigation() {
        if self.revealViewController() != nil {
            navigationItem.leftBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "ic_leftButton"), style: .plain, target: self.revealViewController(), action: #selector(revealViewController().revealToggle(_:)))
            navigationItem.rightBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "ic_back"), style: .done, target: self, action: #selector(popToRootNavigation))
            navigationController?.navigationBar.isTranslucent = false
            navigationController?.navigationBar.barTintColor = UIColor.rgb(240, 167, 195)
            navigationItem.title = "婚禮籌備平台"
//            self.navigationController?.navigationBar.isTranslucent = false
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
            self.view.addGestureRecognizer(self.revealViewController().tapGestureRecognizer())
        }
    }
    
    @objc func popToRootNavigation() {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "MainView") as? MainViewController
        let navigationController: UINavigationController = UINavigationController.init(rootViewController: vc!)
        swVC?.pushFrontViewController(navigationController, animated: true)

    }

    func requestWithTask(task: BaseTaskNetwork, success: @escaping BlockSuccess) {
        task.request(blockSucess: { (data) in
            success(data)
        }) { (error) in
            self.stopActivityIndicator()
            UIAlertController.showAlertWith(title: "", message: error!, myViewController: self)
        }
    }
    
    func downloadFileSuccess(task: BaseTaskNetwork, success: @escaping BlockSuccess, failure: @escaping BlockFailure) {
        task.downloadFileSuccess({ (data) in
            success(data)
        }) { (error) in
            failure(error)
        }
    }
    
    func uploadFileSuccess(task: BaseTaskNetwork, success: @escaping BlockSuccess) {
        task.upLoadFile({ (data) in
            success(data)
        }) { (error) in
            UIAlertController.showAlertWith(title: "", message: error!, myViewController: self)
        }
    }
    
    func downloadMemberExcel(objectID: String) {
        let getMemberTask: DowloadMemberList = DowloadMemberList(object: objectID)
        downloadFileSuccess(task: getMemberTask, success: { (data) in
            if let fileURL  = data as? URL {
                let activityVC: UIActivityViewController =
                    UIActivityViewController.init(activityItems: [fileURL], applicationActivities: nil)
                
                if objectID == "1" {
                    Constants.shared.man?.filePath = fileURL
                } else {
                    Constants.shared.woman?.filePath = fileURL
                }
                activityVC.popoverPresentationController?.sourceView = self.view
                self.present(activityVC, animated: true, completion: nil)
            }
        }) { (_) in
            UIAlertController.showAlertWith(title: "", message: "不能下載賓客規劃表", myViewController: self)
        }
    }
    
    func uploadExcel(url: URL, object: String, nameFile: String) {
        var data: Data?
        do {
            data = try? Data(contentsOf: url)
        }
        if data == nil {
            _ = UIAlertController.showAlertWith(title: "", message: "no has file", myViewController: self)
            return
        }
        let uploadTask: UploadMemberTask = UploadMemberTask(data: data!, todo: object, name: nameFile)
        uploadFileSuccess(task: uploadTask) { (message) in
            let fileManager: FileManager = FileManager.default
            do {
                try fileManager.removeItem(at: url)
            } catch {
                
            }
            UIAlertController.showAlertWith(title: "", message: (message as? String)!, myViewController: self)
        }
    }
    
    func shareApp() {
        let myAccount: Account = Account.getAccount()
        let memberURL = myAccount.memberURL
        let textToShare = "洪世瑋＆張鈞萍 宴客邀約平台\r\n \(memberURL)\r\n請進入 \"貴賓回函\" \r\n回覆參加人數，期待您的出席\r\n"
        if let myWebsite = NSURL(string: memberURL) {
            let objectsToShare = [textToShare, myWebsite] as [Any]
            let activityVC = UIActivityViewController(activityItems: objectsToShare, applicationActivities: nil)
            self.present(activityVC, animated: true, completion: nil)
        }
    }
    
    func showActivity(inView myView: UIView) {
        //        backGroundview = UIView(frame: UIScreen.main.bounds)
        backGroundview = UIView(frame: myView.bounds)
        backGroundview?.backgroundColor = UIColor.white
        let loadingView = UIView(frame: CGRect(x: 0, y: 0, width: 80, height: 80))
        loadingView.backgroundColor = UIColor.clear
        activity = UIActivityIndicatorView(activityIndicatorStyle: .gray)
        loadingView.addSubview(activity!)
        let nameLoading = UILabel(frame: CGRect(x: 0, y: 0, width: 80, height: 20))
        nameLoading.font = UIFont(name: "Helvetica Neue", size: 15)
        nameLoading.text = "loading..."
        nameLoading.textAlignment = .center
        nameLoading.textColor = UIColor.gray
        nameLoading.backgroundColor = UIColor.clear
        nameLoading.translatesAutoresizingMaskIntoConstraints = true
        loadingView.addSubview(nameLoading)
        
        backGroundview?.addSubview(loadingView)
        nameLoading.center = CGPoint(x: loadingView.center.x, y: loadingView.center.y + 23)
        activity?.center = loadingView.center
        loadingView.center = (backGroundview?.center)!
        myView.addSubview(backGroundview!)
        //        UIApplication.shared.keyWindow?.addSubview(backGroundview!)
        activity?.startAnimating()
    }
    
    func stopActivityIndicator() {
        activity?.stopAnimating()
        backGroundview?.removeFromSuperview()
    }
}
