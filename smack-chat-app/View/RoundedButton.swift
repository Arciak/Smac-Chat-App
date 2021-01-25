//
//  RoundedButton.swift
//  smack-chat-app
//
//  Created by Artur Zarzecki on 25/01/2021.
//  Copyright © 2021 Artur Zarzecki. All rights reserved.
//

import UIKit

@IBDesignable //to see changes in storyboard
class RoundedButton: UIButton {

    @IBInspectable var cornerRadius: CGFloat = 3.0 {
        didSet {//when we change instoryboard whts going to happen
            self.layer.cornerRadius = cornerRadius
        }
    }
    
    override func awakeFromNib() {//awake from nib state
        super.awakeFromNib()
        self.customizeView()
    }
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder() //create an interface builder
        self.customizeView()
    }
    
    func customizeView() {
        self.layer.cornerRadius = cornerRadius
    }
    
}
