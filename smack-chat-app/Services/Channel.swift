//
//  Channel.swift
//  smack-chat-app
//
//  Created by Artur Zarzecki on 28/01/2021.
//  Copyright © 2021 Artur Zarzecki. All rights reserved.
//

import Foundation

struct Channel : Decodable {

//    public private (set) var _id: String!
//    public private (set) var name: String!
//    public private (set) var description: String!
//    public private (set) var __v: Int?
    
    public private (set) var channelTitle: String!
    public private (set) var channelDescription: String!
    public private (set) var id: String!
    
}

