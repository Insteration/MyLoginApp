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
    
    func displayAlertMessage(messageToDisplay: String) {
        let alertController = UIAlertController(title: "Notifiction", message: messageToDisplay, preferredStyle: .alert)
        let OKAction = UIAlertAction(title: "OK", style: .default) { (action:UIAlertAction!) in }
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
        
        emailTextField.delegate = self
    }
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordLabel: UILabel!
    
    @IBAction func resetPasswordButton(_ sender: UIButton) {
        
        if data.emailPasswordCheckOnEmpty(emailTextField.text!) {
            if data.searchEmailInData(emailTextField.text!) {
                self.passwordLabel.text = data.outputPasswordFromData(emailTextField.text!)
                self.passwordLabel.isHidden = false
            } else {
                displayAlertMessage(messageToDisplay: dataMessage.emailAddressNotFound)
            }
        } else {
            displayAlertMessage(messageToDisplay: dataMessage.emailAddressNotFill)
        }
    }
    
    @IBAction func backToLoginViewControllerButton(_ sender: UIButton) {
        let storyboard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let loginViewController = storyboard.instantiateViewController(withIdentifier: "loginVC") as! LoginViewController
        loginViewController.data = data
        self.present(loginViewController, animated: true, completion: nil)
    }
    
}

extension AccountRecoveryViewController: UITextFieldDelegate {
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        
        if data.emailAddressCheck(emailTextField.text!) {
            self.emailTextField.layer.borderColor = UIColor.green.cgColor
            self.emailTextField.layer.borderWidth = 2
            self.emailTextField.layer.cornerRadius = 5
            return true
        } else {
            self.emailTextField.layer.borderColor = UIColor.red.cgColor
            self.emailTextField.layer.borderWidth = 2
            self.emailTextField.layer.cornerRadius = 5
        }
        return false
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == emailTextField {
            self.emailTextField.resignFirstResponder()
        }
        return true
    }
}
