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
    
    func displayAlertMessage(messageToDisplay: String) {
        let alertController = UIAlertController(title: "Notifiction", message: messageToDisplay, preferredStyle: .alert)
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
        
        NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillShowNotification, object: nil, queue: nil)
        {nc in self.view.frame.origin.y = +200}
        
        NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillHideNotification, object: nil, queue: nil)
        {nc in self.view.frame.origin.y = 0}
        
        userTextField[0].delegate = self
        userTextField[1].delegate = self
    }
    
    @IBOutlet var userTextField: [UITextField]!
    
    @IBAction func enterHomeButton(_ sender: UIButton) {
        
        let isEmailAddressValid = data.emailAddressCheck(userTextField[0].text!)
        let isPasswordValid = data.passwordCheck(userTextField[1].text!)
        let isPasswordCorrent = data.checkPasswordForCorrectInput(userTextField[1].text!)
        
        if isEmailAddressValid {
            print("Email valid is ok!")
        } else {
            print("Email not valid")
            displayAlertMessage(messageToDisplay: "Email address is not valid!")
        }
        
        if isPasswordValid {
            print("Password valid is ok!")
        } else {
            print("Password not valid")
            displayAlertMessage(messageToDisplay: "Password is not filled!")
        }
        
        if isPasswordCorrent {
            print("Password correct!")
        } else {
            print("Password contains errors")
            displayAlertMessage(messageToDisplay: "Incorrect login or password!")
        }
        
        if data.searchForAMatchInTheVault(userTextField[0].text!, userTextField[1].text!) == true {
            let storyboard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let homeViewController = storyboard.instantiateViewController(withIdentifier: "homeVC") as! HomeViewController
            homeViewController.data = data
            self.present(homeViewController, animated: true, completion: nil)
            
        }
    }

}

extension LoginViewController: UITextFieldDelegate {
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == userTextField[0] || textField == userTextField[1] {
            self.userTextField[0].resignFirstResponder()
            self.userTextField[1].resignFirstResponder()
        }
        return true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        
        if data.emailAddressCheck(userTextField[0].text!) {
            self.userTextField[0].layer.borderColor = UIColor.green.cgColor
            self.userTextField[0].layer.borderWidth = 2
            self.userTextField[0].layer.cornerRadius = 5
            return true
        } else {
            self.userTextField[0].layer.borderColor = UIColor.red.cgColor
            self.userTextField[0].layer.borderWidth = 2
            self.userTextField[0].layer.cornerRadius = 5
        }
        
        return false
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        if data.passwordCharacterCheck(userTextField[1].text!) {
            self.userTextField[1].layer.borderColor = UIColor.green.cgColor
            self.userTextField[1].layer.borderWidth = 2
            self.userTextField[1].layer.cornerRadius = 5
        } else {
            self.userTextField[1].layer.borderColor = UIColor.red.cgColor
            self.userTextField[1].layer.borderWidth = 2
            self.userTextField[1].layer.cornerRadius = 5
        }
    }
}


