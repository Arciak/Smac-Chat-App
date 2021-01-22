//
//  GradientView.swift
//  smack-chat-app
//
//  Created by Artur Zarzecki on 22/01/2021.
//  Copyright © 2021 Artur Zarzecki. All rights reserved.
//

import UIKit

@IBDesignable // render inside the storyboard, work in storyboard
class GradientView: UIView {
    
    // mamy gorny i dolny color i bedziemy go plynnie zemieiac (zmiana gradientu koloru)
    //@IBInspectable change inside of storyborad dynamiclly
    @IBInspectable var topColor: UIColor = #colorLiteral(red: 0.2901960784, green: 0.3019607843, blue: 0.8470588235, alpha: 1){
        didSet {
            self.setNeedsLayout()
        }
    }
    
    @IBInspectable var bottomColor: UIColor = #colorLiteral(red: 0.1725490196, green: 0.831372549, blue: 0.8470588235, alpha: 1) {
        didSet {
            self.setNeedsLayout()
        }
    }
    
    //creat our layou and add do UIView subclass
    override func layoutSubviews() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [topColor.cgColor, bottomColor.cgColor]
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 1, y: 1)
        gradientLayer.frame = self.bounds // it is equle to the size of the UIView
        self.layer.insertSublayer(gradientLayer, at: 0)
    }
}
