//
//  MessageService.swift
//  smack-chat-app
//
//  Created by Artur Zarzecki on 27/01/2021.
//  Copyright © 2021 Artur Zarzecki. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON


class MessageService {
    // singleton
    static let instance = MessageService()
    
    var channels = [Channel]()
    var selectedChannel : Channel?
    
    func findAllChannel(completion: @escaping CompletionHandler) {
        AF.request(URL_GET_CHANNELS, method: .get, headers: BEARER_HEADER).validate(statusCode: 200..<500).responseJSON { (response) in
            switch response.result {
            case .success:
                guard let data = response.data else { return }
                
//                do {
//                    self.channels = try JSONDecoder().decode([Channel].self, from: data)
//                } catch let error {
//                    debugPrint(error as Any)
//                }
//                print(self.channels)

                do {
                    let json = try JSON(data: data).arrayValue
                    print("przed pentla for")
                    //print("WTF:\(json)")
                    for item in json {
                        let name = item["name"].stringValue
                        let channelDescription = item["description"].stringValue
                        let id = item["_id"].stringValue
                        let channel = Channel(channelTitle: name, channelDescription: channelDescription, id: id)
                        self.channels.append(channel)
                    }
                    completion(true)
                    // add notification to let ChannelVC know: Hey I just pull out all the channels, so reload your tableView and display
                    NotificationCenter.default.post(name: NOTIF_CHANNELS_LOADED, object: nil)
                    print("Channels: \(self.channels)")
                } catch {
                    debugPrint(error as Any)
                }
            case .failure(_):
                print("FAILURE findUserByEmail")
                completion(false)
                debugPrint(response.error as Any)
            }
        }
    }
    
    // create function to desapire channels list when we are online
    func clearChannels() {
        // clearing out array of channels
        channels.removeAll()
    }
}
