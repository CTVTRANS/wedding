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
    @IBOutlet weak var constraintTop: NSLayoutConstraint!
    @IBOutlet weak var constraintBotTextView: NSLayoutConstraint!
    @IBOutlet weak var replyTextView: UITextView!
    @IBOutlet weak var hightOfTextView: NSLayoutConstraint!
    @IBOutlet weak var constraintBotView: NSLayoutConstraint!
    var tap: UITapGestureRecognizer?
    var hightConstant: CGFloat!
    
    var guestMessge: GuestMessage?
    var arr = [GuestMessage]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.title = "婚禮籌備平台"
        hightConstant = replyTextView.frame.size.height
        table.estimatedRowHeight = 140
        setUpReplyMessageView()
        arr.append(guestMessge!)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.navigationItem.title = guestMessge?.getname()
    }
    
    func setUpReplyMessageView() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(self.keyboardNotification(notification:)),
                                               name: NSNotification.Name.UIKeyboardWillChangeFrame,
                                               object: nil)
        replyTextView.delegate = self
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
            let newguest = GuestMessage(name: "", message: message, timeSend: "8/24 16:04")
            self.arr.append(newguest)
            self.replyTextView.text = ""
            self.replyTextView.resignFirstResponder()
            let _ = UIAlertController.showAlertWith(title: "Notification", message: data as! String, myViewController: self)
            self.table.reloadData()
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
    
    func textViewDidChange(_ textView: UITextView) {
        let fixedWidth = replyTextView.frame.size.width
        replyTextView.sizeThatFits(CGSize(width: fixedWidth, height: CGFloat.greatestFiniteMagnitude))
        let newSize = replyTextView.sizeThatFits(CGSize(width: fixedWidth, height: CGFloat.greatestFiniteMagnitude))
        hightOfTextView.constant = newSize.height
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
                view.removeGestureRecognizer(tap!)
                constraintBotView.constant = 0.0
                constraintBotTextView.constant = 0.0
                constraintTop.constant = 0.0
                hightOfTextView.constant = hightConstant
            } else {
                tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
                view.addGestureRecognizer(tap!)
                constraintBotView.constant = (endFrame?.size.height)!
                constraintBotTextView.constant = (endFrame?.size.height)!
                constraintTop.constant = -(endFrame?.size.height)!
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
