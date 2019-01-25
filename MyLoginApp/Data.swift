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
                print("Found email login in DataStorage! Matching a value by key!")
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
    
    func checkOnCorrectPassword(_ emailData: String, _ passwordData: String) -> Bool {
        
        return true
    }
    
    mutating func registerAccount(_ emailData: String, _ passwordData: String) {
        dataStorage.updateValue(passwordData, forKey: emailData)
        
        for i in dataStorage {
            print("Login = \(i.key), password = \(i.value)")
        }
    }
    
    func emailAddressCheck(_ emailAddress: String) -> Bool {
        
        var returnValue = true
        let emailRegEx = "[A-Z0-9a-z.-_]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,3}"
        
        do {
            let regularExpression = try NSRegularExpression(pattern: emailRegEx)
            let nsString = emailAddress as NSString
            let results = regularExpression.matches(in: emailAddress, range: NSRange(location: 0, length: nsString.length))
            
            if results.count == 0 {
                returnValue = false
            }
            
        } catch let error as NSError {
            print("invalid regular expression: \(error.localizedDescription)")
            returnValue = false
        }
        
        return  returnValue
    }
    
    func passwordCheck(_ password: String) -> Bool {
        
        var returnValue = true
        
        if password.isEmpty {
            returnValue = false
        }
        
        return returnValue
    }
}

extension String {
    func matches(_ regex: String) -> Bool {
        return self.range(of: regex, options: .regularExpression, range: nil, locale: nil) != nil
    }
}
