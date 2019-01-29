//
//  AccountRecoveryViewController.swift
//  MyLoginApp
//
//  Created by Artem Karmaz on 1/28/19.
//  Copyright © 2019 Johansson Group. All rights reserved.
//

import UIKit

class AccountRecoveryViewController: UIViewController {
    
    var data = Data()
    var dataMessage = DataMessage()
    var dataMethods = DataMethods()
    
    fileprivate func displayAlertMessage(messageToDisplay: String) {
        let alertController = UIAlertController(title: "Notifiction", message: messageToDisplay, preferredStyle: .alert)
        let OKAction = UIAlertAction(title: "OK", style: .default) { (action:UIAlertAction!) in }
        alertController.addAction(OKAction)
        self.present(alertController, animated: true, completion:nil)
    }
    
    fileprivate func resetPassword() {
        if dataMethods.emailPasswordCheckOnEmpty(emailTextField.text!) {
            if dataMethods.searchEmailInData(emailTextField.text!) {
                displayAlertMessage(messageToDisplay: dataMessage.passwordRecovery + dataMethods.outputPasswordFromData(emailTextField.text!))
            } else {
                displayAlertMessage(messageToDisplay: dataMessage.emailAddressNotFound)
            }
        } else {
            displayAlertMessage(messageToDisplay: dataMessage.emailAddressNotFill)
        }
    }
    
    fileprivate func backToLogin() {
        let storyboard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let loginViewController = storyboard.instantiateViewController(withIdentifier: "loginVC") as! LoginViewController
        loginViewController.data = data
        self.present(loginViewController, animated: true, completion: nil)
    }
    
    @objc fileprivate func dismissKeyboard() {
        view.endEditing(true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tap)
        
        NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillShowNotification, object: nil, queue: nil)
        {nc in self.view.frame.origin.y = -30}
        
        NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillHideNotification, object: nil, queue: nil)
        {nc in self.view.frame.origin.y = 0}
        
        
        emailTextField.delegate = self
    }
    
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBAction func resetPasswordButton(_ sender: UIButton) {
        resetPassword()
    }
    
    @IBAction func backToLoginViewControllerButton(_ sender: UIButton) {
        backToLogin()
    }
}

extension AccountRecoveryViewController: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if dataMethods.emailAddressCheck(emailTextField.text!) {
            self.emailTextField.layer.borderColor = UIColor.green.cgColor
            self.emailTextField.layer.borderWidth = 2
            self.emailTextField.layer.cornerRadius = 5
        } else {
            self.emailTextField.layer.borderColor = UIColor.red.cgColor
            self.emailTextField.layer.borderWidth = 2
            self.emailTextField.layer.cornerRadius = 5
        }
        return true
    }
 
     func textFieldShouldReturn(_ textField: UITextField) -> Bool {

        if textField == emailTextField {
        textField.resignFirstResponder()
        self.resetPassword()
        }
        return false
    }
}
