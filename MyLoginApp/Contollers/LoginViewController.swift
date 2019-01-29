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
        //        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) {(action:UIAlertAction!) in }
        alertController.addAction(OKAction)
        //        alertController.addAction(cancelAction)
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
        userTextField[0].tag = 0
        userTextField[1].tag = 1
    }
    
    @IBOutlet var userTextField: [UITextField]!
    
    @IBAction func enterHomeButton(_ sender: UIButton) {
        
        let isPasswordCorrent = dataMethods.checkPasswordForCorrectInput(userTextField[1].text!)
        
        if isPasswordCorrent != true {
            displayAlertMessage(messageToDisplay: dataMessage.incorretLoginOrPassword)
        }
        
        if dataMethods.searchForAMatchInTheVault(userTextField[0].text!, userTextField[1].text!) == true {
            let storyboard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let homeViewController = storyboard.instantiateViewController(withIdentifier: "homeVC") as! HomeViewController
            homeViewController.data = data
            self.present(homeViewController, animated: true, completion: nil)
        } else {
            displayAlertMessage(messageToDisplay: dataMessage.incorretLoginOrPassword)
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
            data.count += 1

            displayAlertMessage(messageToDisplay: dataMessage.incorretLoginOrPassword)
            if data.count >= 2 {
                print("REGISTER REGISTER REGISTER!!!!")
            }
        }
        
    }
    
    
    //FIXME!
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        if let nextField = textField.superview?.viewWithTag(1) as? UITextField {
            nextField.becomeFirstResponder()
            if dataMethods.emailPasswordCheckOnEmpty(userTextField[1].text!) {
                performAction()
            }
        } else {
            textField.resignFirstResponder()
        }

        return false
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if dataMethods.emailAddressCheck(userTextField[0].text!) {
            self.userTextField[0].layer.borderColor = UIColor.green.cgColor
            self.userTextField[0].layer.borderWidth = 2
            self.userTextField[0].layer.cornerRadius = 5
        } else {
            self.userTextField[0].layer.borderColor = UIColor.red.cgColor
            self.userTextField[0].layer.borderWidth = 2
            self.userTextField[0].layer.cornerRadius = 5
        }
        
        if dataMethods.passwordCharacterCheck(userTextField[1].text!) {
            self.userTextField[1].layer.borderColor = UIColor.green.cgColor
            self.userTextField[1].layer.borderWidth = 2
            self.userTextField[1].layer.cornerRadius = 5
        } else {
            self.userTextField[1].layer.borderColor = UIColor.red.cgColor
            self.userTextField[1].layer.borderWidth = 2
            self.userTextField[1].layer.cornerRadius = 5
        }
        
        return true
    }
    
    //    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
    
    //        if data.emailAddressCheck(userTextField[0].text!) {
    //            self.userTextField[0].layer.borderColor = UIColor.green.cgColor
    //            self.userTextField[0].layer.borderWidth = 2
    //            self.userTextField[0].layer.cornerRadius = 5
    //            return true
    //        } else {
    //            self.userTextField[0].layer.borderColor = UIColor.red.cgColor
    //            self.userTextField[0].layer.borderWidth = 2
    //            self.userTextField[0].layer.cornerRadius = 5
    //            displayAlertMessage(messageToDisplay: dataMessage.emailAddressNotValid)
    //        }
    //        return false
    //    }
    
    
    //    func textFieldDidEndEditing(_ textField: UITextField) {
    //
    //        if data.passwordCharacterCheck(userTextField[1].text!) {
    //            self.userTextField[1].layer.borderColor = UIColor.green.cgColor
    //            self.userTextField[1].layer.borderWidth = 2
    //            self.userTextField[1].layer.cornerRadius = 5
    //        } else {
    //            self.userTextField[1].layer.borderColor = UIColor.red.cgColor
    //            self.userTextField[1].layer.borderWidth = 2
    //            self.userTextField[1].layer.cornerRadius = 5
    //        }
    //    }
}


