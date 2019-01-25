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
        let alertController = UIAlertController(title: "Alert", message: messageToDisplay, preferredStyle: .alert)
        let OKAction = UIAlertAction(title: "OK", style: .default) { (action:UIAlertAction!) in
            // Code in this block will trigger when OK button tapped.
            print("Ok button tapped");
        }
        alertController.addAction(OKAction)
        self.present(alertController, animated: true, completion:nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
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
        
        if isEmailAddressValid {
            print("Email ok!")
        } else {
            print("Email not ok")
            displayAlertMessage(messageToDisplay: "Email address is not valid")
        }
        
        if data.searchForAMatchInTheVault(userTextField[0].text!, userTextField[1].text!) == true {
        let storyboard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let homeViewController = storyboard.instantiateViewController(withIdentifier: "homeVC") as! HomeViewController
        homeViewController.data = data
        self.present(homeViewController, animated: true, completion: nil)
    
        }

    }
    
    @IBAction func printDataButton(_ sender: UIButton) {
        print(data.dataStorage)
    }
}

extension LoginViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == userTextField[0] || textField == userTextField[1] {
            self.userTextField[0].resignFirstResponder()
            self.userTextField[1].resignFirstResponder()
        }
        return true
    }

}


