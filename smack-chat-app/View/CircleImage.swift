//
//  CircleImage.swift
//  smack-chat-app
//
//  Created by Artur Zarzecki on 26/01/2021.
//  Copyright © 2021 Artur Zarzecki. All rights reserved.
//

import UIKit

@IBDesignable
class CircleImage: UIImageView {

    override func awakeFromNib() {
        self.customizeView()
    }
    
    func customizeView() {
        self.layer.cornerRadius = self.frame.width/2
        self.clipsToBounds = true
    }
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        self.customizeView()
    }

}
