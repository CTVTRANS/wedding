//
//  ChatViewController.swift
//  Weding
//
//  Created by kien le van on 8/18/17.
//  Copyright © 2017 kien le van. All rights reserved.
//

import UIKit

class ChatViewController: BaseViewController {
    
    @IBOutlet weak var blurView: UIView!
    @IBOutlet weak var table: UITableView!
    @IBOutlet weak var constraintBotTextView: NSLayoutConstraint!
    @IBOutlet weak var replyTextView: UITextView!
    @IBOutlet weak var constraintBotView: NSLayoutConstraint!
    @IBOutlet weak var moreButotn: UIButton!
//    var tap: UITapGestureRecognizer?
    var hightConstant: CGFloat!

    var guest: Guest?
    var filePathAvatar = URL(string: "ad")
    var arr = [Message]()
    var pager = 1
    var isloading = false
    var isMoreData = true
    var isScrollTop = false
    var isFirstGotoView = true
    var timer: Timer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigation()
        showActivity(inView: self.view)
        moreButotn.layer.borderColor = UIColor.blue.cgColor
        table.estimatedRowHeight = 140
        setUpReplyMessageView()
        donwloadGuestAvatar()
        
        NotificationCenter.default.addObserver(self, selector: #selector(requestToServer(notification:)), name: NSNotification.Name(rawValue: "recivePush"), object: nil)
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "ic_back"), style: .plain, target: self, action: #selector(popNavigation))
        timer = Timer.scheduledTimer(timeInterval: 120, target: self, selector: #selector(reGetMessage), userInfo: nil, repeats: true)
        blurView.isHidden = true
    }
    
    @objc func popNavigation() {
        timer?.invalidate()
        timer = nil
        navigationController?.popViewController(animated: false)
    }
    
    func setUpReplyMessageView() {
//        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardNotification(notification:)), name: NSNotification.Name.UIKeyboardWillChangeFrame, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: .UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: .UIKeyboardWillHide, object: nil)
        replyTextView.delegate = self
    }
    
    func donwloadGuestAvatar() {
        let task = DownloadAvatar(file: (guest?.avatar)!)
        downloadFileSuccess(task: task, success: { (data) in
            if let url = data as? URL {
                self.filePathAvatar = url
                self.getMessage()
            }
        }) { (_) in
             self.getMessage()
        }
    }
    
    @objc func reGetMessage() {
        let task = GetMessageWithGuest(idGuest: (guest?.idGuest)!, page: 1, limit: arr.count)
        requestWithTask(task: task) { (listMessage) in
            guard let listMessage = listMessage as? [Message] else {
                return
            }
            self.arr.removeAll()
            self.arr.append(contentsOf: listMessage.reversed())
            self.table.reloadData()
        }
    }
    
    func getMessage() {
        isloading = true
        let getMessageGuest = GetMessageWithGuest(idGuest: (guest?.idGuest)!, page: pager, limit: 30)
        requestWithTask(task: getMessageGuest) { (listMessage) in
            self.stopActivityIndicator()
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
//        DispatchQueue.main.async {
            if self.arr.count > 0 {
                self.table.scrollToRow(at: IndexPath(row: self.arr.count - 1, section: 0), at: .bottom, animated: animated)
                self.stopActivityIndicator()
            }
//        }
    }

    @IBAction func pressedReplyButton(_ sender: Any) {
        let message: String = replyTextView.text
        if message == "" {
            return
        }
        isScrollTop = false
        self.replyTextView.text = ""
        let sendMessageTask: SendMessageTask = SendMessageTask(idGuest: (guest?.idGuest)!, contentMessage: message)
        requestWithTask(task: sendMessageTask) { (_) in
            self.getNewMessage()
        }
    }
    @IBAction func pressBlurView(_ sender: Any) {
         view.endEditing(true)
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
            if let data = try? Data(contentsOf: filePathAvatar!) {
                guestCell?.avatar.image = UIImage(data: data)
            } else {
                guestCell?.avatar.backgroundColor = UIColor.green
            }
            return guestCell!
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let topOftable = table.contentOffset.y < 20.0 ? true : false
        if isMoreData && topOftable && !isloading {
            isloading = true
            pager += 1
            isScrollTop = true
            getMessage()
        }
    }
    
    func textViewShouldBeginEditing(_ textView: UITextView) -> Bool {
        let task = UpdateStatusMessage(guestID: (guest?.idGuest)!)
        requestWithTask(task: task) { (_) in
            
        }
        return true
    }
    
    @objc func keyboardWillShow(_ notification: Notification) {
        blurView.isHidden = false
//        tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
//        view.addGestureRecognizer(tap!)
        self.navigationItem.leftBarButtonItem?.isEnabled = false
        self.navigationItem.rightBarButtonItem?.isEnabled = false
        if let keyboardFrame: NSValue = notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardRectangle = keyboardFrame.cgRectValue
            constraintBotView.constant = keyboardRectangle.height
            constraintBotTextView.constant = keyboardRectangle.height
        }
        UIView.animate(withDuration: 0.2) {
            self.view.layoutIfNeeded()
        }
    }
    
    @objc func keyboardWillHide(_ notification: Notification) {
        blurView.isHidden = true
        self.navigationItem.leftBarButtonItem?.isEnabled = true
        self.navigationItem.rightBarButtonItem?.isEnabled = true
        constraintBotView.constant = 0.0
        constraintBotTextView.constant = 0.0
        UIView.animate(withDuration: 0.2) {
            self.view.layoutIfNeeded()
        }
    }
}
