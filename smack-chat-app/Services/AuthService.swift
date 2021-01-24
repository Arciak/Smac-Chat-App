//
//  AuthService.swift
//  smack-chat-app
//
//  Created by Artur Zarzecki on 24/01/2021.
//  Copyright © 2021 Artur Zarzecki. All rights reserved.
//

import Foundation
import Alamofire

// is going to handle all reguster usrers functions

class AuthServices {
    
    //tworzymy singleton
    static let instance = AuthServices()
    
    let defaults = UserDefaults.standard // this is for simple things like strings, boolen etc not images
    var isLoggedIn : Bool {
        get {
            return defaults.bool(forKey: LOGGED_IN_KEY)
        }
        set {
            defaults.set(newValue, forKey: LOGGED_IN_KEY) // newValue say, whatever it is set it
        }
    }
    
    var authToken : String {
        get {
            return defaults.value(forKey: TOKEN_KEY) as! String //casted as a key
        }
        set {
            defaults.set(newValue, forKey: TOKEN_KEY)
        }
    }
    
    var userEmail: String {
        get {
            return defaults.value(forKey: USER_EMAIL) as! String //casted as a key
        }
        set {
            defaults.set(newValue, forKey: USER_EMAIL)
        }
    }
    
    // create register user function. Using Alamofire (make web request easier) is build on top of apple URL session framwork
    
    func registerUser(email: String, password: String, complation: @escaping ComplationHandler) {
        
        let lowerCaseEmail = email.lowercased()
        let header: HTTPHeaders = [
            "Content-Type": "application/json; charset=utf-8"
        ]
        
        let body: [String: Any] = [
            "emial": lowerCaseEmail,
            "password": password
        ]
        
        //creat a web request
        AF.request(URL_REGISTER, method: .post, parameters: body, encoding: JSONEncoding.default, headers: header, interceptor: nil, requestModifier: nil).responseString { (response) in
            switch response.result {
            case .success:
                print("Validation Successful")
                complation(true)
            case let .failure(error):
                print(error)
                complation(false)
                debugPrint(response.error as Any)
            }
        }
    }
    
}
