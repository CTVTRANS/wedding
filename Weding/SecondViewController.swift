//
//  SecondViewController.swift
//  Weding
//
//  Created by kien le van on 8/4/17.
//  Copyright © 2017 kien le van. All rights reserved.
//

import UIKit

class SecondViewController: BaseViewController, UITableViewDelegate, UITableViewDataSource, UITextViewDelegate {

    @IBOutlet weak var blurView: UIView!
    @IBOutlet weak var table: UITableView!
    @IBOutlet weak var hightOfTextView: NSLayoutConstraint!
    @IBOutlet weak var contrainsReplayView: NSLayoutConstraint!
    @IBOutlet weak var contraintTextMessage: NSLayoutConstraint!
    @IBOutlet weak var replyView: UIView!
    @IBOutlet weak var replyMessageText: UITextView!
    @IBOutlet weak var replyLine: UILabel!
    
    var hightConstant: CGFloat!
    var arrGuest: [Guest] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        showActivity(inView: self.view)
        setupNavigation()
        setupListMessage()
        setUpReplyMessageView()
        table.estimatedRowHeight = 140
        getListGuest()
        blurView.isHidden = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        table.reloadData()
    }
    
    func setupListMessage() {
        table.layer.borderWidth = 0.5
        table.layer.borderColor = UIColor.rgb(236, 186, 206).cgColor
    }
    
    func setUpReplyMessageView() {
        replyView.isHidden = true
        replyMessageText.isHidden = true
        replyLine.isHidden = true
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: .UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: .UIKeyboardWillHide, object: nil)
        replyMessageText.delegate = self
    }
    
    func getListGuest() {
        let getListGuestTask = GetListGuestTask()
        requestWithTask(task: getListGuestTask) { (data) in
            if let array = data as? [Guest] {
                self.arrGuest = array
                self.table.reloadData()
                self.stopActivityIndicator()
            }
        }
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
        let task = UpdateStatusMessage(guestID: arrGuest[indexPath.row].idGuest)
        requestWithTask(task: task) { (_) in
            
        }
        
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "ChatViewController") as? ChatViewController
        vc?.guest = arrGuest[indexPath.row]
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    
    @IBAction func pressBlur(_ sender: Any) {
        view.endEditing(true)
    }
    @IBAction func sendMeesage(_ sender: Any) {
        let message: String = replyMessageText.text
        if message == "" {
            replyMessageText.resignFirstResponder()
            return
        }
        self.replyMessageText.text = ""
        let sendMessageTask: SendMessageTask = SendMessageTask(idGuest: "All", contentMessage: message)
        requestWithTask(task: sendMessageTask) { (data) in
            print(data!)
            self.replyMessageText.resignFirstResponder()
            UIAlertController.showAlertWith(title: "", message: (data as? String)!, myViewController: self)
        }
    }
 
    @IBAction func prssedSendAll(_ sender: Any) {
        replyView.isHidden = false
        replyMessageText.isHidden = false
        replyLine.isHidden = false
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc func keyboardWillShow(_ notification: Notification) {
        blurView.isHidden = false
        self.navigationItem.leftBarButtonItem?.isEnabled = false
        self.navigationItem.rightBarButtonItem?.isEnabled = false
        replyView.isHidden = false
        replyMessageText.isHidden = false
        replyLine.isHidden = false
       
        if let keyboardFrame: NSValue = notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardRectangle = keyboardFrame.cgRectValue
            contrainsReplayView.constant = keyboardRectangle.height
            contraintTextMessage.constant = keyboardRectangle.height
        }
        UIView.animate(withDuration: 0.2) {
            self.view.layoutIfNeeded()
        }
    }
    
    @objc func keyboardWillHide(_ notification: Notification) {
        blurView.isHidden = true
        self.navigationItem.leftBarButtonItem?.isEnabled = true
        self.navigationItem.rightBarButtonItem?.isEnabled = true
        replyView.isHidden = true
        replyMessageText.isHidden = true
        replyLine.isHidden = true
        contrainsReplayView.constant = 0.0
        contraintTextMessage.constant = 0.0
        UIView.animate(withDuration: 0.2) {
            self.view.layoutIfNeeded()
        }
    }
}
