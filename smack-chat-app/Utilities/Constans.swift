//
//  Constans.swift
//  smack-chat-app
//
//  Created by Artur Zarzecki on 22/01/2021.
//  Copyright © 2021 Artur Zarzecki. All rights reserved.
//

import Foundation
import Alamofire

typealias ComplationHandler = (_ Success: Bool) -> ()

//typealias Artur = String// remaped a type
//let name: Artur = "Artur"

//URL constans
let BASE_URL = "https://arturchat.herokuapp.com/v1/"
let URL_REGISTER = "\(BASE_URL)account/register/"
let URL_LOGIN = "\(BASE_URL)account/login/"

//Segues

let TO_LOGIN = "toLogin"
let TO_CREAT_ACCOUNT = "toCreateAccount"
let UNWIND = "unwindToChannel"


//User defaults
let TOKEN_KEY = "token"
let LOGGED_IN_KEY = "loggedIn"
let USER_EMAIL = "userEmail"


//Headres
let HEADER: HTTPHeaders = [
    "Content-Type": "application/json"
]
