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
    
    @IBOutlet weak var hightOfTextView: NSLayoutConstraint!
    @IBOutlet weak var contrainsReplayView: NSLayoutConstraint!
    @IBOutlet weak var contrainsTop: NSLayoutConstraint!
    @IBOutlet weak var contraintTextMessage: NSLayoutConstraint!
    @IBOutlet weak var replyView: UIView!
    @IBOutlet weak var replyMessageText: UITextView!

    var tap: UITapGestureRecognizer?
    var hightConstant: CGFloat!
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
    }
    
    func setUpReplyMessageView() {
        hightConstant = replyMessageText.frame.size.height
        replyView.isHidden = true
        replyMessageText.isHidden = true
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(self.keyboardNotification(notification1:)),
                                               name: NSNotification.Name.UIKeyboardWillChangeFrame,
                                               object: nil)
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
        cell.binData(guest: arr[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        table.deselectRow(at: indexPath, animated: true)
        let vc: ChatViewController = self.storyboard?.instantiateViewController(withIdentifier: "ChatViewController") as! ChatViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func sendMeesage(_ sender: Any) {
        let message: String = replyMessageText.text
        if (message == "") {
            replyMessageText.resignFirstResponder()
            return
        }
        let sendMessageTask: SendMessageTask = SendMessageTask(name: "m01,m02,m03", contentMessage: message)
        requestWithTask(task: sendMessageTask, success: { (data) in
            print(data!)
            self.replyMessageText.text = ""
            self.replyMessageText.resignFirstResponder()
            let _ = UIAlertController.showAlertWith(title: "Notification", message: data as! String, myViewController: self)
        }) { (error) in
            print(error!)
        }
    }
 
    @IBAction func prssedSendAll(_ sender: Any) {
        replyMessageText.becomeFirstResponder()
        replyView.isHidden = false
        replyMessageText.isHidden = false
    }
    
    func textViewDidChange(_ textView: UITextView) {
        let fixedWidth = replyMessageText.frame.size.width
        replyMessageText.sizeThatFits(CGSize(width: fixedWidth, height: CGFloat.greatestFiniteMagnitude))
        let newSize = replyMessageText.sizeThatFits(CGSize(width: fixedWidth, height: CGFloat.greatestFiniteMagnitude))
        hightOfTextView.constant = newSize.height
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc func keyboardNotification(notification1: NSNotification) {
        if let userInfo = notification1.userInfo {
            let endFrame = (userInfo[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue
            let duration:TimeInterval = (userInfo[UIKeyboardAnimationDurationUserInfoKey] as? NSNumber)?.doubleValue ?? 0
            let animationCurveRawNSN = userInfo[UIKeyboardAnimationCurveUserInfoKey] as? NSNumber
            let animationCurveRaw = animationCurveRawNSN?.uintValue ?? UIViewAnimationOptions.curveEaseInOut.rawValue
            let animationCurve:UIViewAnimationOptions = UIViewAnimationOptions(rawValue: animationCurveRaw)
            if (endFrame?.origin.y)! >= UIScreen.main.bounds.size.height {
                self.navigationItem.leftBarButtonItem?.isEnabled = true
                self.navigationItem.rightBarButtonItem?.isEnabled = true
                replyView.isHidden = true
                replyMessageText.isHidden = true
                view.removeGestureRecognizer(tap!)
                contrainsReplayView.constant = 0.0
                contraintTextMessage.constant = 0.0
                contrainsTop.constant = 44.0
                hightOfTextView.constant = hightConstant
            } else {
                self.navigationItem.leftBarButtonItem?.isEnabled = false
                self.navigationItem.rightBarButtonItem?.isEnabled = false
                replyView.isHidden = false
                replyMessageText.isHidden = false
                
                tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
                view.addGestureRecognizer(tap!)
                contrainsReplayView.constant = (endFrame?.size.height)!
                contraintTextMessage.constant = (endFrame?.size.height)!
                contrainsTop.constant = -(endFrame?.size.height)! + 44.0
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
