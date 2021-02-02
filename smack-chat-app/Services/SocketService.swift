//
//  SocketService.swift
//  smack-chat-app
//
//  Created by Artur Zarzecki on 28/01/2021.
//  Copyright © 2021 Artur Zarzecki. All rights reserved.
//

import UIKit
import SocketIO

class SocketService: NSObject {
    
    // singleto
    static let instance = SocketService()
    var manager: SocketManager!
    var swiftSocket: SocketIOClient!
    
    
    override init() {
        super.init()
        
        self.manager = SocketManager(socketURL: URL(string: BASE_URL)!)
        self.swiftSocket = manager.defaultSocket
    }
    
    func establishConnection() {
        swiftSocket.connect()
        swiftSocket.on(clientEvent: .connect) {data, ack in
          print("SOCKET CONNECTED")
          print(data)
        }
    }
    func closeConnection() {
        swiftSocket.disconnect()
    }
    
    // function wich add channel and handling the addtion of channels via handling sockets. Reciving we have socket .on (API listing on event) sending socket .emit
    func addChannel(channelName: String, channelDescription: String, completion: @escaping CompletionHandler) {
        swiftSocket.emit("newChannel", channelName, channelDescription)
        completion(true)
        print("done addChannel")
    }
    
    func getChannel(completion: @escaping CompletionHandler) {
        print("in get channel")
        swiftSocket.on("channelCreated") { (dataArray, ack) in
            print("in get channel channelCreated")
            guard let channelName = dataArray[0] as? String else { return }// we cast it as a string becouse was Any type // we know that. Look at the API (mac-chat-api-> src-> index.js in io.emit)
            guard let channelDesc = dataArray[1] as? String else { return }
            guard let chanelId = dataArray[2] as? String else { return }
            
            let newChannel = Channel(channelTitle: channelName, channelDescription: channelDesc, id: chanelId)
            MessageService.instance.channels.append(newChannel)
            completion(true)
        }
    }
    
    func addMessage(messageBody: String, userId: String, channelId: String, completion: @escaping CompletionHandler) {
        let user = UserDataService.instance
        swiftSocket.emit("newMessage", messageBody, userId, channelId, user.name, user.avatarName, user.avatarColor)
        completion(true)
    }
    
    func getChatMessage(completion: @escaping (_ newMessage: Message) -> Void) {
        swiftSocket.on("messageCreated") { (dataArray, ack) in
            guard let msgBody = dataArray[0] as? String else { return }
            guard let channelId = dataArray[2] as? String else { return }
            guard let userName = dataArray[3] as? String else { return }
            guard let userAvatar = dataArray[4] as? String else { return }
            guard let userAvatarColor = dataArray[5] as? String else { return }
            guard let id = dataArray[6] as? String else { return }
            guard let timeStamp = dataArray[7] as? String else { return }
            
            let newMessage = Message(message: msgBody, userName: userName, channelId: channelId, userAvatar: userAvatar, userAvatarColor: userAvatarColor, id: id, timeStamp: timeStamp)
            
            completion(newMessage)
            
        }
    }
    
    func getTypingUsers(_ completionHendler: @escaping(_ typingUser: [String: String]) -> Void) {
        swiftSocket.on("userTypingUpdate") { (dataArray, ack) in
            guard let typingUsers = dataArray[0] as? [String: String] else { return }
            completionHendler(typingUsers) //pas into completion handler dictionary of typing users
        }
    }
    
    
    
    
    
}
