//
//  Data.swift
//  MyLoginApp
//
//  Created by Artem Karmaz on 1/24/19.
//  Copyright © 2019 Johansson Group. All rights reserved.
//

import Foundation

struct Data {
    
    var dataStorage: [String: String] = ["inste@icloud.com": "123456", "inste@me.com": "112233", "admin": "admin"]
    
    func searchForAMatchInTheVault(_ emailData: String, _ passwordData: String) -> Bool {
        for search in dataStorage {
            if search.key == emailData {
                if search.value == passwordData {
                    print("Login = \(search.key), password = \(search.value)")
                    print("Success!")
                    return true
                }
            }
        }
        print("Not found matches in Storage!")
        return false
    }
    
    func searchEmailInData(_ emailData: String) -> Bool {
        
        for search in dataStorage {
            if search.key == emailData {
                return true
            }
        }
        return false
    }
    
    func outputPasswordFromData(_ emailData: String) -> String {
        for search in dataStorage {
            if search.key == emailData {
                return search.value
            }
        }
        
        return "Not found password"
    }
    
    mutating func registerAccount(_ emailData: String, _ passwordData: String) {
        dataStorage.updateValue(passwordData, forKey: emailData)
        
        for i in dataStorage {
            print("Login = \(i.key), password = \(i.value)")
        }
    }
    
    func emailAddressCheck(_ emailAddress: String) -> Bool {
        
        let emailRegEx = "[A-Z0-9a-z.-_]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,3}"
        
        do {
            let regularExpression = try NSRegularExpression(pattern: emailRegEx)
            let nsString = emailAddress as NSString
            let results = regularExpression.matches(in: emailAddress, range: NSRange(location: 0, length: nsString.length))
            
            if results.count == 0 {
                return false
            }
            
        } catch let error as NSError {
            print("invalid regular expression: \(error.localizedDescription)")
            return false
        }
        return true
    }
    
    func passwordCharacterCheck(_ userPassword: String) -> Bool {
        
        let passwordRegEx = "^(?=.*[A-Za-z])(?=.*\\d)[A-Za-z\\d]{6,}$"
        
        do {
            let regularExpression = try NSRegularExpression(pattern: passwordRegEx)
            let nsString = userPassword as NSString
            let results = regularExpression.matches(in: userPassword, range: NSRange(location: 0, length: nsString.length))
            
            if results.count == 0 {
                return false
            }
            
        } catch let error as NSError {
            print("invalid regular expression: \(error.localizedDescription)")
            return false
        }
        return true
    }
    
    func emailPasswordCheckOnEmpty(_ emailPassword: String) -> Bool {
        if emailPassword.isEmpty {
            print("Password field is empty!")
            return false
        }
        return true
    }
    
    func checkPasswordForCorrectInput(_ password: String) -> Bool {
        for i in dataStorage {
            if i.value == password {
                print("Password entered correctly!")
                return true
            }
        }
        return false
    }
}
