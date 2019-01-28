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
    
    func displayAlertMessage(messageToDisplay: String) {
        let alertController = UIAlertController(title: "Notification", message: messageToDisplay, preferredStyle: .alert)
        let OKAction = UIAlertAction(title: "OK", style: .default) { (action:UIAlertAction!) in
        }
        alertController.addAction(OKAction)
        self.present(alertController, animated: true, completion:nil)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tap)
        
        userTextField[0].delegate = self
        userTextField[1].delegate = self
        userTextField[2].delegate = self
    }
    
    @IBOutlet var userTextField: [UITextField]!
    
    @IBAction func registerButton(_ sender: UIButton) {
        
        let isEmailAddressValid = data.emailAddressCheck(userTextField[0].text!)

        if isEmailAddressValid {
            print("Email ok!")
            
            
            if userTextField[1].text == userTextField[2].text {
            _ = data.registerAccount(userTextField[0].text!, userTextField[1].text!)
                displayAlertMessage(messageToDisplay: "Your account has been successfully registered, return to the main menu and log in with your account.")
            } else {
                print("Passwords do not match")
                displayAlertMessage(messageToDisplay: "Passwords do not match, check the correctness of input")
            }
        } else {
            print("Email not ok")
            displayAlertMessage(messageToDisplay: "Email address is not valid!")
        }
        
    }
    
    @IBAction func backButton(_ sender: UIButton) {
        let storyboard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let loginViewController = storyboard.instantiateViewController(withIdentifier: "loginVC") as! LoginViewController
        loginViewController.data = data
        self.present(loginViewController, animated: true, completion: nil)
    }
    
    
}

extension RegisterViewController: UITextFieldDelegate {
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if data.emailAddressCheck(userTextField[0].text!) {
            self.userTextField[0].layer.borderColor = UIColor.green.cgColor
            self.userTextField[0].layer.borderWidth = 2
            self.userTextField[0].layer.cornerRadius = 5
        } else {
            self.userTextField[0].layer.borderColor = UIColor.red.cgColor
            self.userTextField[0].layer.borderWidth = 2
            self.userTextField[0].layer.cornerRadius = 5
        }
        
        if data.passwordCharacterCheck(userTextField[1].text!) {
            self.userTextField[1].layer.borderColor = UIColor.green.cgColor
            self.userTextField[1].layer.borderWidth = 2
            self.userTextField[1].layer.cornerRadius = 5
        } else {
            self.userTextField[1].layer.borderColor = UIColor.red.cgColor
            self.userTextField[1].layer.borderWidth = 2
            self.userTextField[1].layer.cornerRadius = 5
        }
        
        if data.passwordCharacterCheck(userTextField[2].text!) {
            self.userTextField[2].layer.borderColor = UIColor.green.cgColor
            self.userTextField[2].layer.borderWidth = 2
            self.userTextField[2].layer.cornerRadius = 5
        } else {
            self.userTextField[2].layer.borderColor = UIColor.red.cgColor
            self.userTextField[2].layer.borderWidth = 2
            self.userTextField[2].layer.cornerRadius = 5
        }
    }
 
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == userTextField[0] || textField == userTextField[1] || textField == userTextField[2] {
            self.userTextField[0].resignFirstResponder()
            self.userTextField[1].resignFirstResponder()
            self.userTextField[2].resignFirstResponder()
        }
        return true
    }
    
}
