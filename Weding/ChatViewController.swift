//
//  ChatViewController.swift
//  Weding
//
//  Created by kien le van on 8/18/17.
//  Copyright © 2017 kien le van. All rights reserved.
//

import UIKit

class ChatViewController: BaseViewController, UITableViewDataSource, UITableViewDelegate, UITextViewDelegate {
    
    @IBOutlet weak var table: UITableView!
    @IBOutlet weak var constraintBotTextView: NSLayoutConstraint!
    @IBOutlet weak var replyTextView: UITextView!
    @IBOutlet weak var constraintBotView: NSLayoutConstraint!
    @IBOutlet weak var moreButotn: UIButton!
    var tap: UITapGestureRecognizer?
    var hightConstant: CGFloat!
    
    var guestMessge: GuestMessage?
    var arr = [GuestMessage]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigation()
        moreButotn.layer.borderColor = UIColor.blue.cgColor
        table.estimatedRowHeight = 140
        setUpReplyMessageView()
        arr.append(guestMessge!)
    }
    
    func setUpReplyMessageView() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(self.keyboardNotification(notification:)),
                                               name: NSNotification.Name.UIKeyboardWillChangeFrame,
                                               object: nil)
        replyTextView.delegate = self
    }
    
    func scrollLastMessage(){
        let contensizeHight = self.table.contentSize.height
        let frameHight = self.table.frame.size.height
        if (contensizeHight > frameHight) {
            let offset = CGPoint(x: 0, y: contensizeHight - frameHight)
            self.table.setContentOffset(offset, animated: false)
        }
    }
    
    func dismissKeyboard() {
        view.endEditing(true)
    }

    @IBAction func pressedReplyButton(_ sender: Any) {
        let message: String = replyTextView.text
        if (message == "") {
            replyTextView.resignFirstResponder()
            return
        }
        let sendMessageTask: SendMessageTask = SendMessageTask(name: "m01", contentMessage: message)
        requestWithTask(task: sendMessageTask, success: { (data) in
            let dateFormatter : DateFormatter = DateFormatter()
            dateFormatter.dateFormat = "MM/dd HH:mm"
            let date = Date()
            let dateString = dateFormatter.string(from: date)
            let index = dateString.index(dateString.startIndex, offsetBy: 1)
            let time = dateString.substring(from: index)
            let newguest = GuestMessage(name: "", message: message, timeSend: time, avatar: #imageLiteral(resourceName: "logo mess 2"))
            self.arr.append(newguest)
            self.replyTextView.text = ""
            self.replyTextView.resignFirstResponder()
            let _ = UIAlertController.showAlertWith(title: "Notification", message: data as! String, myViewController: self)
            self.table.reloadData()
            self.scrollLastMessage()
        }) { (error) in
            print(error!)
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if (indexPath.row == 0) {
            let cell: GusetViewCell = table.dequeueReusableCell(withIdentifier: "GuestViewCell", for: indexPath) as! GusetViewCell
            cell.binData(guestMessage: self.guestMessge!)
            return cell
        }
        let cell: MyViewCell = table.dequeueReusableCell(withIdentifier: "MyViewCell", for: indexPath) as! MyViewCell
        cell.binData(myMessage: arr[indexPath.row])
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
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
                view.removeGestureRecognizer(tap!)
                constraintBotView.constant = 0.0
                constraintBotTextView.constant = 0.0
            } else {
                tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
                view.addGestureRecognizer(tap!)
                self.navigationItem.leftBarButtonItem?.isEnabled = false
                self.navigationItem.rightBarButtonItem?.isEnabled = false
                constraintBotView.constant = (endFrame?.size.height)!
                constraintBotTextView.constant = (endFrame?.size.height)!
            }
            UIView.animate(withDuration: duration,
                           delay: TimeInterval(0),
                           options: animationCurve,
                           animations: { self.view.layoutIfNeeded() },
                           completion: nil)
            DispatchQueue.main.async(execute: {
                self.scrollLastMessage()
            })
        }
    }
    @IBAction func pressedBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}
