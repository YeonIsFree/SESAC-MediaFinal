//
//  UserProfile.swift
//  SESAC-MediaFinal
//
//  Created by Seryun Chun on 2024/02/08.
//

import Foundation

class UserDefaultManager {
    
    private init() { }
    
    static let shared = UserDefaultManager()
    
    let ud = UserDefaults.standard
    
    // 1: name
    // 2: nickname
    // 3: aboutMe
    
    var name: String {
        get { return UserDefaultManager.shared.ud.string(forKey: "name") ?? "" }
        set { UserDefaultManager.shared.ud.set(newValue, forKey: "name") }
    }
    
    var nickname: String {
        get { return UserDefaultManager.shared.ud.string(forKey: "nickname") ?? "" }
        set { UserDefaultManager.shared.ud.set(newValue, forKey: "nickname") }
    }
    
    var aboutMe: String {
        get { return UserDefaultManager.shared.ud.string(forKey: "aboutMe") ?? "" }
        set { UserDefaultManager.shared.ud.set(newValue, forKey: "aboutMe") }
    }
}
