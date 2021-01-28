//
//  MessageService.swift
//  smack-chat-app
//
//  Created by Artur Zarzecki on 28/01/2021.
//  Copyright © 2021 Artur Zarzecki. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON


class MessageService {
    // singleton
    static let instance = MessageService()
    
    var channels = [Channel]()
    
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
                    for item in json {
                        let name = item["name"].stringValue
                        let channelDescription = item["description"].stringValue
                        let id = item["_id"].stringValue
                        let channel = Channel(channelTitle: name, channelDescription: channelDescription, id: id)
                        completion(true)
                        self.channels.append(channel)
                    }
                    print(self.channels)
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
}
