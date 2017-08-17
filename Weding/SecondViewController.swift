//
//  SecondViewController.swift
//  Weding
//
//  Created by kien le van on 8/4/17.
//  Copyright © 2017 kien le van. All rights reserved.
//

import UIKit

class SecondViewController: BaseViewController, UITableViewDelegate, UITableViewDataSource, UITextViewDelegate {

    @IBOutlet weak var table: UITableView!
    @IBOutlet weak var manName: UILabel!
    @IBOutlet weak var womanName: UILabel!
    @IBOutlet weak var counterDay: UILabel!
    @IBOutlet weak var dayOfWedding: UILabel!
    @IBOutlet weak var hourOfWedding: UILabel!
    @IBOutlet weak var contrainsReplayView: NSLayoutConstraint!
    @IBOutlet weak var replyView: UIView!
    @IBOutlet weak var replyMessageText: UITextView!
    var tap: UITapGestureRecognizer?
    
    var arr = [GuestMessage]()

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpWedding()
        setupListMessage()
        setUpReplyMessageView()
        setupNavigation()
        
        let guest1 = GuestMessage(name: "Tom", message: "alo alo alo alo alo alo alo alo alo alo alo alo alo alo alo alo alo alo alo alo alo alo alo", timeSend: "2017/6/23")
        let guest2 = GuestMessage(name: "Michael", message: "hi", timeSend: "2017/6/4")
        let guest3 = GuestMessage(name: "Jane", message: "hello", timeSend: "2017/6/25")
        let guest4 = GuestMessage(name: "South", message: "ahihi", timeSend: "2017/6/26")
//        arr = [guest1, guest2, guest3, guest4]
        arr.append(guest1)
        arr.append(guest2)
        arr.append(guest3)
        arr.append(guest4)
        
    }
    
    func setUpWedding() {
        manName.text = Constants.sharedInstance.man?.name
        womanName.text = Constants.sharedInstance.woman?.name
        counterDay.text = Constants.sharedInstance.man?.counterDay
        dayOfWedding.text = Constants.sharedInstance.woman?.weddingDay
    }
    
    func setupListMessage() {
        table.layer.borderWidth = 0.5
        table.layer.borderColor = UIColor.rgb(r: 236, g: 186, b: 206).cgColor
        table.estimatedRowHeight = 140
        
    }
    
    func setUpReplyMessageView() {
        replyView.isHidden = true
        replyView.layer.borderColor = UIColor.rgb(r: 233, g: 130, b: 139).cgColor
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(self.keyboardNotification(notification:)),
                                               name: NSNotification.Name.UIKeyboardWillChangeFrame,
                                               object: nil)
        tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tap!)
        replyMessageText.delegate = self
    }
    
    func dismissKeyboard() {
        view.endEditing(true)
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:MessageViewCell = table.dequeueReusableCell(withIdentifier: "MessageCell", for: indexPath) as! MessageViewCell
        cell.callBack = { [weak self] in
            self?.replyMessageText.becomeFirstResponder()
            let guest = self?.arr[indexPath.row]
            print(guest?.getname() ?? "")
        }
        cell.binData(guest: arr[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        table.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    
    @IBAction func sendMeesage(_ sender: Any) {
        let message = replyMessageText.text
        if (message == "") {
            replyMessageText.resignFirstResponder()
            return
        }
        let alert = UIAlertController(title: "Notification", message: "Send message succses", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
        replyMessageText.resignFirstResponder()
        self.present(alert, animated: true) { 
            self.replyMessageText.text = ""
        }
    }
 
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc func keyboardNotification(notification: NSNotification) {
        if let userInfo = notification.userInfo {
            let endFrame = (userInfo[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue
            let duration:TimeInterval = (userInfo[UIKeyboardAnimationDurationUserInfoKey] as? NSNumber)?.doubleValue ?? 0
            let animationCurveRawNSN = userInfo[UIKeyboardAnimationCurveUserInfoKey] as? NSNumber
            let animationCurveRaw = animationCurveRawNSN?.uintValue ?? UIViewAnimationOptions.curveEaseInOut.rawValue
            let animationCurve:UIViewAnimationOptions = UIViewAnimationOptions(rawValue: animationCurveRaw)
            if (endFrame?.origin.y)! >= UIScreen.main.bounds.size.height {
                self.navigationItem.leftBarButtonItem?.isEnabled = true
                self.navigationItem.rightBarButtonItem?.isEnabled = true
                replyView.isHidden = true
                view.removeGestureRecognizer(tap!)
                self.contrainsReplayView.constant = 0.0
            } else {
                self.navigationItem.leftBarButtonItem?.isEnabled = false
                self.navigationItem.rightBarButtonItem?.isEnabled = false
                replyView.isHidden = false
                tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
                view.addGestureRecognizer(tap!)
                self.contrainsReplayView.constant = (endFrame?.size.height)! + 5
            }
            UIView.animate(withDuration: duration,
                           delay: TimeInterval(0),
                           options: animationCurve,
                           animations: { self.view.layoutIfNeeded() },
                           completion: nil)
//            DispatchQueue.main.async(execute: {
//                self.scrollLastMessage()
//            })
        }
    }


}
