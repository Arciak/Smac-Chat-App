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
    
    func returnUIColor(components: String) -> UIColor {
       // "[0.5254901960784314, 0.8509803921568627, 0.4627450980392157, 1]", convert this kind of string to actuall values of color
        let scanner = Scanner(string: components)
        let skipped = CharacterSet(charactersIn: "[], ") //we add 4 chars like squer brackets[] coma, and space  which we skipped them durong scanning
        let comma = CharacterSet(charactersIn: ",")// when is comma scaninig stop
        scanner.charactersToBeSkipped = skipped
        
        var r, g, b, a : NSString?
        
        r = scanner.scanUpToCharacters(from: comma) as NSString? // we scan up to comma ignore varaiables from skipped and stop at comma
        g = scanner.scanUpToCharacters(from: comma) as NSString?
        b = scanner.scanUpToCharacters(from: comma) as NSString?
        a = scanner.scanUpToCharacters(from: comma) as NSString?
        
        let defaultColor = UIColor.lightGray
        guard let rUnwrapped = r else{ return defaultColor }
        guard let gUnwrapped = g else{ return defaultColor }
        guard let bUnwrapped = b else{ return defaultColor }
        guard let aUnwrapped = a else{ return defaultColor }
        
        let rfloat = CGFloat(rUnwrapped.doubleValue)// convert String to double value and letetr convert to CGFloat
        let gfloat = CGFloat(gUnwrapped.doubleValue)
        let bfloat = CGFloat(bUnwrapped.doubleValue)
        let afloat = CGFloat(aUnwrapped.doubleValue)
        
        let newUIColor = UIColor(red: rfloat, green: gfloat, blue: bfloat, alpha: afloat)
        
        return newUIColor
    }
    
    func logoutUser() {
        id = ""
        avatarName = ""
        avatarColor = ""
        email = ""
        name = ""
        AuthServices.instance.isLoggedIn = false
        AuthServices.instance.userEmail = ""
        AuthServices.instance.authToken = ""
    }
    
    
    
    
}
