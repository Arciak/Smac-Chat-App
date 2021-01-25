//
//  AuthService.swift
//  smack-chat-app
//
//  Created by Artur Zarzecki on 24/01/2021.
//  Copyright © 2021 Artur Zarzecki. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

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
        
        struct BodyWebReq: Encodable {
            let email: String
            let password: String
        }
        
        //creat a web request

        let login = BodyWebReq(email: lowerCaseEmail, password: password)
        
        AF.request(URL_REGISTER, method: .post, parameters: login, encoder: JSONParameterEncoder.default, headers: HEADER).validate(statusCode: 200..<500).responseString { (response) in
            switch response.result {
            case .success:
                complation(true)
                print("Validation Successful")
            case let .failure(error):
                print(error)
                complation(false)
                debugPrint(response.error as Any)
            }
        }
    }
    
    func loginUser(email: String, password: String, completion: @escaping ComplationHandler) {
        let lowerCaseEmail = email.lowercased()

        struct BodyWebReq: Encodable {
            let email: String
            let password: String
        }
        let register = BodyWebReq(email: lowerCaseEmail, password: password)
        
        AF.request(URL_LOGIN, method: .post, parameters: register, encoder: JSONParameterEncoder.default, headers: HEADER, interceptor: nil, requestModifier: nil).validate(statusCode: 200..<500).responseJSON {
            (response) in
            switch response.result {
            case .success:
                // reciving date from API
                
                //clasic way 
//                if let json = response.value as? Dictionary<String, Any>{//as? means cast tahat as
//                    if let email = json["user"] as? String{// zobacz w Postman ze mail jest przypisany do user
//                        self.userEmail = email
//                    }
//                    if let token = json["token"] as? String {// token tez jest z postman
//                        self.authToken = token
//                    }
//                }
                //Using SwiftyJSON
                guard let data = response.data else { return }
                do{
                    print("In")
                    let json = try SwiftyJSON.JSON(data: data)//swiftyJSON object
                    self.userEmail = json["user"].stringValue
                    self.authToken = json["token"].stringValue
                    
                    self.isLoggedIn = true
                    completion(true)
                } catch {
                    print("SwiftyJSON doesn't work")
                }
            case .failure(_):
                completion(false)
                debugPrint(response.error as Any)
                
            }
        }
        
    }
    
}
