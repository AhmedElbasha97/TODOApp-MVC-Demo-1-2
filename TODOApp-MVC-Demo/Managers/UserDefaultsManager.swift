//
//  UserDefaultsManager.swift
//  TODOApp-MVC-Demo
//
//  Created by ahmedelbash on 10/27/20.
//  Copyright © 2020 IDEAEG. All rights reserved.
//

import Foundation


class UserDefaultsManager {
    
    // MARK:- Singleton
    private static let sharedInstance = UserDefaultsManager()
    
    class func shared() -> UserDefaultsManager {
        return UserDefaultsManager.sharedInstance
    }
    
    // MARK:- Properties
    var token: String? {
        set {
            UserDefaults.standard.set(newValue, forKey: UserDefaultsKeys.token)
        }
        get {
            guard UserDefaults.standard.object(forKey: UserDefaultsKeys.token) != nil else {
                return nil
            }
            return UserDefaults.standard.string(forKey: UserDefaultsKeys.token)!
        }
    }
    var setTheState: Bool? {
        set {
            UserDefaults.standard.set(newValue, forKey: UserDefaultsKeys.setTheState)
        }
        get {
            guard UserDefaults.standard.object(forKey: UserDefaultsKeys.setTheState) != nil else {
                return nil
            }
            return UserDefaults.standard.bool(forKey: UserDefaultsKeys.setTheState)
        }
    }

}
