//
//  RegisterViewController.swift
//  MyLoginApp
//
//  Created by Artem Karmaz on 1/25/19.
//  Copyright © 2019 Johansson Group. All rights reserved.
//

import UIKit

class RegisterViewController: UIViewController {
    
    var data = Data()
    var dataMessage = DataMessage()
    var dataMethods = DataMethods()

    
    fileprivate func displayAlertMessage(messageToDisplay: String) {
        let alertController = UIAlertController(title: "Notification", message: messageToDisplay, preferredStyle: .alert)
        let OKAction = UIAlertAction(title: "OK", style: .default) { (action:UIAlertAction!) in }
        alertController.addAction(OKAction)
        self.present(alertController, animated: true, completion:nil)
    }
    
    fileprivate func accountCreateSuccessful(messageToDisplay: String) {
        let alertController = UIAlertController(title: "Complete", message: messageToDisplay, preferredStyle: .alert)
        let backToMainMenu = UIAlertAction(title: "Back to Main Menu", style: .default) { (action:UIAlertAction!) in
            self.backToMainMenu()
        }
        let returnAction = UIAlertAction(title: "Return", style: .cancel) { (action:UIAlertAction!) in }
        
        alertController.addAction(backToMainMenu)
        alertController.addAction(returnAction)
        self.present(alertController, animated: true, completion:nil)
    }
    
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    @objc func keyboardWillShow(notification: Notification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
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
        userTextField[2].delegate = self

    }
    
    @IBOutlet var userTextField: [UITextField]!
    
     func registerAccount() {
        if dataMethods.emailAddressCheck(userTextField[0].text!) {
            if dataMethods.passwordCharacterCheck(userTextField[1].text!) {
                if userTextField[1].text == userTextField[2].text {
                    _ = dataMethods.registerAccount(userTextField[0].text!, userTextField[1].text!)
                    accountCreateSuccessful(messageToDisplay: dataMessage.createAccountSuccesfull)
                } else {
                    displayAlertMessage(messageToDisplay: dataMessage.passwordNotMatch)
                }
            } else {
                displayAlertMessage(messageToDisplay: dataMessage.passwordNotFilled)
            }
        } else {
            displayAlertMessage(messageToDisplay: dataMessage.emailAddressNotValid)
        }
    }
    
    fileprivate func backToMainMenu() {
        let storyboard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let loginViewController = storyboard.instantiateViewController(withIdentifier: "loginVC") as! LoginViewController
        loginViewController.data = data
        self.present(loginViewController, animated: true, completion: nil)
    }
    
    @IBAction func registerButton(_ sender: UIButton) {
        registerAccount()
    }

    @IBAction func backButton(_ sender: UIButton) {
        backToMainMenu()
    }
}

extension RegisterViewController: UITextFieldDelegate {
    
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
        case userTextField[2]:
            if dataMethods.passwordCharacterCheck(userTextField[2].text!) {
                self.userTextField[2].layer.borderColor = UIColor.green.cgColor
                self.userTextField[2].layer.borderWidth = 2
                self.userTextField[2].layer.cornerRadius = 5
            } else {
                self.userTextField[2].layer.borderColor = UIColor.red.cgColor
                self.userTextField[2].layer.borderWidth = 2
                self.userTextField[2].layer.cornerRadius = 5
            }
        default:
            ()
        }
        return true
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        

        if textField == userTextField[0] {
            textField.resignFirstResponder()
            userTextField[1].becomeFirstResponder()
        } else if textField == userTextField[1] {
            textField.resignFirstResponder()
            userTextField[2].becomeFirstResponder()
        } else if textField == userTextField[2] {
            textField.resignFirstResponder()
            if dataMethods.emailPasswordCheckOnEmpty(userTextField[2].text!) {
                registerAccount()
            }
        }
        
        return false
    }
  
}
