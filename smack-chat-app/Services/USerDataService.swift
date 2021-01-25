//
//  USerDataService.swift
//  smack-chat-app
//
//  Created by Artur Zarzecki on 25/01/2021.
//  Copyright © 2021 Artur Zarzecki. All rights reserved.
//

import Foundation

class UserDataService {
    // ta klasa takze bedzie singletonem
    static let instance = UserDataService()
    
    //create variebles which are in Postmen-> Add user
    
    public private(set) var id = "" //oder classes can look at it
    public private(set) var avatarColor = ""
    public private(set) var avatarName = ""
    public private(set) var email = ""
    public private(set) var name = ""
    
    func setUserData(id: String, color: String, avatarName: String, email: String, name: String) {
        self.id = id
        self.avatarColor = color
        self.avatarName = avatarName
        self.email = email
        self.name = name
    }
    
    func setAvatarName(avatarName: String) {
        self.avatarName = avatarName
    }
}
