//
//  ViewController.swift
//  MyLoginApp
//
//  Created by Artem Karmaz on 1/24/19.
//  Copyright © 2019 Johansson Group. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    var data = Data()
    var dataMessage = DataMessage()
    var dataMethods = DataMethods()
    
    
    fileprivate func displayAlertMessage(messageToDisplay: String) {
        let alertController = UIAlertController(title: "Notifiction", message: messageToDisplay, preferredStyle: .alert)
        let OKAction = UIAlertAction(title: "OK", style: .default) { (action:UIAlertAction!) in }
        alertController.addAction(OKAction)
        self.present(alertController, animated: true, completion:nil)
    }
    
    fileprivate func displayAlertRegistrationMessage(messageToDisplay: String) {
        let alertController = UIAlertController(title: "Warning", message: messageToDisplay, preferredStyle: .alert)
        let registerAction = UIAlertAction(title: "Register", style: .default) { (action:UIAlertAction!) in
            self.registerAccount()
        }
        
        let recoverAction = UIAlertAction(title: "Recovery", style: .default) {(action:UIAlertAction!) in
            self.accountRecovery()
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) {(action:UIAlertAction!) in }
        
        alertController.addAction(registerAction)
        alertController.addAction(recoverAction)
        alertController.addAction(cancelAction)
        
        self.present(alertController, animated: true, completion:nil)
    }
    
    fileprivate func enterHome() {
        if dataMethods.searchForAMatchInTheVault(userTextField[0].text!, userTextField[1].text!) == true {
            let storyboard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let homeViewController = storyboard.instantiateViewController(withIdentifier: "homeVC") as! HomeViewController
            homeViewController.data = data
            self.present(homeViewController, animated: true, completion: nil)
        } else {
            data.userPushCount += 1
            if data.userPushCount >= 3 {
                displayAlertRegistrationMessage(messageToDisplay: dataMessage.registerRecoverAlert)
            } else {
                displayAlertMessage(messageToDisplay: dataMessage.incorretLoginOrPassword)
            }
        }
    }
    
    fileprivate func accountRecovery() {
        let storyboard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let accountRecoveryViewController = storyboard.instantiateViewController(withIdentifier: "recoveryVC") as! AccountRecoveryViewController
        accountRecoveryViewController.data = data
        self.present(accountRecoveryViewController, animated: true, completion: nil)
    }
    
    
    fileprivate func registerAccount() {
        let storyboard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let registerViewContoller = storyboard.instantiateViewController(withIdentifier: "registerVC") as! RegisterViewController
        registerViewContoller.data = data
        self.present(registerViewContoller, animated: true, completion: nil)
    }
    
    @objc fileprivate func dismissKeyboard() {
        view.endEditing(true)
    }
    
    @objc func keyboardWillShow(notification: Notification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            print("notification: Keyboard will show")
            if self.view.frame.origin.y == 0 {
                self.view.frame.origin.y -= keyboardSize.height / 4.5
            }
        }
        
    }
    
    @objc func keyboardWillHide(notification: Notification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y != 0 {
                self.view.frame.origin.y += keyboardSize.height / 4.5
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tap)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        userTextField[0].delegate = self
        userTextField[1].delegate = self

    }
    

    
    @IBOutlet var userTextField: [UITextField]!
    
    @IBAction func enterHomeButton(_ sender: UIButton) {
        enterHome()
    }
    
    @IBAction func accountRecoveryButton(_ sender: UIButton) {
        accountRecovery()
    }
    
    @IBAction func registerViewControllerButton(_ sender: UIButton) {
        registerAccount()
    }
    
}

extension LoginViewController: UITextFieldDelegate {
    
    func performAction() {
        if dataMethods.searchForAMatchInTheVault(userTextField[0].text!, userTextField[1].text!) == true {
            let storyboard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let homeViewController = storyboard.instantiateViewController(withIdentifier: "homeVC") as! HomeViewController
            homeViewController.data = data
            self.present(homeViewController, animated: true, completion: nil)
        } else {
            data.userPushCount += 1
            if data.userPushCount >= 3 {
                displayAlertRegistrationMessage(messageToDisplay: dataMessage.registerRecoverAlert)
            } else {
                displayAlertMessage(messageToDisplay: dataMessage.incorretLoginOrPassword)
            }
        }
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        if textField == userTextField[0] {
            textField.resignFirstResponder()
            userTextField[1].becomeFirstResponder()
        } else if textField == userTextField[1] {
            textField.resignFirstResponder()
            if dataMethods.emailPasswordCheckOnEmpty(userTextField[1].text!) {
                performAction()
            }
        }
        return false
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        switch textField {
        case userTextField[0]:
            if dataMethods.emailAddressCheck(userTextField[0].text!) {
                self.userTextField[0].layer.borderColor = UIColor.green.cgColor
                self.userTextField[0].layer.borderWidth = 2
                self.userTextField[0].layer.cornerRadius = 5
            } else {
                self.userTextField[0].layer.borderColor = UIColor.red.cgColor
                self.userTextField[0].layer.borderWidth = 2
                self.userTextField[0].layer.cornerRadius = 5
            }
        case userTextField[1]:
            if dataMethods.passwordCharacterCheck(userTextField[1].text!) {
                self.userTextField[1].layer.borderColor = UIColor.green.cgColor
                self.userTextField[1].layer.borderWidth = 2
                self.userTextField[1].layer.cornerRadius = 5
            } else {
                self.userTextField[1].layer.borderColor = UIColor.red.cgColor
                self.userTextField[1].layer.borderWidth = 2
                self.userTextField[1].layer.cornerRadius = 5
            }
        default:
            ()
        }
        return true
    }
}


