//
//  Constans.swift
//  smack-chat-app
//
//  Created by Artur Zarzecki on 22/01/2021.
//  Copyright © 2021 Artur Zarzecki. All rights reserved.
//

import Foundation
import Alamofire

typealias CompletionHandler = (_ Success: Bool) -> ()

//typealias Artur = String// remaped a type
//let name: Artur = "Artur"

//URL constans
let BASE_URL = "https://arturchat.herokuapp.com/v1/"
let URL_REGISTER = "\(BASE_URL)account/register/"
let URL_LOGIN = "\(BASE_URL)account/login/"
let URL_USER_ADD = "\(BASE_URL)user/add/"
let URL_USER_BY_EMAIL = "\(BASE_URL)/user/byEmail/"

//Colors

let smackPurplePlaceholder = #colorLiteral(red: 0.2588235294, green: 0.3294117647, blue: 0.7254901961, alpha: 0.5)

//Notification Constans
let NOTIF_USER_DATA_CHANGE = Notification.Name( "notifUserDataChanged")

//Segues

let TO_LOGIN = "toLogin"
let TO_CREAT_ACCOUNT = "toCreateAccount"
let UNWIND = "unwindToChannel"
let TO_AVATAR_PICKER = "toAvatarPicker"
let URL_GET_CHANNELS = "\(BASE_URL)channel/"


//User defaults
let TOKEN_KEY = "token"
let LOGGED_IN_KEY = "loggedIn"
let USER_EMAIL = "userEmail"


//Headres
let HEADER: HTTPHeaders = [
    "Content-Type": "application/json"
]

let BEARER_HEADER: HTTPHeaders = [ // from Header In Postman
    "Authorization": "Bearer \(AuthServices.instance.authToken)",
    "Content-Type": "application/json"
]

let FIND_BY_MAIL_HEADRE: HTTPHeaders = [
    "Authorization": "Bearer \(AuthServices.instance.authToken)"
]
