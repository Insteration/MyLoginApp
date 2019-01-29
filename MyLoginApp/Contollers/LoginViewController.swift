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
    
    
    func displayAlertMessage(messageToDisplay: String) {
        let alertController = UIAlertController(title: "Notifiction", message: messageToDisplay, preferredStyle: .alert)
        let OKAction = UIAlertAction(title: "OK", style: .default) { (action:UIAlertAction!) in }
        alertController.addAction(OKAction)
        self.present(alertController, animated: true, completion:nil)
    }
    
    func displayAlertRegistrationMessage(messageToDisplay: String) {
        let alertController = UIAlertController(title: "Warning", message: messageToDisplay, preferredStyle: .alert)
        let registerAction = UIAlertAction(title: "Register", style: .default) { (action:UIAlertAction!) in
            let storyboard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let registerViewContoller = storyboard.instantiateViewController(withIdentifier: "registerVC") as! RegisterViewController
            registerViewContoller.data = self.data
            self.present(registerViewContoller, animated: true, completion: nil)
        }
        
        let recoverAction = UIAlertAction(title: "Recovery", style: .default) {(action:UIAlertAction!) in
            let storyboard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let accountRecoveryViewController = storyboard.instantiateViewController(withIdentifier: "recoveryVC") as! AccountRecoveryViewController
            accountRecoveryViewController.data = self.data
            self.present(accountRecoveryViewController, animated: true, completion: nil)
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) {(action:UIAlertAction!) in }
        
        alertController.addAction(registerAction)
        alertController.addAction(recoverAction)
        alertController.addAction(cancelAction)
        self.present(alertController, animated: true, completion:nil)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tap)
        
        NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillShowNotification, object: nil, queue: nil)
        {nc in self.view.frame.origin.y = -85}
        
        NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillHideNotification, object: nil, queue: nil)
        {nc in self.view.frame.origin.y = 0}
        
        userTextField[0].delegate = self
        userTextField[1].delegate = self

    }
    
    @IBOutlet var userTextField: [UITextField]!
    
    @IBAction func enterHomeButton(_ sender: UIButton) {
        
        //        let isPasswordCorrent = dataMethods.checkPasswordForCorrectInput(userTextField[1].text!)
        //
        //        if isPasswordCorrent != true {
        //
        //            displayAlertMessage(messageToDisplay: dataMessage.dataNilMessage)
        //        }
        
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
    
    @IBAction func accountRecoveryButton(_ sender: UIButton) {
        let storyboard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let accountRecoveryViewController = storyboard.instantiateViewController(withIdentifier: "recoveryVC") as! AccountRecoveryViewController
        accountRecoveryViewController.data = data
        self.present(accountRecoveryViewController, animated: true, completion: nil)
    }
    
    
    @IBAction func registerViewControllerButton(_ sender: UIButton) {
        let storyboard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let registerViewContoller = storyboard.instantiateViewController(withIdentifier: "registerVC") as! RegisterViewController
        registerViewContoller.data = data
        self.present(registerViewContoller, animated: true, completion: nil)
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


