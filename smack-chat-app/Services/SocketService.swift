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
        print("done")
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
            print("done2")
        }
    }
}
