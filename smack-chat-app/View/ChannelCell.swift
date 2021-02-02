//
//  ChannelCell.swift
//  smack-chat-app
//
//  Created by Artur Zarzecki on 27/01/2021.
//  Copyright © 2021 Artur Zarzecki. All rights reserved.
//

import UIKit

class ChannelCell: UITableViewCell {
    
    // Outlets
    @IBOutlet weak var channelName: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state. What does the view look like for any of the rose table been selected
        if selected {
            self.layer.backgroundColor = (UIColor(white: 1, alpha: 0.2).cgColor)
        } else {
            self.layer.backgroundColor = UIColor.clear.cgColor
        }
    }
    
    func configureCell(channel: Channel) {
        let title = channel.channelTitle ?? "" //if you cant find value return empty string
        channelName.text = "#\(title)"
        
        // check unread channels and make font bold and larger
        channelName.font = UIFont(name: "HelveticaNeue-Regular", size: 17)
        
        for id in MessageService.instance.unreadChannels {
            if (id as String) == String(channel.id) {
                channelName.font = UIFont(name: "HelveticaNeue-Bold", size: 22)
                channelName.text = "#\(title) nowe "
            }
        }
    }
}
