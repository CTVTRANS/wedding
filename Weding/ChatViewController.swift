//
//  ChatViewController.swift
//  Weding
//
//  Created by kien le van on 8/18/17.
//  Copyright © 2017 kien le van. All rights reserved.
//

import UIKit

class ChatViewController: BaseViewController {
    
    @IBOutlet weak var table: UITableView!
    @IBOutlet weak var constraintBotTextView: NSLayoutConstraint!
    @IBOutlet weak var replyTextView: UITextView!
    @IBOutlet weak var constraintBotView: NSLayoutConstraint!
    @IBOutlet weak var moreButotn: UIButton!
    var tap: UITapGestureRecognizer?
    var hightConstant: CGFloat!

    var guest: Guest?
    var arr = [Message]()
    var pager = 1
    var isloading = false
    var isMoreData = true
    var isScrollTop = false
    var isFirstGotoView = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigation()
        showActivity(inView: self.view)
        moreButotn.layer.borderColor = UIColor.blue.cgColor
        table.estimatedRowHeight = 140
        setUpReplyMessageView()
        getMessage()
        NotificationCenter.default.addObserver(self, selector: #selector(requestToServer(notification:)), name: NSNotification.Name(rawValue: "recivePush"), object: nil)
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "ic_back"), style: .plain, target: self, action: #selector(popNavigation))
    }
    
    @objc func popNavigation() {
        navigationController?.popViewController(animated: false)
    }
    
    func setUpReplyMessageView() {
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardNotification(notification:)), name: NSNotification.Name.UIKeyboardWillChangeFrame, object: nil)
        replyTextView.delegate = self
    }
    
    func getMessage() {
        isloading = true
        let getMessageGuest = GetMessageWithGuest(idGuest: (guest?.idGuest)!, page: pager, limit: 30)
        requestWithTask(task: getMessageGuest) { (listMessage) in
            guard let listMessage = listMessage as? [Message] else {
                return
            }
            if listMessage.count == 0 {
                self.isMoreData = false
                return
            }
            self.isloading = false
            self.arr.insert(contentsOf: listMessage.reversed(), at: 0)
            self.table.reloadData()
            if self.isScrollTop {
                let indexpath = IndexPath(row: listMessage.count, section: 0)
                self.table.scrollToRow(at: indexpath, at: .top, animated: false)
                self.isScrollTop = false
            } else {
                if self.isFirstGotoView {
                     self.scrollLastMessage(animated: false)
                } else {
                     self.scrollLastMessage(animated: true)
                }
            }
        }
    }
    
    func getNewMessage() {
        self.isScrollTop = false
        self.isMoreData = true
        self.pager = 1
        self.arr = []
        self.getMessage()
    }
    
    @objc func requestToServer(notification: Notification) {
        let name = notification.object as? String
        if name == "GuestAddMessageToMember" {
            getNewMessage()
        }
    }

    func scrollLastMessage(animated: Bool) {
        DispatchQueue.main.async {
            if self.arr.count > 0 {
                self.table.scrollToRow(at: IndexPath(row: self.arr.count - 1, section: 0), at: .bottom, animated: animated)
                self.stopActivityIndicator()
            }
        }
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
        view.removeGestureRecognizer(tap!)
    }

    @IBAction func pressedReplyButton(_ sender: Any) {
        let message: String = replyTextView.text
        if message == "" {
            return
        }
        self.replyTextView.text = ""
        let sendMessageTask: SendMessageTask = SendMessageTask(name: (guest?.nameGuest)!, contentMessage: message)
        requestWithTask(task: sendMessageTask) { (_) in
            self.getNewMessage()
        }
    }
    
    @IBAction func pressedBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}

extension ChatViewController: UITableViewDataSource, UITableViewDelegate, UITextViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let guestCell = table.dequeueReusableCell(withIdentifier: "GuestViewCell", for: indexPath) as? GusetViewCell
        let myCell = table.dequeueReusableCell(withIdentifier: "MyViewCell", for: indexPath) as? MyViewCell
        let message = arr[indexPath.row]
        if message.isMyMessage() {
            myCell?.binData(myMessage: message)
            return myCell!
        } else {
            guestCell?.binData(guestMessage: message)
//            guestCell?.avatar.sd_setImage(with: URL(string: (guest?.avatar)!))
            return guestCell!
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let topOftable = table.contentOffset.y < 100.0 ? true : false
        if isMoreData && topOftable && !isloading {
            isloading = true
            pager += 1
            isScrollTop = true
            getMessage()
        }
    }
    
    @objc func keyboardNotification(notification: NSNotification) {
        if let userInfo = notification.userInfo {
            let endFrame = (userInfo[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue
            let duration: TimeInterval = (userInfo[UIKeyboardAnimationDurationUserInfoKey] as? NSNumber)?.doubleValue ?? 0
            let animationCurveRawNSN = userInfo[UIKeyboardAnimationCurveUserInfoKey] as? NSNumber
            let animationCurveRaw = animationCurveRawNSN?.uintValue ?? UIViewAnimationOptions.curveEaseInOut.rawValue
            let animationCurve: UIViewAnimationOptions = UIViewAnimationOptions(rawValue: animationCurveRaw)
            if (endFrame?.origin.y)! >= UIScreen.main.bounds.size.height {
                self.navigationItem.leftBarButtonItem?.isEnabled = true
                self.navigationItem.rightBarButtonItem?.isEnabled = true
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
//                                self.scrollLastMessage()
            })
        }
    }
}

extension UITableView {
//    func reloadSucess(sucess:@escaping (() -> Void)) {
//        UIView.animate(withDuration: 0, animations: {
//            self.reloadData()
//        }) { (_) in
//            sucess()
//        }
//    }
}
