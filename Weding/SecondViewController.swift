//
//  SecondViewController.swift
//  Weding
//
//  Created by kien le van on 8/4/17.
//  Copyright © 2017 kien le van. All rights reserved.
//

import UIKit

class SecondViewController: BaseViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate {

    @IBOutlet weak var replyMessageView: UIView!
    @IBOutlet weak var table: UITableView!
    @IBOutlet weak var manName: UILabel!
    @IBOutlet weak var womanName: UILabel!
    @IBOutlet weak var counterDay: UILabel!
    @IBOutlet weak var dayOfWedding: UILabel!
    @IBOutlet weak var hourOfWedding: UILabel!
    @IBOutlet weak var memberTextField: UITextField!
    @IBOutlet weak var nameGuest: UILabel!
    @IBOutlet weak var contrainsTop: NSLayoutConstraint!
    @IBOutlet weak var contrainsBot: NSLayoutConstraint!
    var tap: UITapGestureRecognizer?
    var arr: [GuestMessage] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        if self.revealViewController() != nil {
            navigationItem.leftBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "ic_leftButton"), style: .plain, target: self.revealViewController(), action: #selector(revealViewController().revealToggle(_:)))
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
            self.view.addGestureRecognizer(self.revealViewController().tapGestureRecognizer())
        }
        let guest1 = GuestMessage(name: "Tom", message: "alo", timeSend: "2017/6/23 :")
        let guest2 = GuestMessage(name: "Michael", message: "hi", timeSend: "2017/6/4 :")
        let guest3 = GuestMessage(name: "Jane", message: "hello", timeSend: "2017/6/25 :")
        let guest4 = GuestMessage(name: "South", message: "ahihi", timeSend: "2017/6/26 :")
        arr = [guest1, guest2, guest3, guest4]
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(self.keyboardNotification(notification:)),
                                               name: NSNotification.Name.UIKeyboardWillChangeFrame,
                                               object: nil)
    }
    
    func setupUI() {
        manName.text = Constants.sharedInstance.man?.getNameGroom()
        womanName.text = Constants.sharedInstance.woman?.getNameBride()
        counterDay.text = Constants.sharedInstance.man?.getCounterDay()
        dayOfWedding.text = Constants.sharedInstance.woman?.getdayOfWedding()
        table.layer.borderWidth = 1
        replyMessageView.layer.borderColor = UIColor.init(red: 236/255.0, green: 186/255.0, blue: 206/255.0, alpha: 1.0).cgColor
        table.layer.borderColor = UIColor.init(red: 236/255.0, green: 186/255.0, blue: 206/255.0, alpha: 1.0).cgColor
        memberTextField.delegate = self
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return memberTextField.resignFirstResponder()
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
        let guest = arr[indexPath.row]
        nameGuest.text = guest.getname()
    }
    
    @IBAction func sendMeesage(_ sender: Any) {
        let message = memberTextField.text
        if (message == "") {
            return
        }
        let alert = UIAlertController(title: "Notification", message: "Send message succses", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true) { 
            self.memberTextField.text = ""
        }
    }

    @IBAction func pressedBackButton(_ sender: Any) {
        self.navigationController?.popViewController(animated: false)
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
                self.contrainsBot?.constant = 0.0
                self.contrainsTop?.constant = 20.0
            } else {
                tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
                view.addGestureRecognizer(tap!)
                self.contrainsBot?.constant = endFrame?.size.height ?? 0.0
                self.contrainsTop?.constant = (0 - (endFrame?.size.height)!)
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
