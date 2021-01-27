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
    
    let defaults = UserDefaults.standard // this is for simple things (create a user) like strings, boolen etc not images
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
    
    func registerUser(email: String, password: String, completion: @escaping CompletionHandler) {
        
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
                completion(true)
                print("Validation Successful")
            case let .failure(error):
                print(error)
                completion(false)
                debugPrint(response.error as Any)
            }
        }
    }
    
    func loginUser(email: String, password: String, completion: @escaping CompletionHandler) {
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
                    print("SwiftyJSON doesn't work in loginUser")
                }
            case .failure(_):
                completion(false)
                debugPrint(response.error as Any)
                
            }
        }
        
    }
    
    func createUser(name: String, email: String, avatarName: String, avatarColor: String, completion: @escaping CompletionHandler){
        
        let lowerCaseEmail = email.lowercased()
        struct BodyWebReq: Encodable {
            let name: String
            let email: String
            let avatarName: String
            let avatarColor: String
        }
        let addAccntBody = BodyWebReq(name: name, email: lowerCaseEmail, avatarName: avatarName, avatarColor: avatarColor)
        
        
        AF.request(URL_USER_ADD, method: .post, parameters: addAccntBody, encoder: JSONParameterEncoder.default, headers: BEARER_HEADER, interceptor: nil, requestModifier: nil).validate(statusCode: 200..<500).responseJSON{
            (response) in
            switch response.result {
            case .success:
                guard let data = response.data else { return }
                self.setUserInfo(data: data)
                completion(true)
            case .failure(_):
                print("FAILURE")
                completion(false)
                debugPrint(response.error as Any)
            }
        }
        
    }
    
    func findUserByEmail(completion: @escaping CompletionHandler) {
        
        AF.request("\(URL_USER_BY_EMAIL)\(userEmail)", method: .get, headers: FIND_BY_MAIL_HEADRE).validate(statusCode: 200..<500).responseJSON { (response) in
            switch response.result {
            case .success:
                guard let data = response.data else { return }
                self.setUserInfo(data: data)
                completion(true)
            case .failure(_):
                print("FAILURE findUserByEmail")
                completion(false)
                debugPrint(response.error as Any)
            }
        }
    }
    
    func setUserInfo(data: Data) {
        do {
            let json = try JSON(data: data)
            let id = json["_id"].stringValue
            let color = json["avatarColor"].stringValue
            let avatarName = json["avatarName"].stringValue
            let email = json["email"].stringValue
            let name = json["name"].stringValue
            UserDataService.instance.setUserData(id: id, color: color, avatarName: avatarName, email: email, name: name)
        } catch {
            print("SwiftyJSON doesn't work in createUser")
        }
    }
    
}
