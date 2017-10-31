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
    @IBOutlet weak var hightOfTextView: NSLayoutConstraint!
    @IBOutlet weak var contrainsReplayView: NSLayoutConstraint!
    @IBOutlet weak var contraintTextMessage: NSLayoutConstraint!
    @IBOutlet weak var replyView: UIView!
    @IBOutlet weak var replyMessageText: UITextView!
    @IBOutlet weak var replyLine: UILabel!
    
    var tap: UITapGestureRecognizer?
    var hightConstant: CGFloat!
    var arrGuest: [Guest] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        setupListMessage()
        setUpReplyMessageView()
        setupNavigation()
        table.estimatedRowHeight = 140
    }
    
    func setupListMessage() {
        table.layer.borderWidth = 0.5
        table.layer.borderColor = UIColor.rgb(236, 186, 206).cgColor
    }
    
    func setUpReplyMessageView() {
        replyView.isHidden = true
        replyMessageText.isHidden = true
        replyLine.isHidden = true
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
        return arrGuest.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = table.dequeueReusableCell(withIdentifier: "MessageCell", for: indexPath) as? MessageViewCell
        cell?.binData(guest: arrGuest[indexPath.row])
        return cell!
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        table.deselectRow(at: indexPath, animated: true)
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "ChatViewController") as? ChatViewController
        vc?.guest = arrGuest[indexPath.row]
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    
    @IBAction func sendMeesage(_ sender: Any) {
        let message: String = replyMessageText.text
        if message == "" {
            replyMessageText.resignFirstResponder()
            return
        }
        let sendMessageTask: SendMessageTask = SendMessageTask(name: "m01,m02,m03", contentMessage: message)
        requestWithTask(task: sendMessageTask) { (data) in
            print(data!)
            self.replyMessageText.text = ""
            self.replyMessageText.resignFirstResponder()
            _ = UIAlertController.showAlertWith(title: "", message: (data as? String)!, myViewController: self)
        }
    }
 
    @IBAction func prssedSendAll(_ sender: Any) {
//        replyMessageText.becomeFirstResponder()
        replyView.isHidden = false
        replyMessageText.isHidden = false
        replyLine.isHidden = false
    }
    
//    func textViewDidChange(_ textView: UITextView) {
//        let fixedWidth = replyMessageText.frame.size.width
//        replyMessageText.sizeThatFits(CGSize(width: fixedWidth, height: CGFloat.greatestFiniteMagnitude))
//        let newSize = replyMessageText.sizeThatFits(CGSize(width: fixedWidth, height: CGFloat.greatestFiniteMagnitude))
//        hightOfTextView.constant = newSize.height
//    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc func keyboardNotification(notification1: NSNotification) {
        if let userInfo = notification1.userInfo {
            let endFrame = (userInfo[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue
            let duration: TimeInterval = (userInfo[UIKeyboardAnimationDurationUserInfoKey] as? NSNumber)?.doubleValue ?? 0
            let animationCurveRawNSN = userInfo[UIKeyboardAnimationCurveUserInfoKey] as? NSNumber
            let animationCurveRaw = animationCurveRawNSN?.uintValue ?? UIViewAnimationOptions.curveEaseInOut.rawValue
            let animationCurve: UIViewAnimationOptions = UIViewAnimationOptions(rawValue: animationCurveRaw)
            if (endFrame?.origin.y)! >= UIScreen.main.bounds.size.height {
                self.navigationItem.leftBarButtonItem?.isEnabled = true
                self.navigationItem.rightBarButtonItem?.isEnabled = true
                replyView.isHidden = true
                replyMessageText.isHidden = true
                replyLine.isHidden = true
                view.removeGestureRecognizer(tap!)
                contrainsReplayView.constant = 0.0
                contraintTextMessage.constant = 0.0
//                hightOfTextView.constant = hightConstant
            } else {
                self.navigationItem.leftBarButtonItem?.isEnabled = false
                self.navigationItem.rightBarButtonItem?.isEnabled = false
                replyView.isHidden = false
                replyMessageText.isHidden = false
                replyLine.isHidden = false
                tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
                view.addGestureRecognizer(tap!)
                contrainsReplayView.constant = (endFrame?.size.height)!
                contraintTextMessage.constant = (endFrame?.size.height)!
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
