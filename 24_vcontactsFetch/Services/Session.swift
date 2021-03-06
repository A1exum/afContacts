//
//  Session.swift
//  24-oauthVK
//
//  Created by admin on 30.05.22.
//


import Foundation
import SwiftKeychainWrapper

//Service -> business logic -> manage token
final class Session {
    
    private init() {}
    
    static let shared = Session() //Global memory + contant -> shared object
    
    var token: String {
        get{
            return KeychainWrapper.standard.string(forKey: "token") ?? ""
        }
        set{
            KeychainWrapper.standard.set(newValue, forKey: "token")
            
        }
    }
    
    var userId: Int {
        get {
            return UserDefaults.standard.integer(forKey: "userId")
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "userId")
        }
    }
    
    var expiresIn: Int {
        get {
            return UserDefaults.standard.integer(forKey: "expiresIn")
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "expiresIn")
        }
    }

    static var isValid: Bool {
        
        var expiresIn = UserDefaults.standard.integer(forKey: "expiresIn")
        guard expiresIn > 0 else { return false }
        //UTC
        var tokenDate = Date(timeIntervalSinceNow: Double(expiresIn))
        var currentDate = Date()
        print("tokenDate",tokenDate)
        print("currentDate", currentDate)
        return (currentDate < tokenDate)
    }
    
    

}
